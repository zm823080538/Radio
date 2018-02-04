//
//  RAMineViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/3.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAMineViewController.h"
#import <WebKit/WebKit.h>
#import "CustomProgressHUD.h"
#import "RADetailViewController.h"
#import "LBNavigationController.h"
#import "LBTabBarController.h"
#import "MGUIDefine.h"
#define LOGIN_URL [NSString stringWithFormat:@"%@index.php?m=member&c=index&a=login",BaseUrl]
#define LOGOUT_URL [NSString stringWithFormat:@"%@index.php?m=member&c=index&a=logout&s=m",BaseUrl]

@interface RAMineViewController () <UIWebViewDelegate>{
    BOOL _launchFirst;
    BOOL _presentFlag;
}

@end

@implementation RAMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _launchFirst = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeb) name:@"refreshWeb" object:nil];
    
    NSLog(@"");
}

- (void)changeBaseUrl {
    NSString *urlString = [NSString stringWithFormat:@"%@index.php?m=member&s=m",BaseUrl];
    self.url = [NSURL URLWithString:urlString];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (!_presentFlag) {
         [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    _presentFlag = NO;
    [super viewWillDisappear:animated];
}

- (void)refreshWeb {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    if (_launchFirst) {
        [self refreshWeb];
        _launchFirst = NO;
    }
        [self refreshWeb];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //判断是否是单击
    NSURL *url = [request URL];
    if (navigationType == UIWebViewNavigationTypeLinkClicked)
    {
        if ([url.absoluteString hasPrefix:LOGIN_URL]) {
            [self presntToLoginVCWithUrl:url];
        } else {
            RADetailViewController *detailVC = [RADetailViewController new];
            detailVC.url = url;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
        return NO;
    } else if ([url.absoluteString hasPrefix:LOGIN_URL]) {
        [self presntToLoginVCWithUrl:url];
        return NO;
    } else if ([url.absoluteString hasPrefix:LOGOUT_URL]) {
        LBTabBarController *tabbar = (LBTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        tabbar.selectedIndex = 0;
    }
    return YES;
}

- (void)presntToLoginVCWithUrl:(NSURL *)url {
    RADetailViewController *detailVC = [RADetailViewController new];
    LBNavigationController *nav = [[LBNavigationController alloc] initWithRootViewController:detailVC];
    _presentFlag = YES;
    detailVC.loginVC = YES;
    detailVC.url = url;
    [self presentViewController:nav animated:YES completion:nil];
}


@end
