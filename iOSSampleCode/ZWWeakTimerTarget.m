//
//  ZWWeakTimerTarget.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/8/8.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWWeakTimerTarget.h"

@interface ZWWeakTimerTarget ()

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end
@implementation ZWWeakTimerTarget

- (instancetype)initWithTarget:(id)target selector:(SEL)sel{
    if (self = [super init]) {
        _target = target;
        _selector = sel;
    }
    
    return self;
}

- (void)timerDidFire:(NSTimer *)timer
{
    if(_target)
    {
        [_target performSelector:_selector withObject:timer];
    }
    else
    {
        [timer invalidate];
    }
}

@end
