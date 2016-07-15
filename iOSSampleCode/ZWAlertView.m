//
//  ZWAlertView.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWAlertView.h"

@interface ZWAlertView() <UIAlertViewDelegate>

@property (strong, nonatomic) JSContext *ctxt;
@property (strong, nonatomic) JSManagedValue *successHandler;
@property (strong, nonatomic) JSManagedValue *failureHandler;

@end

@implementation ZWAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                      success:(JSValue *)successHandler
                      failure:(JSValue *)failureHandler
                      context:(JSContext *)context {
    
    self = [super initWithTitle:title
                        message:message
                       delegate:self
              cancelButtonTitle:@"No"
              otherButtonTitles:@"Yes", nil];
    
    if (self) {
        // Initialization code
        _ctxt = context;
        
        _successHandler = [JSManagedValue managedValueWithValue:successHandler];
        [context.virtualMachine addManagedReference:_successHandler withOwner:self];
        
        _failureHandler = [JSManagedValue managedValueWithValue:successHandler];
        [context.virtualMachine addManagedReference:_failureHandler withOwner:self];
    }
    return self;
}

- (void)dealloc {
    
    //TODO: is this the right place to remove managed reference?
    
    
}

#pragma mark - UIAlertviewDelegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    //1
    if (buttonIndex == self.cancelButtonIndex) {
        JSValue *function = [self.failureHandler value];
        [function callWithArguments:@[]];
    }
    else {
        JSValue *function = [self.successHandler value];
        [function callWithArguments:@[]];
    }
    
    //2
    [self.ctxt.virtualMachine removeManagedReference:_failureHandler
                                           withOwner:self];
    
    [self.ctxt.virtualMachine removeManagedReference:_successHandler
                                           withOwner:self];
}

@end
