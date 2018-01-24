//
//  UIWebView+RAOCJS.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWebView (RAOCJS)
- (void)evaluteJSString:(NSString *)string;
- (void)evaluteJSString:(NSString *)string withArgs:(NSArray *)args;
- (void)JSEvaluteOCWithFuncName:(NSString *)funcName successBlock:(void (^)(void))clickedBlock;
@end
