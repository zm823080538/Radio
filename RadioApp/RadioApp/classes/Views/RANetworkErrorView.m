//
//  RANetworkErrorView.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/16.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RANetworkErrorView.h"

@implementation RANetworkErrorView


- (IBAction)buttonClick {
    if (self.refreshClick) {
        self.refreshClick();
    }
}

@end
