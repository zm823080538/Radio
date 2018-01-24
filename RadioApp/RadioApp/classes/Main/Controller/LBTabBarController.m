//
//  LBTabBarController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBarController.h"
#import "LBNavigationController.h"

#import "RAHomeViewController.h"
#import "RAProgrammeViewController.h"
#import "RARadioViewController.h"
#import "RAServiceViewController.h"
#import "RAMineViewController.h"

#import "LBTabBar.h"
#import "UIImage+Image.h"


@interface LBTabBarController ()<LBTabBarDelegate> {
    BOOL _presentFlag;
}

@end

@implementation LBTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpAllChildVc];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(radioStatusChange:) name:@"radioStatusChange" object:nil];
    [self loadIndexView];
    self.selectedIndex = 0;


}

- (void)radioStatusChange:(NSNotification *)noti {
    LBTabBar *tabbar = (LBTabBar *)self.tabBar;
    BOOL select = [noti.object boolValue];
    tabbar.plusBtn.selected = select;
    
}

- (void)loadIndexView {
    UIView *indexView = [[NSBundle mainBundle] loadNibNamed:@"RAIndexView" owner:self options:nil].firstObject;
    indexView.frame = self.view.bounds;
    indexView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleWidth;
    indexView.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Artboard 25"].CGImage);
    [self.view addSubview:indexView];
}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{


    RAHomeViewController *HomeVC = [[RAHomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"tab1" selectedImage:@"tab1_select" title:@"首页"];

    RAProgrammeViewController *FishVC = [[RAProgrammeViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"tab2" selectedImage:@"tab2_select" title:@"节目"];

    RAServiceViewController *MessageVC = [[RAServiceViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"tab3" selectedImage:@"tab3_select" title:@"服务"];

    RAMineViewController *MineVC = [[RAMineViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"tab4" selectedImage:@"tab4_select" title:@"我的"];


}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    LBNavigationController *nav = [[LBNavigationController alloc] initWithRootViewController:Vc];


    Vc.view.backgroundColor = [self randomColor];

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;

    [self addChildViewController:nav];
    
}

#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{
    RARadioViewController *radioVC = [[RARadioViewController alloc] init];
    [self presentViewController:radioVC animated:YES completion:nil];
}

- (IBAction)selectChina:(UIButton *)sender {
    sender.superview.hidden = YES;
    [sender.superview.superview removeFromSuperview];
}
- (IBAction)selectFranch:(UIButton *)sender {
    sender.superview.hidden = YES;
    [sender.superview.superview removeFromSuperview];
}


- (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];

}

@end
