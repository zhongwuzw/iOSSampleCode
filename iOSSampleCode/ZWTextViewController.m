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

- (void)endEditing
{
    [textView resignFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    textView = [UITextView new];
    textView.editable = YES;
    textView.text = @"调查期间，执勤民警对其进行了耐心教育和政策说明，并请万某在场朋友劝其配合民警工作、接受调查。但万某仍拒不配合，拒绝回答民警询问。经民航青海机场公安局对其同行2人和机场工作人员等目击证人进行调查取证，根据现场收集到的相关证据，万某的行为构成扰乱公共场所秩序，事实清楚，证据确凿。根据《中华人民共和国治安管理处罚法》第二十三条第一款第二项之规定，民航青海机场公安局对万某处以行政拘留5日的处罚。";
    textView.inputAccessoryView = [self accessoryView];
    textView.backgroundColor = [UIColor blueColor];
    textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:textView];
    
    [textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textView(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(textView)]];
}
@end
