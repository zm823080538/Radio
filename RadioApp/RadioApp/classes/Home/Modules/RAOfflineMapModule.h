//
//  RAOfflineMapModule.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RALocationInfo.h"

@interface RAOfflineMapModule : NSObject
- (void)showLocPromptView;
- (void)dismissLocPromptView;

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) RALocationInfo *locationInfo;
@end
