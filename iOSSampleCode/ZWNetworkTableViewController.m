//
//  ZWNetworkTableViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWNetworkTableViewController.h"
#import "NetworkHeader.h"

@implementation ZWNetworkTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Network学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"使用NSURLProtocol来加速hybrid加载",@"JavaScript Core示例"];
    self.controllerStrArray = @[@"ZWURLProtocolController",@"ZWJavaScriptCoreViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToController:(NSString *)controllerStr
{
    id controller = [NSClassFromString(controllerStr) new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
