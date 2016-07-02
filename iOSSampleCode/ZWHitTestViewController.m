//
//  ZWHitTestViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWHitTestViewController.h"
#import "ZWHitTestView.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation ZWHitTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZWHitTestView *view1 = [[ZWHitTestView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    view1.backgroundColor = [UIColor blueColor];
    [self.view addSubview:view1];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(25, 25, 80, 20)];
    button.backgroundColor = [UIColor greenColor];
    [view1 addSubview:button];
    [button setTitle:@"点击按钮" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(handleButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

/**
 *  @author 钟武, 16-06-27 16:06:36
 *
 *  @brief 测试按钮视图超出父视图边界
 *
 *  @param button
 */
- (void)handleButtonClicked:(UIButton *)button
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"按钮点击";
    hud.mode = MBProgressHUDModeText;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });

}

@end
