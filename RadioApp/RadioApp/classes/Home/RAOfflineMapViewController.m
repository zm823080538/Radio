//
//  RAOfflineMapViewController.m
//  RadioApp
//
//  Created by zhaoming on 2018/1/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import "RAOfflineMapViewController.h"
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RAOfflineMapModule.h"
#import "RALocationInfo.h"
#import "RACustomPinAnnotationView.h"

@interface RAOfflineMapViewController () <BMKPoiSearchDelegate>{
//    BMKPoiSearch* _poisearch;
    RAOfflineMapModule *_offlineMapModule;
}
@end

@implementation RAOfflineMapViewController
@synthesize offlineServiceOfMapview;
- (void)viewDidLoad {
    [super viewDidLoad];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        //        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    //显示当前某地的离线地图
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
    BMKOLUpdateElement* localMapInfo;
    localMapInfo = [offlineServiceOfMapview getUpdateInfo:36590];
    [_mapView setCenterCoordinate:localMapInfo.pt];
    _offlineMapModule = [[RAOfflineMapModule alloc] init];
//    _poisearch = [[BMKPoiSearch alloc]init];
  
    // 设置地图级别
    [_mapView setZoomLevel:13];
    _mapView.isSelectedAnnotationViewFront = YES;
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
//    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSMutableArray *annotations = @[].mutableCopy;
    for (RALocationInfo *locationInfo in self.locations) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = CLLocationCoordinate2DMake([locationInfo.info_lbs_w floatValue], [locationInfo.info_lbs_j floatValue]);
        annotation.title = locationInfo.title;
        [annotations addObject:annotation];
        
    }
    [_mapView addAnnotations:annotations];
    [_mapView showAnnotations:annotations animated:YES];

}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
    
    // 检查是否有重用的缓存
    RACustomPinAnnotationView* annotationView = (RACustomPinAnnotationView *)[view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[RACustomPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((RACustomPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((RACustomPinAnnotationView*)annotationView).animatesDrop = NO;
    }
    
    annotationView.image = [UIImage imageNamed:@"Artboard 13"];
    NSUInteger index = [_mapView.annotations indexOfObject:annotation] + 65;
    NSString *string = [NSString stringWithFormat:@"%c",index]; // A
    if (index > 90) {
        string = @"Z+";
    }
    annotationView.label.text = string;
    // 设置位置
    annotationView.annotation = annotation;
    annotationView.enabled = YES;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = NO;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"---%lf,---%lf",view.annotation.coordinate.longitude,view.annotation.coordinate.latitude);
    [_offlineMapModule createLocpromptView];
    _offlineMapModule.coordinate = view.annotation.coordinate;
    [_offlineMapModule showLocPromptView];

    [_mapView.annotations enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj == view.annotation) {
            _offlineMapModule.locationInfo = self.locations[idx];
        }
    }];
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];    
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view {
    NSLog(@"---");
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}




@end
