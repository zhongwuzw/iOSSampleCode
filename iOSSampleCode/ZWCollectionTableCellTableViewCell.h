//
//  ZWCollectionTableCellTableViewCell.h
//  iOSSampleCode
//
//  Created by 钟武 on 16/7/4.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWCollectionTableCellTableViewCell : UITableViewCell

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDelegate,UICollectionViewDataSource>)dataSourceDelegate row:(NSInteger)row;
@end
