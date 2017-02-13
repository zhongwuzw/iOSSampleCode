//
//  ZWCoordinateQuadTree.m
//  ZWAnnotationClustering
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCoordinateQuadTree.h"
#import "ZWClusterAnnotation.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

ZWQuadTreeNodeData TBDataFromLine(NSString *line)
{
    NSArray *components = [line componentsSeparatedByString:@","];
    double latitude = [components[1] doubleValue];
    double longitude = [components[0] doubleValue];

    ZWHotelInfo* hotelInfo = (ZWHotelInfo*)malloc(sizeof(ZWHotelInfo));
    
    if (hotelInfo != NULL) {
        NSString *hotelName = [components[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        hotelInfo->hotelName = (char *)malloc(sizeof(char) * hotelName.length + 1);
        if (hotelInfo->hotelName != NULL) {
            strncpy(hotelInfo->hotelName, [hotelName UTF8String], hotelName.length + 1);
        }
        
        NSString *hotelPhoneNumber = [components[4] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        hotelInfo->hotelPhoneNumber = (char *)malloc(sizeof(char) * hotelPhoneNumber.length + 1);
        if (hotelInfo->hotelPhoneNumber != NULL) {
            strncpy(hotelInfo->hotelPhoneNumber, [hotelPhoneNumber UTF8String], hotelPhoneNumber.length + 1);
        }
        
    }

    return ZWQuadTreeNodeDataMake(latitude, longitude, hotelInfo);
}

ZWBoundingBox ZWBoundingBoxForMapRect(BMKMapRect mapRect)
{
    CLLocationCoordinate2D topLeft = BMKCoordinateForMapPoint(mapRect.origin);
    CLLocationCoordinate2D botRight = BMKCoordinateForMapPoint(BMKMapPointMake(BMKMapRectGetMaxX(mapRect), BMKMapRectGetMaxY(mapRect)));

    CLLocationDegrees minLat = botRight.latitude;
    CLLocationDegrees maxLat = topLeft.latitude;

    CLLocationDegrees minLon = topLeft.longitude;
    CLLocationDegrees maxLon = botRight.longitude;

    return ZWBoundingBoxMake(minLat, minLon, maxLat, maxLon);
}

BMKMapRect TBMapRectForBoundingBox(ZWBoundingBox boundingBox)
{
    BMKMapPoint topLeft = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(boundingBox.x0, boundingBox.y0));
    BMKMapPoint botRight = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(boundingBox.xf, boundingBox.yf));

    return BMKMapRectMake(topLeft.x, botRight.y, fabs(botRight.x - topLeft.x), fabs(botRight.y - topLeft.y));
}

NSInteger TBZoomScaleToZoomLevel(BMKZoomScale scale)
{
    double totalTilesAtMaxZoom = BMKMapSizeWorld.width / 256.0;
    NSInteger zoomLevelAtMaxZoom = log2(totalTilesAtMaxZoom);
    NSInteger zoomLevel = MAX(0, zoomLevelAtMaxZoom + floor(log2f(scale) + 0.5));

    return zoomLevel;
}

float TBCellSizeForZoomScale(BMKZoomScale zoomScale)
{
    NSInteger zoomLevel = TBZoomScaleToZoomLevel(zoomScale);

    switch (zoomLevel) {
        case 13:
        case 14:
        case 15:
            return 64;
        case 16:
        case 17:
        case 18:
            return 32;
        case 19:
            return 16;

        default:
            return 88;
    }
}

@implementation ZWCoordinateQuadTree

- (void)buildTreeWithCompletion:(BuildCompletionBlock)completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self buildTree];
        
        self.isFinished = YES;
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion();
            });
        }
    });
}

- (void)buildTree
{
    @autoreleasepool {
        self.isFinished = NO;
        
        NSString *data = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"USA-HotelMotel" ofType:@"csv"] encoding:NSASCIIStringEncoding error:nil];
        NSArray *lines = [data componentsSeparatedByString:@"\n"];

        NSInteger count = lines.count - 1;

        ZWQuadTreeNodeData *dataArray = (ZWQuadTreeNodeData *)malloc(sizeof(ZWQuadTreeNodeData) * count);
        
        if (dataArray != NULL) {
            for (NSInteger i = 0; i < count; i++) {
                dataArray[i] = TBDataFromLine(lines[i]);
            }
            
            ZWBoundingBox world = ZWBoundingBoxMake(19, 73, 72, 131);
            _root = TBQuadTreeBuildWithData(dataArray, count, world, 4);
        }

        free(dataArray);
    }
}

- (void)freeTree
{
    ZWFreeQuadTreeNode(self.root,self.root);
}

- (NSArray *)clusteredAnnotationsWithinMapRect:(BMKMapRect)rect withZoomScale:(double)zoomScale
{
    double TBCellSize = TBCellSizeForZoomScale(zoomScale);
    double scaleFactor = zoomScale / TBCellSize;

    NSInteger minX = floor(BMKMapRectGetMinX(rect) * scaleFactor);
    NSInteger maxX = floor(BMKMapRectGetMaxX(rect) * scaleFactor);
    NSInteger minY = floor(BMKMapRectGetMinY(rect) * scaleFactor);
    NSInteger maxY = floor(BMKMapRectGetMaxY(rect) * scaleFactor);

    NSMutableArray *clusteredAnnotations = [[NSMutableArray alloc] init];
    for (NSInteger x = minX; x <= maxX; x++) {
        for (NSInteger y = minY; y <= maxY; y++) {
            BMKMapRect mapRect = BMKMapRectMake(x / scaleFactor, y / scaleFactor, 1.0 / scaleFactor, 1.0 / scaleFactor);
            
            __block double totalX = 0;
            __block double totalY = 0;
            __block int count = 0;
            
            NSMutableArray *names = [[NSMutableArray alloc] init];
            NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];

            ZWQuadTreeGatherDataInRange(self.root, ZWBoundingBoxForMapRect(mapRect), ^(ZWQuadTreeNodeData data) {
                totalX += data.x;
                totalY += data.y;
                count++;

                ZWHotelInfo hotelInfo = *(ZWHotelInfo *)data.data;
                [names addObject:[NSString stringWithFormat:@"%s", hotelInfo.hotelName]];
                [phoneNumbers addObject:[NSString stringWithFormat:@"%s", hotelInfo.hotelPhoneNumber]];
            });

            if (count == 1) {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(totalX, totalY);
                TBClusterAnnotation *annotation = [[TBClusterAnnotation alloc] initWithCoordinate:coordinate count:count];
                annotation.title = [names lastObject];
                annotation.subtitle = [phoneNumbers lastObject];
                [clusteredAnnotations addObject:annotation];
            }

            if (count > 1) {
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(totalX / count, totalY / count);
                TBClusterAnnotation *annotation = [[TBClusterAnnotation alloc] initWithCoordinate:coordinate count:count];
                [clusteredAnnotations addObject:annotation];
            }
        }
    }

    return [NSArray arrayWithArray:clusteredAnnotations];
}

@end
