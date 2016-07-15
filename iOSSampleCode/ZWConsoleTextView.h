//
//  ZWConsoleTextView.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWConsoleTextView : UITextView

- (void)setText:(NSString *)text
    concatenate:(BOOL)concatenate;

- (void)clear;

@end
