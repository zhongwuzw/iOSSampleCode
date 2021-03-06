//
//  CommonMacros.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/15.
//  Copyright © 2016年 钟武. All rights reserved.
//

#ifndef CommonMacros_h
#define CommonMacros_h

#define WEAK_REF(self) \
__block __weak typeof(self) self##_ = self; (void) self##_

#define STRONG_REF(self) \
__block __strong typeof(self) self##_ = self; (void) self##_;

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* CommonMacros_h */
