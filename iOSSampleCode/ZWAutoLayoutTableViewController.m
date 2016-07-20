//
//  ZWAutoLayoutTableView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWAutoLayoutTableViewController.h"
#import "AutoLayoutControllerHeader.h"

@implementation ZWAutoLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AutoLayout学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"不充足的约束",@"Adaptive Layout示例"];
    self.controllerStrArray = @[@"ZWUnderconstrainedViewController",@"ZWMasterTableViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToController:(NSString *)controllerStr
{
    id controller;
    if ([controllerStr isEqualToString:@"ZWMasterTableViewController"]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        controller = [storyBoard instantiateViewControllerWithIdentifier:@"ZWMasterTableViewController"];
    }
    else
        controller = [NSClassFromString(controllerStr) new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
