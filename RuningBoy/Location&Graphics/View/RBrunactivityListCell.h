//
//  RBrunactivityListCell.h
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
@interface RBrunactivityListCell : UITableViewCell
@property (nonatomic, retain) UILabel *creatTimeLable;
@property (nonatomic, retain) UILabel *totalkiloLable;
@property (nonatomic, retain) UIImageView *stateImageView;
@property (nonatomic, retain) UILabel *feedbackLable;
@property (nonatomic, retain) UILabel *tempRecordLable;
@property (nonatomic, retain) UILabel *timeRecordLable;

@property (nonatomic, retain) Route *model;
@end
