//
//  ZWAVFoundationViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 2016/9/28.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWAVFoundationViewController.h"
#import "AVFoundationHeader.h"

@interface ZWAVFoundationViewController ()

@end

@implementation ZWAVFoundationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AVFoundation学习样例";
    
    [self inilializeDataArray];
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"录音"];
    self.controllerStrArray = @[@"ZWAudioViewController"];
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToController:(NSString *)controllerStr
{
    id controller = [NSClassFromString(controllerStr) new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
