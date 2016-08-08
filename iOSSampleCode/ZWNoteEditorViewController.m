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
#import "ZWSyntaxHighlightTextStorage.h"
#import "ZWWeakTimerTarget.h"

@interface ZWNoteEditorViewController()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) ZWSyntaxHighlightTextStorage *textStorage;
@property (nonatomic, assign) CGRect textViewFrame;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ZWNoteEditorViewController
{
    ZWTimeIndicatorView* _timeView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTextView];
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    ZWWeakTimerTarget *target = [[ZWWeakTimerTarget alloc] initWithTarget:self selector:@selector(timerFireMethod:)];
    _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:target selector:@selector(timerDidFire:) userInfo:nil repeats:YES];
}

- (void)timerFireMethod:(NSTimer *)timer{
    DDLogDebug(@"break timer cycle retain");
}

- (void)createTextView
{
    NSDictionary *attrs = @{NSFontAttributeName:[UIFont preferredFontForTextStyle:UIFontTextStyleBody]};
    
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:_note.contents attributes:attrs];
    
    _textStorage = [ZWSyntaxHighlightTextStorage new];
    [_textStorage appendAttributedString:attrString];
    
    CGRect newTextViewRect = self.view.bounds;
    
    NSLayoutManager *layoutManager = [NSLayoutManager new];
    
    CGSize containerSize = CGSizeMake(newTextViewRect.size.width, CGFLOAT_MAX);
    
    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:containerSize];
    container.widthTracksTextView = YES;
    [layoutManager addTextContainer:container];
    [_textStorage addLayoutManager:layoutManager];
    
    
    self.textView = [[UITextView alloc] initWithFrame:CGRectZero textContainer:container];
    self.textView.editable = YES;
    self.textView.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.textView.delegate = self;
    
    [self.view addSubview:self.textView];
    
    _textViewFrame = self.view.bounds;
    
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
    _textView.frame = _textViewFrame;
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
    
    _textViewFrame = self.view.bounds;
    _textView.frame = _textViewFrame;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    _textViewFrame = self.view.bounds;
    _textViewFrame.size.height -= 216.0f;
    _textView.frame = _textViewFrame;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
