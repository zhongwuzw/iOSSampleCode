//
//  ZWCocoaTouchTableViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCocoaTouchTableViewController.h"
#import "ZWHitTestViewController.h"
#import "ZWUnderconstrainedViewController.h"

@implementation ZWCocoaTouchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CocoaTouch学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"Button超出父视图范围"];
    self.selectorArray = @[@"jumpToCocoaTouch"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToCocoaTouch
{
    ZWHitTestViewController *controller = [ZWHitTestViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
