//
//  UIWebView+RAOCJS.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "UIWebView+RAOCJS.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation UIWebView (RAOCJS)
- (void)evaluteJSString:(NSString *)string {
    JSContext *context=[self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    [context evaluateScript:string];//通过oc方法调用js的alert
}


- (void)JSEvaluteOCWithFuncName:(NSString *)funcName successBlock:(void (^)(void))successBlock {
    JSContext *context=[self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[funcName] = ^() {
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"%@",obj);
        }
    };
    context[funcName] = successBlock;
}

@end
