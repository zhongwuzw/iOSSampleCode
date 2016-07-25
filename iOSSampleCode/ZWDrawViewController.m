//
//  ZWDrawViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/9.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWDrawViewController.h"
#import "ZWCGDrawView.h"

#import <QuartzCore/QuartzCore.h>

@implementation ZWDrawViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZWCGDrawView *ecllipseView = [ZWCGDrawView new];
    [self.view addSubview:ecllipseView];
    
    [ecllipseView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[ecllipseView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ecllipseView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[ecllipseView(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(ecllipseView)]];
    
}

@end
