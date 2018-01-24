//
//  OfflineMapModule.m
//  FeedbackDemo
//
//  Created by zhaoming on 2017/12/29.
//  Copyright © 2017年 zhaoming. All rights reserved.
//

#import "OfflineMapModule.h"
#import "AppDelegate.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@implementation OfflineMapModule
+ (void)load {
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
          
        BMKMapManager *manager = [[BMKMapManager alloc]init];
        if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
            NSLog(@"经纬度类型设置成功");
        } else {
            NSLog(@"经纬度类型设置失败");
        }
        BOOL ret = [manager start:@"B99fbywGLnlwW97zQabnKRiC4nDR41XT" generalDelegate:[UIApplication sharedApplication].delegate];
        if (!ret) {
            NSLog(@"manager start failed!");
        }
        
    }];
}



@end
