//
//  RAUIToolKits.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAUIToolKits.h"
#import "AFNetworkReachabilityManager.h"
#import <objc/runtime.h>
#import <Masonry.h>

@implementation RAUIToolKits

@end

@implementation UIView (ResultErrorView)
- (RANetworkErrorView *)networkErrorView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNetworkErrorView:(RANetworkErrorView *)networkErrorView {
    objc_setAssociatedObject(self, @selector(networkErrorView), networkErrorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showRequestResultErrorViewWithClickedBlock:(void (^)(void))clickedBlock {
    if (!self.networkErrorView) {
        self.networkErrorView = [RANetworkErrorView viewFromNib];
        self.networkErrorView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.networkErrorView];
        [self.networkErrorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        self.networkErrorView.refreshClick = clickedBlock;
    }
}

- (void)removeResultErrorView {
    if (self.networkErrorView) {
        [self.networkErrorView removeFromSuperview];
        self.networkErrorView = nil;
    }
}

+ (instancetype)viewFromNib {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}
@end
