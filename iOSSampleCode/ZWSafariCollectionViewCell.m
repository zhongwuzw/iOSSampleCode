//
//  ZWSafariCollectionViewCell.m
//  iOSSampleCode
//
//  Created by 钟武 on 2016/11/22.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWSafariCollectionViewCell.h"
#import "UIColor+ZWUtility.h"

@interface ZWSafariCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end
@implementation ZWSafariCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor randomColor];
    self.layer.cornerRadius = 50;
    self.layer.masksToBounds = YES;
}

@end
