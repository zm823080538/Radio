//
//  RABaseViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RABaseViewController.h"
#import "CustomProgressHUD.h"
#import "RAUIToolKits.h"
#import "MGUIDefine.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface RABaseViewController () <UIWebViewDelegate>{
    CustomProgressHUD *_hud;
}

@end

@implementation RABaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.delegate = self;
    _webView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:_webView];
    if (@available(iOS 11.0, *)) {
        if (iPhoneX) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        }else{
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBaseUrl) name:@"changeBaseUrl" object:nil];
    
    _hud = [CustomProgressHUD customShowHUDAddedTo:self.webView animated:YES];
}

- (void)changeBaseUrl {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

- (void)finishLoad {
    [_hud hideAnimated:YES];
    [self.view removeResultErrorView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self finishLoad];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (error) {
        [self.view showRequestResultErrorViewWithClickedBlock:^{            
            NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
            [_webView loadRequest:request];
        }];
    }
}



@end
