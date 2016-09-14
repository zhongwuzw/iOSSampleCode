//
//  ZWImageBrowseViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/9/12.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWImageBrowseViewController.h"
#import "ZWImageScrollView.h"

#define ZOOM_STEP 1.5

@interface ZWImageBrowseViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSMutableArray<UIImageView *> *imageArray;

@end

@implementation ZWImageBrowseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initUI];
    [self initData];
}

- (void)initUI{
    self.imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    _imageScrollView.pagingEnabled = YES;
    _imageScrollView.showsVerticalScrollIndicator = NO;
    _imageScrollView.showsHorizontalScrollIndicator = NO;
    _imageScrollView.delegate = self;
    
    [self.view addSubview:_imageScrollView];
}

- (void)initData{
    self.imageArray = [NSMutableArray arrayWithCapacity:8];
    for (int i = 1; i <= 8; i++) {
        ZWImageScrollView *scrollView = [[ZWImageScrollView alloc] initWithFrame:CGRectMake((i - 1)*kScreenWidth, 0, kScreenWidth, _imageScrollView.height) imageURL:[NSString stringWithFormat:@"photo%d",i]];
        [_imageScrollView addSubview:scrollView];
    }
    [_imageScrollView setContentSize:CGSizeMake(8 * kScreenWidth, _imageScrollView.height)];
}

@end
