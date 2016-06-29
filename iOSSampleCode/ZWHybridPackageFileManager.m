//
//  ZWHybridPackageFileManager.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWHybridPackageFileManager.h"

@implementation ZWHybridPackageFileManager

+ (BOOL)hasPackageWithURL:(NSURL *)url
{
    if ([url.absoluteString rangeOfString:@"haha"].location != NSNotFound) {
        return YES;
    }
    return NO;
}

+ (NSData *)dataWithURL:(NSURL *)url
{
    NSData *data;
    
    if ([url.absoluteString rangeOfString:@"haha"].location != NSNotFound) {
        NSString *fileName = [[NSBundle mainBundle] pathForResource:@"ad_page_pc" ofType:@"html"];
        data = [[NSData alloc] initWithContentsOfFile:fileName];
    }

    return data;
}
@end
