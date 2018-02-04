//
//  RACustomPinAnnotationView.m
//  RadioApp
//
//  Created by zhaoming on 03/02/2018.
//  Copyright © 2018 zhaoming. All rights reserved.
//

#import "RACustomPinAnnotationView.h"
#import "UIView+LBExtension.h"
@implementation RACustomPinAnnotationView
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 22.f, 22.f)];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.center = CGPointMake(self.width / 2, self.height / 2);
        [self addSubview:_label];
    }
    return self;
}


//- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
//    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
//    if (self) {
//
//    }
//    return self;
//}

@end
