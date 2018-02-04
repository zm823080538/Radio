//
//  RAAVPlayer.m
//  RadioApp
//
//  Created by zhaoming on 31/01/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "RAAVPlayer.h"

@implementation RAAVPlayer
+ (RAAVPlayer *)sharPlayManager{
    
    static RAAVPlayer *playManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playManager = [[RAAVPlayer alloc] init];
    });
    return playManager;
    
}

- (void)playerWithURL:(NSString *)usrString{
    
    //创建url对象
    NSURL *musicURL = [NSURL URLWithString:usrString];
    
    //初始化播放单元
    self.playerItem = [[AVPlayerItem alloc] initWithURL:musicURL];
    
    
    
    //通过判断当前播放器有没有播放单元来决定是否移除观察者，如果播放单元存在，移除观察者,如果不存在，就不需要
    if (self.myPlayer.currentItem) {
        //说明有，需要移除观察者
        [self.myPlayer replaceCurrentItemWithPlayerItem:self.playerItem];
    }else{
        //说明没有播放单元，不需要任何操作
        //将播放单元设置给播放器
        self.myPlayer = [[AVPlayer alloc] initWithPlayerItem:self.playerItem];
    }
     [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];

    }

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (object ==self.playerItem && [keyPath isEqualToString:@"status"]) {
        
        AVPlayerStatus status = [[change objectForKey:NSKeyValueChangeNewKey]integerValue];
        NSLog(@"---%ld",status);
//        if (status ==AVPlayerStatusReadyToPlay)
//            self.musicView.play.enabled = YES;
//        //只有在播放状态才能获取视频时间长度
//        AVPlayerItem *playerItem = (AVPlayerItem *)object;
//
//        NSTimeInterval duration =CMTimeGetSeconds(playerItem.asset.duration);
//        CMTime ctime =self.song.currentTime;
//        self.currentTimeSec = (int)ctime.value/ctime.timescale;
//        self.videoDuration = duration;
//
//
//        [selfonButtonClick:self.musicView.play];
        
    }
}
@end
