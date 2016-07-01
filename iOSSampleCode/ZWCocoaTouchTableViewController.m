//
//  ZWCocoaTouchTableViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCocoaTouchTableViewController.h"
#import "CocoaTouchControllerHeader.h"

@implementation ZWCocoaTouchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIkit学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"Button超出父视图范围",@"TextView和inputAccessoryView",@"Text Kit范例",@"百度地图"];
    self.controllerStrArray = @[@"ZWHitTestViewController",@"ZWTextViewController",@"ZWTextKitTableViewController",@"ZWBaiduMapViewController"];
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
