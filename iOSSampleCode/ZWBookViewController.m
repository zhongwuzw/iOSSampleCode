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

@property (nonatomic, copy) NSAttributedString *bookMarkup;
@property (nonatomic, strong) ZWBookView *bookView;

@end

@implementation ZWBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alices_adventures" ofType:@"md"];
    
    ZWMarkdownParser *parser = [ZWMarkdownParser new];
    self.bookMarkup = [parser parseMarkdownFile:path];
    
    self.bookView = [[ZWBookView alloc] initWithFrame:self.view.bounds];
    self.bookView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.bookView.bookMarkup = _bookMarkup;
    
    [self.view addSubview:_bookView];
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews{
    [_bookView buildFrames];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
