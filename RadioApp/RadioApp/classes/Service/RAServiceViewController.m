//
//  RAServiceViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAServiceViewController.h"
#import <YYModel.h>

#import <JavaScriptCore/JavaScriptCore.h>

#import "UIWebView+RAOCJS.h"
#import "CustomProgressHUD.h"
#import "RADetailViewController.h"
#import "RAOfflineMapViewController.h"

#import "RALocationInfo.h"

int const parisCityID = 36590;
@interface RAServiceViewController () <UIWebViewDelegate,BMKOfflineMapDelegate> {
    BMKOfflineMap* _offlineMap;
    NSMutableArray *_arraylocalDownLoadMapInfo;
}

@end

@implementation RAServiceViewController

- (void)onGetOfflineMapState:(int)type withState:(int)state {
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
    if (type == TYPE_OFFLINE_NEWVER) {
        //id为state的state城市有新版本,可调用update接口进行更新
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"是否有更新%d",updateInfo.update);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = @"http://gapp.msii.top/index.php?m=content&c=index&a=lists&catid=11&s=m";
    self.url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    
    _offlineMap = [[BMKOfflineMap alloc] init];
    _offlineMap.delegate = self;
//    [_offlineMap start:parisCityID];
    _arraylocalDownLoadMapInfo = [NSMutableArray arrayWithArray:[_offlineMap getAllUpdateInfo]];
    BMKOLUpdateElement* item = _arraylocalDownLoadMapInfo.firstObject;
    if (item.update) {
        [_offlineMap update:parisCityID];
    } else {
        [_offlineMap remove:parisCityID];
        [_offlineMap start:parisCityID];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
 
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
     _offlineMap.delegate = nil; // 不用时，置nil
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self finishLoad];
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"lbs"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSMutableArray *locationInfos = @[].mutableCopy;
        [[args[0] toArray] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RALocationInfo *locationInfo = [RALocationInfo yy_modelWithJSON:obj];
            [locationInfos addObject:locationInfo];
        }];
       
            dispatch_async(dispatch_get_main_queue(), ^{
                RAOfflineMapViewController *offlineMapVC = [RAOfflineMapViewController new];
                offlineMapVC.offlineServiceOfMapview = _offlineMap;
                offlineMapVC.cityId = parisCityID;
                offlineMapVC.locations = locationInfos;
                [self.navigationController pushViewController:offlineMapVC animated:YES];
            });
    };
}
    



- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

{
    //判断是否是单击    
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
        
    {
        NSURL *url = [request URL];
        RADetailViewController *detailVC = [RADetailViewController new];
        detailVC.url = url;
        [self.navigationController pushViewController:detailVC animated:YES];
        return NO;
    }    
    return YES;
    
}
@end
