//
//  CustomProgressHUD.h
//  FeedbackDemo
//
//  Created by zhaoming on 2018/1/1.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface CustomProgressHUD : MBProgressHUD
+ (CustomProgressHUD *)customShowHUDAddedTo:(UIView *)view animated:(BOOL)animated;
@end
