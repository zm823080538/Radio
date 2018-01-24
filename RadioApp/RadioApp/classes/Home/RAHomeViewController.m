//
//  RAHomeViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAHomeViewController.h"
#import "CustomProgressHUD.h"
#import <MBProgressHUD.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "RADetailViewController.h"
#import "RAUIToolKits.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface RAHomeViewController () <WKScriptMessageHandler,WKNavigationDelegate,UIWebViewDelegate,BMKOfflineMapDelegate> {
    CustomProgressHUD *_hud;
    BMKOfflineMap* _offlineMap;
}
@end


@implementation RAHomeViewController
- (void)onGetOfflineMapState:(int)type withState:(int)state {
    if (type == TYPE_OFFLINE_UPDATE) {
        //id为state的城市正在下载或更新，start后会毁掉此类型
        BMKOLUpdateElement* updateInfo;
        updateInfo = [_offlineMap getUpdateInfo:state];
        NSLog(@"城市名：%@,下载比例:%d",updateInfo.cityName,updateInfo.ratio);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = [NSURL URLWithString:@"http://gapp.msii.top/index.php?s=m"];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
   
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
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
