//
//  ZWURLProtocolController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWURLProtocolController.h"

@interface ZWURLProtocolController ()<UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation ZWURLProtocolController

@synthesize webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView = [UIWebView new];
    [webView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:webView];
    
    [webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[webView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(webView)]];
     
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[webView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(webView)]];
    
//    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"ad_page_pc" ofType:@"html"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:fileName];
    
    //当html中需要加载本地的图片等资源时，需要添加设置baseURL的值
//    [webView loadHTMLString:[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] baseURL:[[NSBundle mainBundle] bundleURL]];
    
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://haha"]]];
    
    webView.delegate = self;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"成功");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"错误%@",error);
}
@end
