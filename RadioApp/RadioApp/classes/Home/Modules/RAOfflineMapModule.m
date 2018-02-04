//
//  RAOfflineMapModule.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAOfflineMapModule.h"
#import "RALocPromptView.h"
#import "UIView+LBExtension.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <MapKit/MapKit.h>

#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
@interface RAOfflineMapModule() {
    RALocPromptView *_promptView;
}
@end

@implementation RAOfflineMapModule

- (void)createLocpromptView {
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bgButton.frame = [UIApplication sharedApplication].keyWindow.bounds;
    bgButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    [[bgButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissLocPromptView];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:bgButton];
    [[self rac_signalForSelector:@selector(dismissLocPromptView)] subscribeNext:^(id x) {
        [bgButton removeFromSuperview];
    }];
    _promptView = [[NSBundle mainBundle] loadNibNamed:@"RALocPromptView" owner:nil options:nil].firstObject;
    
    [[_promptView.pilotButton  rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self dismissLocPromptView];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        BOOL baiduMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
        BOOL aMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]];
        BOOL googleMapCanOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"系统地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:self.coordinate addressDictionary:nil]];
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                                           MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        if (baiduMapCanOpen) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=巴黎&mode=driving&coord_type=gcj02",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",self.coordinate.latitude, self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //                baiduMapDic[@"url"] = urlString;
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
            }]];
        }
        if (googleMapCanOpen) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"谷歌地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
        }
        if (aMapCanOpen) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",self.coordinate.latitude,self.coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:urlString]]) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
                }
                //                gaodeMapDic[@"url"] = urlString;
                //                NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"电台App",urlScheme,self.coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                //                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
            }]];
        }
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:_promptView];
}

- (void)showLocPromptView {
    
    [UIView animateWithDuration:0.3f animations:^{
        _promptView.transform = CGAffineTransformTranslate(_promptView.transform, 0, -_promptView.height);
    }];
}

- (void)setLocationInfo:(RALocationInfo *)locationInfo {
    _locationInfo = locationInfo;
    _promptView.titleLabel.text = locationInfo.title;
    _promptView.telephone.text = locationInfo.keywords;
    _promptView.trafficOneLabel.text = locationInfo.jiaotong;
    _promptView.info_price_label.text = locationInfo.price;
    _promptView.peopleLabel.text = locationInfo.fee;
    _promptView.address.text = locationInfo.content;
    _promptView.frame = CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH - 40, _promptView.height);
}

- (void)dismissLocPromptView {
    [UIView animateWithDuration:0.3f animations:^{
        _promptView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [_promptView removeFromSuperview];
        _promptView = nil;
    }];
}
@end
