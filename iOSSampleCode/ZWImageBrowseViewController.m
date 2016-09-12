//
//  ZWImageBrowseViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/9/12.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWImageBrowseViewController.h"

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
    _imageScrollView.minimumZoomScale = 1.0;
    _imageScrollView.maximumZoomScale = 6.0;
    
    [self.view addSubview:_imageScrollView];
}

- (void)initData{
    self.imageArray = [NSMutableArray arrayWithCapacity:8];
    for (int i = 1; i <= 8; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"photo%d",i]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake((i - 1)*kScreenWidth, 0, kScreenWidth, _imageScrollView.height);
        [_imageScrollView addSubview:imageView];
        [_imageArray addObject:imageView];
    }
    [_imageScrollView setContentSize:CGSizeMake(8 * kScreenWidth, _imageScrollView.height)];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    int pageIndex = (scrollView.contentOffset.x + kScreenWidth/2)/kScreenWidth;
    UIImageView *imageView = _imageArray[pageIndex];
    return imageView;
}

@end
