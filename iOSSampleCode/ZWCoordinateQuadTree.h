//
//  ZWCoordinateQuadTree.h
//  ZWAnnotationClustering
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "ZWQuadTree.h"

typedef void(^BuildCompletionBlock)();

typedef struct ZWHotelInfo {
    char* hotelName;
    char* hotelPhoneNumber;
} ZWHotelInfo;

@interface ZWCoordinateQuadTree : NSObject

@property (assign, nonatomic) ZWQuadTreeNode* root;
@property (weak, nonatomic) BMKMapView *mapView;
@property (assign, nonatomic) BOOL isFinished;

- (void)buildTreeWithCompletion:(BuildCompletionBlock)completion;
- (void)freeTree;
- (NSArray *)clusteredAnnotationsWithinMapRect:(BMKMapRect)rect withZoomScale:(double)zoomScale;

@end
