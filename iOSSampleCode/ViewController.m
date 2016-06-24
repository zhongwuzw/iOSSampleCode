//
//  ViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/24.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ViewController.h"
#import "UnderconstrainedViewController.h"

static NSString *CELL_IDENTIFIER = @"cell_identifier";

@interface ViewController ()

@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *selectorArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = @"iOS 学习样例";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
    self.tableView.tableFooterView = [UIView new];

    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"AutoLayout样例"];
    self.selectorArray = @[@"jumpToAutoLayout"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToAutoLayout
{
    UnderconstrainedViewController *controller = [UnderconstrainedViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER];
    [cell.textLabel setText:_dataArray[indexPath.row]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    if ([self respondsToSelector:NSSelectorFromString(_selectorArray[indexPath.row])]) {
        [self performSelector:NSSelectorFromString(_selectorArray[indexPath.row])];
    }
    
    #pragma clang diagnostic pop
}
@end
