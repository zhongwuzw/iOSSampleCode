//
//  ZWWeakTimerTarget.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/8/8.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWWeakTimerTarget : NSObject

- (instancetype)initWithTarget:(id)target selector:(SEL)sel;
- (void)timerDidFire:(NSTimer *)timer;

@end
