//
//  AppDelegate.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "AppDelegate.h"
#import "LBTabBarController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#define LBKeyWindow [UIApplication sharedApplication].keyWindow
BMKMapManager* _mapManager;
@interface AppDelegate () <BMKGeneralDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _mapManager = [[BMKMapManager alloc]init];
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_BD09LL]) {
        NSLog(@"经纬度类型设置成功");
    } else {
        NSLog(@"经纬度类型设置失败");
    }
    BOOL ret = [_mapManager start:@"jORFz4QiBso2wH6XcMxuPvjdqex3DEuI" generalDelegate:self];
//
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    LBTabBarController *tabBarVc = [[LBTabBarController alloc] init];
    CATransition *anim = [[CATransition alloc] init];
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    [self.window.layer addAnimation:anim forKey:nil];
    self.window.rootViewController = tabBarVc;
      return YES;
}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
