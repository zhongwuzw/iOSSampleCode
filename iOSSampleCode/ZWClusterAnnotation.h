//
//  ZWClusterAnnotation.h
//  ZWAnnotationClustering
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface TBClusterAnnotation : BMKPointAnnotation

@property (assign, nonatomic) NSInteger count;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate count:(NSInteger)count;

@end
