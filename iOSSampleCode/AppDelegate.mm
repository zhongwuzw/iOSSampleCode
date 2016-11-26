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
    NSString *str = @"file:///Users/zhongwu/Library/Developer/CoreSimulator/Devices/3BA5EE76-E451-433D-85AA-C3D66548CB8B/data/Containers/Data/Application/E45CB50B-9B1E-4EC7-A507-66579C27D2E6/Library/Docsets/Dash/VueJS/VueJS.docset/Contents/Resources/Documents/vuejs.org/v2/api/index.html#//dash_ref_vm%2Doff/Method/vm.$off/0";
    
    NSArray *array = [str componentsSeparatedByString:@"/Library/Docsets"];
    NSLog(@"%@",homePath);
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; 
    
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

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
