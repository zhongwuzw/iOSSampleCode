//
//  ZWMarkdownParser.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/14.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ParseMarkdownBlock)(NSAttributedString *);

@interface ZWMarkdownParser : NSObject

- (void)parseMarkdownFile:(NSString *)path completion:(ParseMarkdownBlock)completion;

@end
