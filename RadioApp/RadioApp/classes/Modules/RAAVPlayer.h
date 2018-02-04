//
//  RAAVPlayer.h
//  RadioApp
//
//  Created by zhaoming on 31/01/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface RAAVPlayer : NSObject
+ (instancetype)sharPlayManager;
@property (nonatomic, strong) AVPlayer *myPlayer;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic) BOOL isPlay;
- (void)playerWithURL:(NSString *)usrString;
@end
