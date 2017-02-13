//
//  ZWMarkdownParser.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/14.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWMarkdownParser.h"

@implementation ZWMarkdownParser {
    NSDictionary* _bodyTextAttributes;
    NSDictionary* _headingOneAttributes;
    NSDictionary* _headingTwoAttributes;
    NSDictionary* _headingThreeAttributes;
}

- (id) init {
    if (self = [super init]) {
        [self createTextAttributes];
    }
    return self;
}

- (void)createTextAttributes {
    UIFontDescriptor* baskerville = [UIFontDescriptor fontDescriptorWithFontAttributes:
                                     @{UIFontDescriptorFamilyAttribute: @"Baskerville"}];
    
    UIFontDescriptor* baskervilleBold = [baskerville fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    
    UIFontDescriptor* bodyFont = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    NSNumber* bodyFontSize = bodyFont.fontAttributes[UIFontDescriptorSizeAttribute];
    float bodyFontSizeValue = [bodyFontSize floatValue];
    
    _bodyTextAttributes = [self attributesWithDescriptor:baskerville
                                                    size:bodyFontSizeValue];
    _headingOneAttributes = [self attributesWithDescriptor:baskervilleBold
                                                      size:bodyFontSizeValue * 2.0f];
    _headingTwoAttributes = [self attributesWithDescriptor:baskervilleBold
                                                      size:bodyFontSizeValue * 1.8f];
    _headingThreeAttributes = [self attributesWithDescriptor:baskervilleBold
                                                        size:bodyFontSizeValue * 1.4f];
}

- (NSDictionary *)attributesWithDescriptor:(UIFontDescriptor*)descriptor size:(float)size {
    UIFont* font = [UIFont fontWithDescriptor:descriptor
                                         size:size];
    return @{NSFontAttributeName: font};
}

- (void)parseMarkdownFile:(NSString *)path completion:(ParseMarkdownBlock)completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
       NSAttributedString *attributeStr = [self parseMarkdownFile:path];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(attributeStr);
            });
        }
    });
}

- (NSAttributedString *)parseMarkdownFile:(NSString *)path {
    NSMutableAttributedString *parsedOutput = [NSMutableAttributedString new];
    
    NSString* text = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray* lines = [text componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    for (NSUInteger lineIndex = 0; lineIndex < lines.count; lineIndex++) {
        NSString *line = lines[lineIndex];
        
        if ([line isEqualToString:@""]) {
            continue;
        }
        
        NSDictionary* textAttributes = _bodyTextAttributes;
        if (line.length > 3){
            if ([[line substringToIndex:3] isEqualToString:@"###"]) {
                textAttributes = _headingThreeAttributes;
                line = [line substringFromIndex:3];
            } else if ([[line substringToIndex:2] isEqualToString:@"##"]) {
                textAttributes = _headingTwoAttributes;
                line = [line substringFromIndex:2];
            } else if ([[line substringToIndex:1] isEqualToString:@"#"]) {
                textAttributes = _headingOneAttributes;
                line = [line substringFromIndex:1];
            }
        }
        
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:line attributes:textAttributes];
        
        [parsedOutput appendAttributedString:attributedText];
        [parsedOutput appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    }
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\!\\[.*\\]\\((.*)\\)"
                                                                           options:0
                                                                             error:nil];
    NSArray* matches = [regex matchesInString:[parsedOutput string]
                                      options:0
                                        range:NSMakeRange(0, parsedOutput.length)];
    
    for (NSTextCheckingResult* result in [matches reverseObjectEnumerator]) {
        NSRange matchRange = [result range];
        NSRange captureRange = [result rangeAtIndex:1];
        
        NSTextAttachment* ta = [NSTextAttachment new];
        ta.image = [UIImage imageNamed:[parsedOutput.string substringWithRange:captureRange]];
        
        NSAttributedString* rep = [NSAttributedString attributedStringWithAttachment:ta];
        [parsedOutput replaceCharactersInRange:matchRange withAttributedString:rep];
        
    }
    
    return parsedOutput;
}

@end
