//
//  ZWAudioViewController.h
//  iOSSampleCode
//
//  Created by 钟武 on 2016/9/28.
//  Copyright © 2016年 钟武. All rights reserved.
//

#import "ZWBaseViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ZWAudioViewController : ZWBaseViewController
{
    
    //录音器
    AVAudioRecorder *recorder;
    //播放器
    AVAudioPlayer *player;
    NSDictionary *recorderSettingsDict;
    
    NSString *playName;
}

@end
