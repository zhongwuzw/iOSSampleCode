//
//  ViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/24.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ViewController.h"
#import "ZWCocoaTouchTableViewController.h"
#import "ZWAutoLayoutTableViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"iOS 学习样例";

    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"AutoLayout样例",@"Cocoa Touch样例"];
    self.selectorArray = @[@"jumpToAutoLayout",@"jumpToCocoaTouch"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToCocoaTouch
{
    ZWCocoaTouchTableViewController *controller = [ZWCocoaTouchTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)jumpToAutoLayout
{
    ZWAutoLayoutTableViewController *controller = [ZWAutoLayoutTableViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
