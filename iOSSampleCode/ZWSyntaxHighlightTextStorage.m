//
//  ZWSyntaxHighlightTextStorage.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWSyntaxHighlightTextStorage.h"

@implementation ZWSyntaxHighlightTextStorage
{
    NSMutableAttributedString *_backingStore;
}

- (id)init
{
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
    }
    return self;
}
@end
