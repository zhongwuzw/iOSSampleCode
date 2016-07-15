//
//  ZWItem.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol ZWItemExports <JSExport>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* description;

@end

@interface ZWItem : NSObject <ZWItemExports>

@property (strong, nonatomic) NSString* name;
@property (strong, nonatomic) NSString* description;

@end
