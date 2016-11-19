//
//  ZWCocoaTouchTableViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 16/6/27.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCocoaTouchTableViewController.h"
#import "CocoaTouchControllerHeader.h"

@interface ZWCocoaTouchTableViewController ()

@property (nonatomic,strong) NSSet *controllerSet;

@end

@implementation ZWCocoaTouchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIkit学习样例";
    
    [self inilializeDataArray];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)inilializeDataArray
{
    self.dataArray = @[@"Button超出父视图范围",@"TextView和inputAccessoryView",@"Text Kit范例",@"百度地图",@"tableView内嵌collectionView",@"Core Graphic绘图",@"UIKit Dynamics",@"Live Rendering",@"图片浏览器",@"Safari多界面选择",@"TableView With SearchBar"];
    self.controllerStrArray = @[@"ZWHitTestViewController",@"ZWTextViewController",@"ZWTextKitTopViewController",@"ZWBaiduMapViewController",@"ZWCollectionTableViewController",@"ZWDrawViewController",@"ZWDynamicsViewController",@"ZWLiveRenderingViewController",@"ZWImageBrowseViewController",@"ZWSafariMultiSelectViewController",@"ZWSearchTableViewController"];
    self.controllerSet = [NSSet setWithObjects:@"ZWCollectionTableViewController",@"ZWLiveRenderingViewController",@"ZWSearchTableViewController", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Handle VC Jump

- (void)jumpToController:(NSString *)controllerStr
{
    id controller = nil;
    
    if ([self.controllerSet containsObject:controllerStr]) {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        controller = [storyBoard instantiateViewControllerWithIdentifier:controllerStr];
    }
    else{
        controller = [NSClassFromString(controllerStr) new];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
