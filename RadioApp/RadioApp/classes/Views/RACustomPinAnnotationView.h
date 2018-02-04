//
//  RACustomPinAnnotationView.h
//  RadioApp
//
//  Created by zhaoming on 03/02/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//


#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface RACustomPinAnnotationView : BMKPinAnnotationView
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIImageView *imageView;
@end
