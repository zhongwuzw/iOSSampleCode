//
//  ZWTimeIndicatorView.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWTimeIndicatorView : UIView

- (id) initWithDate:(NSDate*)date;

- (void) updateSize;

- (UIBezierPath *)curvePathWithOrigin:(CGPoint)origin;

@end
