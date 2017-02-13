//
//  ZWTextKitTopViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWTextKitTopViewController.h"
#import "ZWTextKitTableViewController.h"
#import "ZWBookViewController.h"

@interface ZWTextKitTopViewController ()

@end

@implementation ZWTextKitTopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"TextKit学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"TextKit 基本实例",@"TextKit 中级实例"];
    self.controllerStrArray = @[@"ZWTextKitTableViewController",@"ZWBookViewController"];
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
