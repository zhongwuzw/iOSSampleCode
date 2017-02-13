//
//  ZWBookViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBookViewController.h"
#import "ZWBookView.h"
#import "ZWMarkdownParser.h"

@interface ZWBookViewController ()

@property (nonatomic, strong) ZWBookView *bookView;

@end

@implementation ZWBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.bookView = [[ZWBookView alloc] initWithFrame:self.view.bounds];
    self.bookView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_bookView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alices_adventures" ofType:@"md"];
    ZWMarkdownParser *parser = [ZWMarkdownParser new];
    
    WEAK_REF(self);
    [parser parseMarkdownFile:path completion:^(NSAttributedString *attriString){
        STRONG_REF(self_);
        if (self__) {
            self__.bookView.bookMarkup = attriString;
            [self__.bookView buildFrames];
        }
    }];
}

- (void)viewDidLayoutSubviews{
    [_bookView buildFrames];
}

@end
