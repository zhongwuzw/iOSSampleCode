//
//  ZWCollectionTableCellTableViewCell.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/4.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCollectionTableCellTableViewCell.h"
@interface ZWCollectionTableCellTableViewCell()

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

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate row:(NSInteger)row
{
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.tag = row;
    [self.collectionView reloadData];
}

- (CGFloat)collectionViewOffset
{
    return self.collectionView.contentOffset.x;
}

- (void)setCollectionViewOffset:(CGFloat)collectionViewOffset
{
    CGPoint point = _collectionView.contentOffset;
    point.x = collectionViewOffset;
    self.collectionView.contentOffset = point;
}

@end
