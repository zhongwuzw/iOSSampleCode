//
//  ZWBaseTableViewCell.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/30.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBaseTableViewCell.h"

@implementation ZWBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return self;
}
@end
