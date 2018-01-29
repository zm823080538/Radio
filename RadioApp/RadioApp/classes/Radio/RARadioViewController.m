//
//  RARadioViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/7.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RARadioViewController.h"
#import "RANavigationBar.h"
#import "UIWebView+RAOCJS.h"
#import "MGUIDefine.h"
#import <AVFoundation/AVFoundation.h>
@interface RARadioViewController () {
    AVPlayer *_player;
}

@end

@implementation RARadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addRANavigationBarWithTitle:@"在线直播"];
    self.view.navigationBar.titleLabel.textColor = [UIColor whiteColor];
    self.view.navigationBar.backgroundColor = [UIColor clearColor];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://rme.stream.dicast.fr:8000/rme-192.mp3"]];
    _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    @www
    [self.view setLeftNavBarButtonImage:[UIImage imageNamed:@"header_back_icon_highlight"] buttonClicked:^{
        @sss
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
- (IBAction)play:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        [_player play];
    } else {
        [_player pause];
    }
}



@end
