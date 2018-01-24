//
//  RAOfflineMapViewController.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface RAOfflineMapViewController : UIViewController<BMKMapViewDelegate> {
    BMKMapView* _mapView;
}
@property (nonatomic, assign) int cityId;
@property (nonatomic, retain) BMKOfflineMap* offlineServiceOfMapview;
@property (nonatomic, strong) NSArray *locations;
@end
