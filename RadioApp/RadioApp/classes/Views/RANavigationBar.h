//
//  RANavigationBar.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RANavigationBar : UIView
@property (nonatomic, readonly) UIButton *leftNavBarButton;
@property (nonatomic, readonly) UIButton *rightNavBarButton;
@property (nonatomic, readonly) UIView *separatorLineView;
@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, copy) void (^leftBarButtonClickedBlock)(void);
@end

@interface UIView (RANavigationBar)
@property (nonatomic, strong) RANavigationBar *navigationBar;
// 初始化导航栏，左侧按钮默认事件为pop到上一级view controller
- (void)addRANavigationBarWithTitle:(NSString *)title;
// 初始化导航栏，可为左侧返回按钮添加回调
- (void)addMGNavigationBarWithTitle:(NSString *)title
               leftBarButtonClicked:(void (^)(void))leftBarButtonClicked;
// 设置左侧导航栏按钮图片
- (void)setLeftNavBarButtonImage:(UIImage *)image
                   buttonClicked:(void (^)(void))leftBarButtonClicked;

@end
