//
//  RARadioViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/7.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RARadioViewController.h"
#import "RANavigationBar.h"
#import "UIWebView+RAOCJS.h"
#import "MGUIDefine.h"
#import "RAAVPlayer.h"
#import <Masonry.h>
@interface RARadioViewController () <UIWebViewDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIScrollView *bgScrollView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeight;

@end

@implementation RARadioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addRANavigationBarWithTitle:@"在线直播"];
    self.bgScrollView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Artboard 25"].CGImage);
    self.view.navigationBar.titleLabel.textColor = [UIColor whiteColor];
    self.view.navigationBar.backgroundColor = [UIColor clearColor];
    @www
    [self.view setLeftNavBarButtonImage:[UIImage imageNamed:@"header_back_icon_highlight"] buttonClicked:^{
        @sss
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    NSString *urlString = [NSString stringWithFormat:@"%@index.php?m=comment&c=index&a=init&commentid=content_9-1-1&iframe=1&s=m",BaseUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.view.navigationBar.leftNavBarButton setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    self.view.navigationBar.leftNavBarButton.tintColor = [UIColor grayColor];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webViewHeight.constant = self.webView.scrollView.contentSize.height;
    NSLog(@"%lf",self.webView.scrollView.contentSize.height);
    self.bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.webViewHeight.constant + 326);
}

- (IBAction)play:(UIButton *)sender {
    sender.selected = !sender.selected;
    [[RAAVPlayer sharPlayManager].myPlayer pause];
    if (sender.selected) {
        [[RAAVPlayer sharPlayManager] playerWithURL:@"http://rme.stream.dicast.fr:8000/rme-192.mp3"];
        [[RAAVPlayer sharPlayManager].myPlayer play];
//        [RAAVPlayer sharPlayManager].isPlay = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@YES];
    } else {
//        [RAAVPlayer sharPlayManager].isPlay = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"radioStatusChange" object:@NO];

    }
}



@end
