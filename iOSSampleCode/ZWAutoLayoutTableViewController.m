//
//  ZWAutoLayoutTableView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWAutoLayoutTableViewController.h"
#import "ZWHitTestViewController.h"
#import "ZWUnderconstrainedViewController.h"

@implementation ZWAutoLayoutTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AutoLayout学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"不充足的约束"];
    self.selectorArray = @[@"jumpToAutoLayout"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToAutoLayout
{
    ZWUnderconstrainedViewController *controller = [ZWUnderconstrainedViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
