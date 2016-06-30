//
//  ZWNote.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWNote.h"

@implementation ZWNote

+ (ZWNote *)noteWithText:(NSString *)text {
    ZWNote* note = [ZWNote new];
    note.contents = text;
    note.timestamp = [NSDate date];
    return note;
}

- (NSString *)title {
    NSArray* lines = [self.contents componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
    
    return lines[0];
}

@end
