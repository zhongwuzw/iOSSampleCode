//
//  ZWBookViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBookViewController.h"

@interface ZWBookViewController ()

@property (nonatomic, copy) NSAttributedString *bookMarkup;

@end

@implementation ZWBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"alices_adventures" ofType:@"md"];
    
    NSString *text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    
    self.bookMarkup = [[NSAttributedString alloc] initWithString:text];
    // Do any additional setup after loading the view.
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
