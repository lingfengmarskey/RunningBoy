//
//  RBrunTemporunExcelView.h
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBrunTemporunExcelView : UIView

@property (nonatomic, retain) UIButton *backBtn;

@property (nonatomic, retain) UILabel *topTimeLable;

@property (nonatomic, retain) UILabel *totalDistance;

@property (nonatomic, retain) UILabel *timeLable;
// 平均配速
@property (nonatomic, retain) UILabel *tempoLable;

@property (nonatomic, retain) UILabel *calorieLable;

- (instancetype)initWithFrame:(CGRect)frame
                    BeginDate:(NSDate *)beginDate;
@end
