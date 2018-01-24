//
//  RAUIToolKits.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RANetworkErrorView.h"
@interface RAUIToolKits : NSObject

@end

@interface UIView (ResultErrorView)
@property (nonatomic, readonly) RANetworkErrorView *networkErrorView;
- (void)showRequestResultErrorViewWithClickedBlock:(void (^)(void))clickedBlock;
- (void)removeResultErrorView;
@end
