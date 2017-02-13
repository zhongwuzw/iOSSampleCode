//
//  AppDelegate.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/24.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWHybridPackageProtocol.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface AppDelegate ()<BMKGeneralDelegate>

@property (nonatomic, strong)BMKMapManager * mapManager;

@end

@implementation AppDelegate

#define homePath NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    DDLogDebug(@"Home Path is %@",homePath);
    
    [NSURLProtocol registerClass:[ZWHybridPackageProtocol class]];
    
    UIColor* navColor = [UIColor colorWithRed:0.175f green:0.458f blue:0.831f alpha:1.0f];
    [[UINavigationBar appearance] setBarTintColor:navColor];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    _mapManager = [[BMKMapManager alloc]init];
    [_mapManager start:@"Cgyj45Ndrhl5pxgzgLtI6mGpymrl6hmG" generalDelegate:nil];
        
    return YES;
}

@end
