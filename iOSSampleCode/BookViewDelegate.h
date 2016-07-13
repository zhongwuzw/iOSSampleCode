//
//  BookViewDelegate.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/13.
//  Copyright © 2016年 钟武. All rights reserved.
//

#ifndef BookViewDelegate_h
#define BookViewDelegate_h

#import <Foundation/Foundation.h>

@class BookView;

@protocol BookViewDelegate <NSObject>

- (void)bookView:(BookView *)bookView didHighlightWord:(NSString *)word inRect:(CGRect)rect;

@end

#endif /* BookViewDelegate_h */
