//
//  ZWTextViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWTextViewController.h"

#define SYSBARBUTTON(ITEM, SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR]

@interface ZWTextViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZWTextViewController

@synthesize textView;

- (UIView *) accessoryView
{
    
    UIToolbar *t = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
    UIBarButtonItem *spacer = SYSBARBUTTON(UIBarButtonSystemItemFlexibleSpace, nil);
    UIBarButtonItem *bbi = SYSBARBUTTON(UIBarButtonSystemItemDone, @selector(endEditing));
    t.items = @[spacer, bbi];
    return t;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    textView = [UITextView new];
    textView.editable = YES;
    textView.text = @"sssssssdadada";
    textView.inputAccessoryView = [self accessoryView];
    textView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textView];
    
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
}
@end
