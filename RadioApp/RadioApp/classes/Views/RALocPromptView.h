//
//  RALocPromptView.h
//  RadioApp
//
//  Created by zhaoming on 2018/1/4.
//  Copyright © 2018年 zhaoming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RALocPromptView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *trafficOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *info_price_label;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UIButton *pilotButton;
@end
