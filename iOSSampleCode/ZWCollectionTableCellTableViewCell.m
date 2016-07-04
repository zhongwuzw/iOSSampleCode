//
//  ZWCollectionTableCellTableViewCell.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/4.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCollectionTableCellTableViewCell.h"
@interface ZWCollectionTableCellTableViewCell()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation ZWCollectionTableCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
