//
//  ZWImageScrollView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/9/14.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWImageScrollView.h"
#define ZOOM_STEP 1.5

@interface ZWImageScrollView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation ZWImageScrollView

- (instancetype)initWithFrame:(CGRect)frame imageURL:(NSString *)imageURL{
    if (self = [super initWithFrame:frame]) {
        [self initUIWithImageURL:imageURL];
    }
    
    return self;
}

- (void)initUIWithImageURL:(NSString *)imageURL{
    UIImage *image = [UIImage imageNamed:imageURL];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = self.bounds;
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    self.imageView = imageView;
    self.contentSize = self.size;
    
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 3.0;
    
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    self.delegate = self;
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    [doubleTap setNumberOfTapsRequired:2];
    
    [self addGestureRecognizer:doubleTap];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint touchPoint = [gestureRecognizer locationInView:gestureRecognizer.view];
    
    CGFloat newZoomScale = ((self.maximumZoomScale + self.minimumZoomScale) / 2);
    CGFloat xsize = self.bounds.size.width / newZoomScale;
    CGFloat ysize = self.bounds.size.height / newZoomScale;
    [self zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.imageView;
}

@end
