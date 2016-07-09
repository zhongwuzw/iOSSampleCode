//
//  ZWCGDrawView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/9.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCGDrawView.h"

@implementation ZWCGDrawView

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextStrokeEllipseInRect(context, rect);
}
@end
