//
//  ZWMarkdownParser.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/14.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWMarkdownParser : NSObject

- (NSAttributedString *)parseMarkdownFile:(NSString *)path;

@end
