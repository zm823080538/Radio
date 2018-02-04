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
#import <JavaScriptCore/JavaScriptCore.h>
#import "LBNavigationController.h"
#import "RAAVPlayer.h"
@interface RADetailViewController () <UIWebViewDelegate>{
    UIWebView *_webView;
    CustomProgressHUD *_hud;
}
@property (nonatomic, strong) AVPlayer *player;

@end

@implementation RADetailViewController

//- (AVPlayer *)player {
//    if (!_player) {
//        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@""]];
//        _player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
//    }
//    return _player;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *originImage = [UIImage imageNamed:@"nav_bg1"];
    originImage = [originImage stretchableImageWithLeftCapWidth:5 topCapHeight:5];
//    UIImage *imgLogin = [imgLogin stretchableImageWithLeftCapWidth:floorf(imgLogin.size.width - 10) topCapHeight:floorf(imgLogin.size.height  - 10)];
    [self.navigationController.navigationBar setBackgroundImage:originImage forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
    if (_loginVC) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
        [super viewWillAppear:animated];
    }
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
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
    //登录成功
    if ([[request URL].absoluteString hasPrefix:[NSString stringWithFormat:@"%@index.php?m=member&c=index&a=success&s=m",BaseUrl]]) {
        [self dismissViewControllerAnimated:YES completion:^{
            [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshWeb" object:nil];
            [self.navigationController setNavigationBarHidden:NO];
        }];
        return NO;
        
    } else if ([[request URL].absoluteString hasPrefix:[NSString stringWithFormat:@"%@index.php?m=member&c=index&close",BaseUrl]]) { //
        [self dismissViewControllerAnimated:YES completion:nil];
        return NO;
    }
    
    return YES;
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [super finishLoad];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"startRadio"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *playUrl = [args[0] toString];
        AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:playUrl]];
         [self.player replaceCurrentItemWithPlayerItem:playerItem];
        [_player play];
    };
    context[@"startRadio"] = ^() {
        NSArray *args = [JSContext currentArguments];
        NSString *playUrl = [args[0] toString];
        [[RAAVPlayer sharPlayManager] playerWithURL:playUrl];
        [[RAAVPlayer sharPlayManager].myPlayer play];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@NO];
    };
    context[@"stopRadio"] = ^() {
        [[[RAAVPlayer sharPlayManager] myPlayer] pause];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@YES];
    };

}

@end
