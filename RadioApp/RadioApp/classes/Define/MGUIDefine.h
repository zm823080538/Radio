//
//  MGUIDefine.h
//  MGFundation
//
//  Created by lrq on 2017/12/15.
//  Copyright © 2017年 migu. All rights reserved.
//

#ifndef MGUIDefine_h
#define MGUIDefine_h

//屏幕尺寸
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

// iPhone X
#define  iPhoneX (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f ? YES : NO)

// 判断是否是X
#define  is_iPhoneX  [[UIDevice currentDevice].machineModelName isEqualToString:@"iPhone X"]

// Status bar height.
#define  StatusBarHeight      (iPhoneX ? 44.f : 20.f)

// Navigation bar height.
#define  NavigationBarHeight  44.f

// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (iPhoneX ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (iPhoneX ? 88.f : 64.f)

#define ViewSafeAreInsets(view) ({UIEdgeInsets insets; if(@available(iOS 11.0, *)) {insets = view.safeAreaInsets;} else {insets = UIEdgeInsetsZero;} insets;})

#define www weakify(self)
#define sss strongify(self)

#ifndef weakify
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#endif

#ifndef strongify
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#endif

#endif /* MGUIDefine_h */
