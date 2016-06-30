//
//  ZWTimeIndicatorView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWTimeIndicatorView.h"

@implementation ZWTimeIndicatorView
{
    UILabel* _label;
}

-(id)initWithDate:(NSDate *)date {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        _label = [[UILabel alloc] init];

        NSDateFormatter* format = [NSDateFormatter new];
        [format setDateFormat:@"dd\rMMMM\ryyyy"];
        NSString* formattedDate = [format stringFromDate:date];
        _label.text = [formattedDate uppercaseString];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 0;
        
        [self addSubview:_label];
    }
    return self;
}

- (void)updateSize {
    
    _label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    _label.frame = CGRectMake(0, 0, FLT_MAX, FLT_MAX);
    [_label sizeToFit];
    
    float radius = [self radiusToSurroundFrame:_label.frame];
    self.frame = CGRectMake(0, 0, radius*2, radius*2);
    
    _label.center = self.center;
    

    float padding = 5.0f;
    self.center = CGPointMake(self.center.x + _label.frame.origin.x - padding,
                              self.center.y - _label.frame.origin.y + padding);
    
}

- (float) radiusToSurroundFrame:(CGRect)frame {
    return MAX(frame.size.width, frame.size.height) * 0.5 + 20.0f;
}

- (UIBezierPath *)curvePathWithOrigin:(CGPoint)origin {
    return [UIBezierPath bezierPathWithArcCenter:origin
                                          radius:[self radiusToSurroundFrame:_label.frame]
                                      startAngle:-180.0f
                                        endAngle:180.0f
                                       clockwise:YES];
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(ctx, YES);
    UIBezierPath* path = [self curvePathWithOrigin:_label.center];
    
    [[UIColor colorWithRed:0.329f green:0.584f blue:0.898f alpha:1.0f] setFill];
    [path fill];
}

@end
