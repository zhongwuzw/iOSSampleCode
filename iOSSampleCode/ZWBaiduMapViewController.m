//
//  ZWBaiduMapViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/1.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBaiduMapViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "ZWCoordinateQuadTree.h"
#import "ZWClusterAnnotationView.h"
#import "ZWClusterAnnotation.h"

@interface ZWBaiduMapViewController ()<BMKMapViewDelegate>


@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) TBCoordinateQuadTree *coordinateQuadTree;
@property (nonatomic, assign) BOOL mapFinished;
@property (nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation ZWBaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [BMKMapView new];
    [self.view addSubview:_mapView];
    
    [_mapView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_mapView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mapView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_mapView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mapView)]];
    
    self.operationQueue = [NSOperationQueue new];
    self.operationQueue.maxConcurrentOperationCount = 1;
    
    self.coordinateQuadTree = [[TBCoordinateQuadTree alloc] init];
    self.coordinateQuadTree.mapView = self.mapView;
    
    WEAK_REF(self);
    [self.coordinateQuadTree buildTreeWithCompletion:^{
        STRONG_REF(self_);
        if (self__) {
            [self__ prepareMapModelWithMapView:self__.mapView];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _mapView.delegate = nil;
}

#pragma mark - map general delegate
- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        DDLogDebug(@"联网成功");
    }
    else{
        DDLogError(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        DDLogDebug(@"授权成功");
    }
    else {
        DDLogError(@"onGetPermissionState %d",iError);
    }
}

#pragma mark - annotation animation

- (void)addBounceAnnimationToView:(UIView *)view
{
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.values = @[@(0.05), @(1.1), @(0.9), @(1)];
    
    bounceAnimation.duration = 0.6;
    NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounceAnimation.values.count];
    for (NSUInteger i = 0; i < bounceAnimation.values.count; i++) {
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    }
    [bounceAnimation setTimingFunctions:timingFunctions.copy];
    bounceAnimation.removedOnCompletion = NO;
    
    [view.layer addAnimation:bounceAnimation forKey:@"bounce"];
}

- (void)updateMapViewAnnotationsWithAnnotations:(NSArray *)annotations
{
    NSMutableSet *before = [NSMutableSet setWithArray:self.mapView.annotations];

    NSSet *after = [NSSet setWithArray:annotations];
    
    NSMutableSet *toKeep = [NSMutableSet setWithSet:before];
    [toKeep intersectSet:after];
    
    NSMutableSet *toAdd = [NSMutableSet setWithSet:after];
    [toAdd minusSet:toKeep];
    
    NSMutableSet *toRemove = [NSMutableSet setWithSet:before];
    [toRemove minusSet:after];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.mapView addAnnotations:[toAdd allObjects]];
        [self.mapView removeAnnotations:[toRemove allObjects]];
    }];
}

- (void)prepareMapModelWithMapView:(BMKMapView *)mapView{
    if (self.mapFinished && self.coordinateQuadTree.isFinished) {
        [self.operationQueue cancelAllOperations];
        
        [self.operationQueue addOperationWithBlock:^{
            double scale = self.mapView.bounds.size.width / self.mapView.visibleMapRect.size.width;
            NSArray *annotations = [self.coordinateQuadTree clusteredAnnotationsWithinMapRect:mapView.visibleMapRect withZoomScale:scale];
            
            [self updateMapViewAnnotationsWithAnnotations:annotations];
        }];
    }
}

#pragma mark - BMKMapViewDelegate

/**
 *当点击annotation view弹出的泡泡时，调用此接口
 *@param mapView 地图View
 *@param view 泡泡所属的annotation view
 */
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view {
    
}

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView
{
    self.mapFinished = YES;
    
    [self prepareMapModelWithMapView:mapView];
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    [self prepareMapModelWithMapView:mapView];
}

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    static NSString *const TBAnnotatioViewReuseID = @"TBAnnotatioViewReuseID";
    
    TBClusterAnnotationView *annotationView = (TBClusterAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:TBAnnotatioViewReuseID];
    
    if (!annotationView) {
        annotationView = [[TBClusterAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:TBAnnotatioViewReuseID];
    }
    
    annotationView.canShowCallout = YES;
    annotationView.count = [(TBClusterAnnotation *)annotation count];
    
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    for (UIView *view in views) {
        [self addBounceAnnimationToView:view];
    }
}

#pragma mark - Dealloc

- (void)dealloc
{
    if (_mapView) {
        _mapView = nil;
    }
    [self.operationQueue cancelAllOperations];
    [self.coordinateQuadTree freeTree];
}

@end
