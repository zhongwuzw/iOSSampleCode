//
//  UnderconstrainedViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/24.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWUnderconstrainedViewController.h"
#import "ZWHitTestView.h"

@implementation ZWUnderconstrainedViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *view = [[UIView alloc]
                    initWithFrame:CGRectMake(0.0f, 0.0f, 30.0f, 30.0f)];
    
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    view.translatesAutoresizingMaskIntoConstraints = NO;//当把translatesAutoresizingMaskIntoConstraints属性设置为NO后，前面的initWithFrame方法将失效，即不起作用
    
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|[view(==80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];

    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(==80)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(view)]];

}

@end
