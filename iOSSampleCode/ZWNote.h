//
//  ZWNote.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWNote : NSObject

@property NSString* contents;
@property NSDate* timestamp;

@property (readonly) NSString* title;

+ (ZWNote *) noteWithText:(NSString*)text;

@end
