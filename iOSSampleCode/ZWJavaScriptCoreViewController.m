//
//  ZWJavaScriptCoreViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "ZWJavaScriptCoreViewController.h"
#import "ZWConsoleTextView.h"
#import "ZWItem.h"
#import "ZWAlertView.h"

@interface ZWJavaScriptCoreViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) ZWConsoleTextView *outputTextView;
@property (nonatomic, weak) NSLayoutConstraint *inputTextFieldBottomConstraint;
@property (nonatomic, strong) JSContext *context;
@property (nonatomic, strong) JSManagedValue *inventory;

@end

@implementation ZWJavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    [self initJavaScriptContext];
    
    [self setupKeyboardNotification];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    // Do any additional setup after loading the view.
}

- (void)setupKeyboardNotification{
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [_inputTextField resignFirstResponder];
    }
}

- (void)initJavaScriptContext{
    NSString *scriptPath = [[NSBundle mainBundle]
                            pathForResource:@"xork"
                            ofType:@"js"];
    
    NSString *scriptString = [NSString
                              stringWithContentsOfFile:scriptPath
                              encoding:NSUTF8StringEncoding
                              error:nil];
    
    NSString *dataPath = [[NSBundle mainBundle]
                          pathForResource:@"data"
                          ofType:@"json"];
    
    
    NSString *dataString = [NSString
                            stringWithContentsOfFile:dataPath
                            encoding:NSUTF8StringEncoding
                            error:nil];
    
    NSData *jsonData = [dataString
                        dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization
                          JSONObjectWithData:jsonData
                          options:0
                          error:&error];
    
    if (error) {
        DDLogError(@"%@", @"NSJSONSerialization");
        return;
    }
    
    self.context = [[JSContext alloc] init];
    [self.context evaluateScript:scriptString];
    
    JSValue *value = self.context[@"inventory"];
    self.inventory = [JSManagedValue managedValueWithValue:value];
    [self.context.virtualMachine addManagedReference:self.inventory withOwner:self];
    
    WEAK_REF(self);
    
    self.context[@"print"] = ^(NSString *text){
        text = [NSString stringWithFormat:@"%@\n", text];
        [self_.outputTextView setText:text concatenate:YES];
    };
    
    self.context[@"getVersion"] = ^{
        NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        versionString = [@"version " stringByAppendingString:versionString];
        
        JSContext *context = [JSContext currentContext];
        JSValue *version = [JSValue valueWithObject:versionString inContext:context];
        
        return version;
    };
    
    self.context[@"presentNativeAlert"] = ^(NSString *title,
                                            NSString *message,
                                            JSValue *success,
                                            JSValue *failure) {
        //使用currentContext来获取以避免直接获取self.context造成循环引用
        JSContext *context = [JSContext currentContext];
        ZWAlertView* alertView = [[ZWAlertView alloc]
                                    initWithTitle:title
                                    message:message
                                    success:success
                                    failure:failure
                                    context:context];
        [alertView show];
    };
    
    JSValue *name = [JSValue valueWithObject:@"bar"
                                   inContext:self.context];
    
    __weak JSValue *weakName = name;
    
    self.context[@"foo"] = ^{
        return weakName;
    };
    
    JSValue *function = self.context[@"startGame"];
    JSValue *dataValue = [JSValue valueWithObject:jsonArray
                                        inContext:self.context];
    
    [function callWithArguments:@[dataValue]];
}

- (void)initUI{
    self.outputTextView = [ZWConsoleTextView new];
    [self.view addSubview:_outputTextView];
    [self.outputTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    self.inputTextField = [UITextField new];
    [self.view addSubview:_inputTextField];
    [self.inputTextField setTranslatesAutoresizingMaskIntoConstraints:NO];
    self.inputTextField.delegate = self;
    self.inputTextField.returnKeyType = UIReturnKeySend;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_outputTextView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_outputTextView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_outputTextView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_outputTextView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_outputTextView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_inputTextField attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_inputTextField]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_inputTextField)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_inputTextField attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:35]];
    self.inputTextFieldBottomConstraint = [NSLayoutConstraint constraintWithItem:_inputTextField attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [self.view addConstraint:_inputTextFieldBottomConstraint];
}

#pragma mark - Keyboard Related Method
//当键盘出现或改变时调用
- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    int height = keyboardRect.size.height;
    
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    
    [UIView animateWithDuration:animationDuration delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.inputTextFieldBottomConstraint.constant = -height;
    }completion:nil];

    [self.inputTextField updateConstraintsIfNeeded];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification{
    self.inputTextFieldBottomConstraint.constant = 0;
    [self.inputTextField updateConstraintsIfNeeded];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString* inputString = textField.text;
    [inputString lowercaseString];
    
    if ([inputString isEqualToString:@"clear"]) {
        [self.outputTextView clear];
    }
    else if ([inputString isEqualToString:@"cheat"]) {
        [self addPantryKeyToInventory];
    }
    else if ([inputString isEqualToString:@"save"]) {
        JSValue* function = self.context[@"saveGame"];
        [function callWithArguments:@[]];
    }
    else {
        [self processUserInput:inputString];
    }
    
    [self.inputTextField setText:@""];
    
    return YES;
}

#pragma mark - Helper methods

- (void)processUserInput:(NSString *)input {
    JSValue *function = self.context[@"processUserInput"];
    JSValue *value = [JSValue valueWithObject:input
                                    inContext:self.context];
    
    [function callWithArguments:@[value]];
}

- (void)addPantryKeyToInventory {
    ZWItem* sword = [[ZWItem alloc] init];
    sword.name = @"pantry key";
    sword.description = @"It looks like a normal key.";
    
    JSValue *inventory = [self.inventory value];
    JSValue *function = inventory[@"addItem"];
    [function callWithArguments:@[sword]];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
