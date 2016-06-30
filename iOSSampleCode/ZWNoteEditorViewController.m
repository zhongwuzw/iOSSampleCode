//
//  ZWNoteEditorViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWNoteEditorViewController.h"
#import "ZWNote.h"
#import "ZWTimeIndicatorView.h"

@interface ZWNoteEditorViewController()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@end

@implementation ZWNoteEditorViewController
{
    ZWTimeIndicatorView* _timeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.textView = [UITextView new];
    self.textView.editable = YES;
    self.textView.text = self.note.contents;
    
    self.textView.delegate = self;

    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self.view addSubview:self.textView];
    
    [self.textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    
    _timeView = [[ZWTimeIndicatorView alloc] initWithDate:_note.timestamp];
    [self.view addSubview:_timeView];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(preferredContentSizeChanged:)
     name:UIContentSizeCategoryDidChangeNotification
     object:nil];
}

- (void)viewDidLayoutSubviews {
    [self updateTimeIndicatorFrame];
}

- (void)updateTimeIndicatorFrame {
    [_timeView updateSize];
    _timeView.frame = CGRectOffset(_timeView.frame,
                                   self.view.frame.size.width - _timeView.frame.size.width, 0.0);
    
    UIBezierPath* exclusionPath = [_timeView curvePathWithOrigin:_timeView.center];
    _textView.textContainer.exclusionPaths  = @[exclusionPath];
}

- (void)preferredContentSizeChanged:(NSNotification *)n {
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    [self updateTimeIndicatorFrame];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _note.contents = textView.text;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
