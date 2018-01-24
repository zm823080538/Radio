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
#define LOGIN_URL @"http://gapp.msii.top/index.php?m=member&c=index&a=login"

@interface RAMineViewController () <UIWebViewDelegate>{
    BOOL _launchFirst;
    BOOL _presentFlag;
}

@end

@implementation RAMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _launchFirst = YES;
    self.url = [NSURL URLWithString:@"http://gapp.msii.top/index.php?m=member&s=m"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWeb) name:@"refreshWeb" object:nil];
    
    NSLog(@"");
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
