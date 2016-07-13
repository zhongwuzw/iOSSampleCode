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
    NSDictionary *_replacements;
}

- (id)init
{
    if (self = [super init]) {
        _backingStore = [NSMutableAttributedString new];
        [self createHighlightPatterns];
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
    NSDictionary* normalAttrs = @{NSFontAttributeName:
                                      [UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    
    for (NSString* key in _replacements) {
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:key options:0 error:nil];
        
        NSDictionary* attributes = _replacements[key];
        
        [regex enumerateMatchesInString:[_backingStore string] options:0
                                  range:searchRange usingBlock:^(NSTextCheckingResult *match,NSMatchingFlags flags, BOOL *stop){
                                      NSRange matchRange = [match range];
                                      [self addAttributes:attributes range:matchRange];
                                      //如果重新编辑textview，保证在匹配的*w* 之后添加的字符不会是bold样式
                                      if (NSMaxRange(matchRange)+1 < self.length) {
                                          [self addAttributes:normalAttrs range:NSMakeRange(NSMaxRange(matchRange)+1, 1)];
                                      }
                                  }];
    }
    
}

- (void)createHighlightPatterns{
    UIFontDescriptor *scriptFontDescriptor = [UIFontDescriptor fontDescriptorWithFontAttributes: @{UIFontDescriptorFamilyAttribute: @"Zapfino"}];
    
    UIFontDescriptor* bodyFontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    NSNumber* bodyFontSize = bodyFontDescriptor.fontAttributes[UIFontDescriptorSizeAttribute];
    UIFont* scriptFont = [UIFont fontWithDescriptor:scriptFontDescriptor size:[bodyFontSize floatValue]];
    
    NSDictionary* boldAttributes = [self createAttributesForFontStyle:UIFontTextStyleBody withTrait:UIFontDescriptorTraitBold];
    
    NSDictionary* italicAttributes = [self createAttributesForFontStyle:UIFontTextStyleBody withTrait:UIFontDescriptorTraitItalic];
    
    NSDictionary* strikeThroughAttributes = @{NSStrikethroughStyleAttributeName : @1};
    NSDictionary* scriptAttributes = @{ NSFontAttributeName : scriptFont};
    
    NSDictionary* redTextAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor]};
    
    _replacements = @{
                      @"(\\*\\w+(\\s\\w+)*\\*)\\s" : boldAttributes,
                      @"(_\\w+(\\s\\w+)*_)\\s" : italicAttributes,
                      @"([0-9]+\\.)\\s" : boldAttributes,
                      @"(-\\w+(\\s\\w+)*-)\\s" : strikeThroughAttributes,
                      @"(~\\w+(\\s\\w+)*~)\\s" : scriptAttributes,
                      @"\\s([A-Z]{2,})\\s" : redTextAttributes
                      };
}

- (NSDictionary*)createAttributesForFontStyle:(NSString*)style withTrait:(uint32_t)trait {
    UIFontDescriptor *fontDescriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:style];
    UIFontDescriptor *descriptorWithTrait = [fontDescriptor fontDescriptorWithSymbolicTraits:trait];
    UIFont* font = [UIFont fontWithDescriptor:descriptorWithTrait size: 0.0];
    return @{ NSFontAttributeName : font };
}

@end
