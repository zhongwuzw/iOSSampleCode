//
//  ZWSafariMultiSelectViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 2016/11/9.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWSafariMultiSelectViewController.h"
#import "ZWSafariCollectionViewFlowLayout.h"
#import "ZWSafariCollectionViewCell.h"

@interface ZWSafariMultiSelectViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ZWSafariMultiSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeView];
}

- (void)initializeView{
    self.collectionView = ({
        ZWSafariCollectionViewFlowLayout *layout = [ZWSafariCollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake(self.view.width - 30, self.view.height - 100);
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        [self.view addSubview:collectionView];
        collectionView.backgroundColor = [UIColor whiteColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerNib:[UINib nibWithNibName:@"ZWSafariCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
        collectionView;
    });
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZWSafariCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.label.text = @"sss";
    return cell;
}

@end
