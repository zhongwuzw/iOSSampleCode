//
//  ZWCurlHttpDownloadViewController.m
//  iOSSampleCode
//
//  Created by 钟武 on 2016/10/25.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWCurlHttpDownloadViewController.h"
#import "CStaticTest.h"
#import "curl.h"
#include <stdio.h>
#include <stdlib.h>

@interface ZWCurlHttpDownloadViewController ()

@end

@implementation ZWCurlHttpDownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runCurlHttpDownloadTest];
}

- (void)runCurlHttpDownloadTest{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CStaticTest *test = [CStaticTest new];
        
        NSString *docPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/a"];
        
        char url[256];
        snprintf(url, sizeof(url), "%s",[docPath cStringUsingEncoding:NSUTF8StringEncoding]);
        NSString *logPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/b"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:docPath]) {
            [test downloadFileWithFilePath:docPath logPath:logPath];
        }
        else{
            [fileManager createFileAtPath:docPath contents:nil attributes:nil];
            [fileManager createFileAtPath:logPath contents:nil attributes:nil];
            [test downloadFileWithFilePath:docPath logPath:logPath];
        }
    });
}

@end
