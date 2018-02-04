//
//  RAProgrammeViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAProgrammeViewController.h"
#import "CustomProgressHUD.h"
#import "RADetailViewController.h"
#import "UIWebView+RAOCJS.h"
#import "LBTabBarController.h"
#import "MGUIDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>
@interface RAProgrammeViewController () <UIWebViewDelegate>{
    UIWebView *_webView;
    CustomProgressHUD *_hud;
}

@end

@implementation RAProgrammeViewController

- (void)changeBaseUrl {
    NSString *urlString = [NSString stringWithFormat:@"%@index.php?m=content&c=index&a=lists&catid=23&s=m",BaseUrl];
    self.url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    //创建NSURLRequest
    [self.webView loadRequest:request];//加载
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self finishLoad];
    [self.webView JSEvaluteOCWithFuncName:@"startRadio" successBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@NO];
    }];
    
    [self.webView JSEvaluteOCWithFuncName:@"stopRadio" successBlock:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@YES];
    }];
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
