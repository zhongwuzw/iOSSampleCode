//
//  ZWBookView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBookView.h"

@implementation ZWBookView
{
    NSLayoutManager* _layoutManager;
    NSRange _wordCharacterRange;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        
        UITapGestureRecognizer* recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:recognizer];
    }
    return self;
}

-(void)handleTap:(UITapGestureRecognizer*)tapRecognizer {
    NSTextStorage* textStorage = _layoutManager.textStorage;
    
    CGPoint tappedLocation = [tapRecognizer locationInView:self];
    UITextView* tappedTextView = nil;
    for (UITextView* textView in [self textSubViews]) {
        if (CGRectContainsPoint(textView.frame, tappedLocation)) {
            tappedTextView = textView;
        }
    }
    
    if (!tappedTextView)
        return;
    
    CGPoint subViewLocation = [tapRecognizer locationInView:tappedTextView];
    subViewLocation.y -= 8.0;
    
    NSUInteger glyphIndex = [_layoutManager glyphIndexForPoint:subViewLocation inTextContainer:tappedTextView.textContainer];
    NSUInteger charIndex = [_layoutManager characterIndexForGlyphAtIndex:glyphIndex];
    
    if (![[NSCharacterSet letterCharacterSet] characterIsMember:[textStorage.string characterAtIndex:charIndex]])
        return;
    
    _wordCharacterRange = [self wordThatContainsCharacter:charIndex string:textStorage.string];
    
    [textStorage addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:_wordCharacterRange];
}

- (NSRange)wordThatContainsCharacter:(NSUInteger)charIndex string:(NSString*)string {
    NSUInteger startLocation = charIndex;
    while(startLocation > 0 && [[NSCharacterSet letterCharacterSet] characterIsMember:[string characterAtIndex:startLocation - 1]]) {
        startLocation--;
    }
    
    NSUInteger endLocation = charIndex;
    while(endLocation < string.length && [[NSCharacterSet letterCharacterSet] characterIsMember:[string characterAtIndex:endLocation + 1]]) {
        endLocation++;
    }
    
    return NSMakeRange(startLocation, endLocation - startLocation + 1);
}

- (void)buildFrames {
    NSTextStorage* textStorage = [[NSTextStorage alloc] initWithAttributedString:self.bookMarkup];
    
    _layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:_layoutManager];
    
    
    NSRange range = NSMakeRange(0, 0);
    NSUInteger containerIndex = 0;
    
    while(NSMaxRange(range) < _layoutManager.numberOfGlyphs) {
        CGRect textViewRect = [self frameForViewAtIndex:containerIndex];
        
        NSTextContainer* textContainer = [[NSTextContainer alloc] initWithSize:CGSizeMake(textViewRect.size.width, textViewRect.size.height - 16.0f)];
        [_layoutManager addTextContainer:textContainer];
        
        containerIndex++;
        range = [_layoutManager glyphRangeForTextContainer:textContainer];
    }
    
    [self buildViewsForCurrentOffset];
    
    self.contentSize = CGSizeMake((self.bounds.size.width / 2)* (CGFloat)containerIndex, self.bounds.size.height);
    self.pagingEnabled = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self buildViewsForCurrentOffset];
}

- (CGRect)frameForViewAtIndex:(NSUInteger)index {
    CGRect textViewRect = CGRectMake(0, 0, self.bounds.size.width / 2, self.bounds.size.height);
    
    textViewRect = CGRectInset(textViewRect, 10.0, 20.0);
    
    textViewRect = CGRectOffset(textViewRect, (self.bounds.size.width / 2) * (CGFloat)index, 0.0);
    
    return textViewRect;
}

- (NSArray<UITextView *> *)textSubViews {
    NSMutableArray* views = [NSMutableArray new];
    for (UIView* subview in self.subviews) {
        if ([subview class] == [UITextView class]) {
            [views addObject:subview];
        }
    }
    return views;
}

- (UITextView *)textViewForContainer:(NSTextContainer*)textContainer {
    for (UITextView* textView in [self textSubViews]) {
        if (textView.textContainer == textContainer) {
            return textView;
        }
    }
    return nil;
}

- (BOOL)shouldRenderView:(CGRect) viewFrame {
    
    if (viewFrame.origin.x + viewFrame.size.width < (self.contentOffset.x - self.bounds.size.width))
        return NO;
    
    if (viewFrame.origin.x > (self.contentOffset.x + self.bounds.size.width * 2.0))
        return NO;
    
    return YES;
}

- (void)buildViewsForCurrentOffset {
    for(NSUInteger index = 0; index < _layoutManager.textContainers.count; index++) {
        
        NSTextContainer* textContainer = _layoutManager.textContainers[index];
        UITextView* textView = [self textViewForContainer:textContainer];
        
        CGRect textViewRect = [self frameForViewAtIndex:index];
        
        if ([self shouldRenderView:textViewRect]) {
            if (!textView) {
                UITextView* textView = [[UITextView alloc] initWithFrame:textViewRect textContainer:textContainer];
                
                [self addSubview:textView];
            }
        } else {
            if (textView) {
                [textView removeFromSuperview];
            }
        }
    }
}

@end
