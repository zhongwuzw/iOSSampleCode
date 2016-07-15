//
//  ZWAutoLayoutTableView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWAutoLayoutTableViewController.h"
#import "AutoLayoutControllerHeader.h"
#import "iOSSampleCode-Swift.h"

@implementation ZWAutoLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AutoLayout学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"不充足的约束",@"Swift测试"];
    self.controllerStrArray = @[@"ZWUnderconstrainedViewController",@"TestViewController"];
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
