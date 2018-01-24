//
//  CustomProgressHUD.m
//  FeedbackDemo
//
//  Created by zhaoming on 2018/1/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "CustomProgressHUD.h"
#import <Masonry.h>
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
int aa;
#pragma clang diagnostic pop
@implementation CustomProgressHUD
+ (CustomProgressHUD *)customShowHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.removeFromSuperViewOnHide = YES;
    
    UIView *centerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"group"];
    [centerView addSubview:logoImageView];
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(centerView);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"group1"];
    [centerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(centerView);
    }];
    hud.customView = centerView;
    hud.bezelView.color = [UIColor clearColor];
    CABasicAnimation* rotationAnimation;
    
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    
    rotationAnimation.duration = 1.5f;
    
    rotationAnimation.cumulative = YES;
    
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [imageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    return hud;
}

- (void)hideAnimated:(BOOL)animated {
    [super hideAnimated:animated];
}

- (void)hideAnimated:(BOOL)animated afterDelay:(NSTimeInterval)delay {
    [super hideAnimated:animated afterDelay:delay];
    
}

@end
