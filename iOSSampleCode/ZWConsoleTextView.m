//
//  ZWConsoleTextView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWConsoleTextView.h"

@interface ZWConsoleTextView ()<UITextViewDelegate>

@end

@implementation ZWConsoleTextView

- (instancetype)initWithFrame:(CGRect)frame textContainer:(NSTextContainer *)textContainer{
    if (self = [super initWithFrame:frame textContainer:textContainer]) {
        self.delegate = self;
        [self configureTextView];
    }
    return self;
}

- (void)configureTextView {
    self.backgroundColor = [UIColor blackColor];
    self.textContainerInset = UIEdgeInsetsMake(0, 20, 0, 20);
    self.textColor = [UIColor whiteColor];
    self.font = [UIFont fontWithName:@"Courier" size:20];
    self.editable = NO;
//    self.bounces = YES;
}

- (void)setText:(NSString *)text
    concatenate:(BOOL)concatenate {
    
    if (concatenate) {
        text = [NSString stringWithFormat:@"\n%@", text];
        self.text = [self.text stringByAppendingString:text];
    }
    else {
        self.text = text;
    }
    
    self.scrollEnabled = NO;
    
    [self.delegate textViewDidChange:self];
}

- (void)clear {
    self.text = @"";
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    self.scrollEnabled = YES;
    
    float margin = 10;
    if (self.contentSize.height + margin > self.frame.size.height) {
        CGPoint offset = CGPointMake(0, self.contentSize.height - self.frame.size.height+ margin);
        [self setContentOffset:offset animated:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
