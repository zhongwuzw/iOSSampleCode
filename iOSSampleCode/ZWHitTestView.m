//
//  TestView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWHitTestView.h"

@implementation ZWHitTestView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *view = [super hitTest:point withEvent:event];
    if (!view) {
        for (UIView *subView in self.subviews) {
            CGPoint p = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, p)) {
                view = subView;
            }
        }
    }
    return view;
}

@end
