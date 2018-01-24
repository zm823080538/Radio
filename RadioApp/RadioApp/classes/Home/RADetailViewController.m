//
//  RADetailViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/7.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RADetailViewController.h"
#import "CustomProgressHUD.h"
#import "UIView+LBExtension.h"
#import <Masonry.h>
#import "RANavigationBar.h"
#import "MGUIDefine.h"
#import "LBNavigationController.h"
@interface RADetailViewController () <UIWebViewDelegate>{
    UIWebView *_webView;
    CustomProgressHUD *_hud;
}

@end

@implementation RADetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    if (_loginVC) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        [super viewWillAppear:animated];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
    
}

- (void)viewWillDisappear:(BOOL)animated {
     if (_loginVC) {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
        [super viewWillDisappear:animated];
     }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)setLoginVC:(BOOL)loginVC {
    _loginVC = loginVC;
    if (loginVC) {
        [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top);
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
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
    if ([[request URL].absoluteString hasPrefix:@"http://gapp.msii.top/index.php?m=member&c=index&a=success&s=m"]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeb" object:nil];
            [self.navigationController setNavigationBarHidden:NO];
        }];
        return NO;
    } else if ([[request URL].absoluteString hasPrefix:@"http://gapp.msii.top/index.php?m=member&c=index&close"]) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    return YES;
    
}

@end
