//
//  RABaseViewController.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@protocol RefreshProtocol <NSObject>
- (void)changeBaseUrl;
@end

@interface RABaseViewController : UIViewController <RefreshProtocol>
@property (nonatomic) UIWebView *webView;
@property (nonatomic, strong) NSURL *url;
- (void)finishLoad;
@end
