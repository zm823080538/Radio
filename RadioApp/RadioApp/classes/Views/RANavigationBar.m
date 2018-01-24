//
//  RANavigationBar.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RANavigationBar.h"
#import <objc/runtime.h>
#import <Masonry.h>
#import "MGUIDefine.h"

@interface RANavigationBar ()
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *leftNavBarButton;
@property (nonatomic) UIButton *rightNavBarButton;
@property (nonatomic) UIView *separatorLineView;
@end

@implementation RANavigationBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    [self addSubview:self.leftNavBarButton];
    [self addSubview:self.rightNavBarButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.separatorLineView];
    
    [self.leftNavBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    [self.rightNavBarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(46, 44));
    }];
    self.rightNavBarButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
    [self.separatorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftNavBarButton.mas_right).offset(10);
        make.right.mas_equalTo(self.rightNavBarButton.mas_left).offset(-10);
        make.top.bottom.mas_equalTo(self.leftNavBarButton);
    }];
}

- (void)leftBarButtonClicked:(UIButton *)button {
    if (self.leftBarButtonClickedBlock) {
        self.leftBarButtonClickedBlock();
    }
}

#pragma mark --Getters
- (UIButton *)leftNavBarButton
{
    if (!_leftNavBarButton) {
        _leftNavBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _leftNavBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_leftNavBarButton setImage:[UIImage imageNamed:@"icon_back_co2"]
                           forState:UIControlStateNormal];
        [_leftNavBarButton addTarget:self
                              action:@selector(leftBarButtonClicked:)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftNavBarButton;
}

- (UIButton *)rightNavBarButton
{
    if (!_rightNavBarButton) {
        _rightNavBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _rightNavBarButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _rightNavBarButton.hidden = YES;
        [_rightNavBarButton addTarget:self
                               action:@selector(rightBarButtonClicked:)
                     forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightNavBarButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

//- (UIView *)separatorLineView
//{
//    if (!_separatorLineView) {
//        _separatorLineView = [[UIView alloc] init];
//        _separatorLineView.backgroundColor = [UIColor colorWithHex:0xbdbdbd];
//    }
//    return _separatorLineView;
//}


@end

@implementation UIView (RANavigationBar)

- (RANavigationBar *)navigationBar {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setNavigationBar:(RANavigationBar *)navigationBar {
    objc_setAssociatedObject(self, @selector(navigationBar), navigationBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)addRANavigationBarWithTitle:(NSString *)title {
    [self addMGNavigationBarWithTitle:title leftBarButtonClicked:nil];
}

- (void)addMGNavigationBarWithTitle:(NSString *)title leftBarButtonClicked:(void (^)(void))leftBarButtonClicked {
    if (!self.navigationBar) {
        CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        self.navigationBar = [[RANavigationBar alloc] initWithFrame:CGRectMake(0, 0, screenW, StatusBarAndNavigationBarHeight)];
        self.navigationBar.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.navigationBar];
        [self.navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self).mas_offset(0);
            make.top.mas_equalTo(self);
            make.height.mas_equalTo(@StatusBarAndNavigationBarHeight);
        }];
    }
    self.navigationBar.titleLabel.text = title;
    self.navigationBar.leftBarButtonClickedBlock = leftBarButtonClicked;
}


- (void)setLeftNavBarButtonImage:(UIImage *)image buttonClicked:(void (^)(void))leftBarButtonClicked
{
    self.navigationBar.leftNavBarButton.hidden = NO;
    [self.navigationBar.leftNavBarButton setImage:image forState:UIControlStateNormal];
    self.navigationBar.leftBarButtonClickedBlock = leftBarButtonClicked;
}
@end
