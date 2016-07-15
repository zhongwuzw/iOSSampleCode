//
//  ZWBookView.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWBookView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, copy) NSAttributedString* bookMarkup;

- (void)buildFrames;

@end