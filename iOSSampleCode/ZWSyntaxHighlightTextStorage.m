//
//  ZWSyntaxHighlightTextStorage.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWSyntaxHighlightTextStorage.h"

@implementation ZWSyntaxHighlightTextStorage
{
    NSMutableAttributedString *_backingStore;
}

- (id)init
{
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
    }
    return self;
}

- (NSString *)string {
    return [_backingStore string];
}

- (NSDictionary *)attributesAtIndex:(NSUInteger)location effectiveRange:(NSRangePointer)range
{
    return [_backingStore attributesAtIndex:location
                             effectiveRange:range];
}

- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)str
{
    [self beginEditing];
    [_backingStore replaceCharactersInRange:range
                                 withString:str];
    [self edited:NSTextStorageEditedCharacters | NSTextStorageEditedAttributes range:range
                                                changeInLength:str.length - range.length];
    [self endEditing];
}

- (void)setAttributes:(NSDictionary *)attrs range:(NSRange)range {
    [self beginEditing];
    [_backingStore setAttributes:attrs range:range];
    [self edited:NSTextStorageEditedAttributes range:range changeInLength:0];
    [self endEditing];
}

-(void)processEditing {
    [self performReplacementsForRange:[self editedRange]];
    [super processEditing];
}

- (void)performReplacementsForRange:(NSRange)changedRange {
    NSRange extendedRange = NSUnionRange(changedRange, [[_backingStore string] lineRangeForRange:NSMakeRange(changedRange.location, 0)]);
    
    extendedRange = NSUnionRange(extendedRange,[[_backingStore string] lineRangeForRange:NSMakeRange(NSMaxRange(changedRange), 0)]);
    
    [self applyStylesToRange:extendedRange];
}

- (void)applyStylesToRange:(NSRange)searchRange {
    // 1. create some fonts
    UIFontDescriptor* fontDescriptor = [UIFontDescriptor
                                        preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    UIFontDescriptor* boldFontDescriptor = [fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    UIFont* boldFont = [UIFont fontWithDescriptor:boldFontDescriptor size: 0.0];
    UIFont* normalFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    // 2. match items surrounded by asterisks
    NSString* regexStr = @"(\\*\\w+(\\s\\w+)*\\*)\\s";
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:0 error:nil];
    NSDictionary* boldAttributes = @{ NSFontAttributeName : boldFont };
    
    NSDictionary* normalAttributes = @{ NSFontAttributeName : normalFont };
    // 3. iterate over each match, making the text bold
    [regex enumerateMatchesInString:[_backingStore string] options:0
                              range:searchRange usingBlock:^(NSTextCheckingResult *match,NSMatchingFlags flags, BOOL *stop){
                                  NSRange matchRange = [match range];
                                  [self addAttributes:boldAttributes range:matchRange];
                                  // 4. reset the style to the original
                                  if (NSMaxRange(matchRange)+1 < self.length) {
                                      [self addAttributes:normalAttributes range:NSMakeRange(NSMaxRange(matchRange)+1, 1)];
                                  } }];
}

@end
