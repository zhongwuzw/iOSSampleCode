//
//  ZWHybridPackageFileManager.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/29.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWHybridPackageFileManager : NSObject

+ (BOOL)hasPackageWithURL:(NSURL *)url;

+ (NSData *)dataWithURL:(NSURL *)url;

@end
