//
//  ZWAlertView.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZWAlertView : UIAlertView

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                      success:(JSValue *)successHandler
                      failure:(JSValue *)failureHandler
                      context:(JSContext *)context;

@end
