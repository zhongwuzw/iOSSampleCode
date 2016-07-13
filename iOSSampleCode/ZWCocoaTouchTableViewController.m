//
//  ZWCocoaTouchTableViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCocoaTouchTableViewController.h"
#import "CocoaTouchControllerHeader.h"

@implementation ZWCocoaTouchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIkit学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"Button超出父视图范围",@"TextView和inputAccessoryView",@"Text Kit范例",@"百度地图",@"tableView内嵌collectionView",@"Core Graphic绘图",@"UIKit Dynamics"];
    self.controllerStrArray = @[@"ZWHitTestViewController",@"ZWTextViewController",@"ZWTextKitTopViewController",@"ZWBaiduMapViewController",@"ZWCollectionTableViewController",@"ZWDrawViewController",@"ZWDynamicsViewController"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToController:(NSString *)controllerStr
{
    if ([controllerStr isEqualToString:@"ZWCollectionTableViewController"])
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ZWCollectionTableViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"ZWCollectionTableViewController"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else{
        id controller = [NSClassFromString(controllerStr) new];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
