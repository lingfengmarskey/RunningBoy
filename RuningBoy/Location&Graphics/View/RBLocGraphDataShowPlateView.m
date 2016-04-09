//
//  RBLocGraphDataShowPlateView.m
//  RuningBoy
//
//  Created by marskey on 16/3/25.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBLocGraphDataShowPlateView.h"

@implementation RBLocGraphDataShowPlateView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
    }
    return self;
}
- (void)creatSubViews{
// 总公里数据
    self.locGraphTotalkmLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.1875 * HEIGHT)];
    self.locGraphTotalkmLable.textColor = [UIColor redColor];
    self.locGraphTotalkmLable.text = @"0.00";
    self.locGraphTotalkmLable.font = [UIFont fontWithName:@"Helvetica Bold" size:[Tools autoSuitFontSize:74 DesignDevice:iPhone4]];
    self.locGraphTotalkmLable.textAlignment = NSTextAlignmentCenter;
//    self.locGraphTotalkmLable.backgroundColor = COLOR;
    [self addSubview:self.locGraphTotalkmLable];
// 总公里title
    __weak typeof(self) WeakSelf = self;
    UILabel *totalkmTitle = [[UILabel alloc] init];
    totalkmTitle.text = @"总公里";
//    totalkmTitle.backgroundColor = COLOR;
    totalkmTitle.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:24 DesignDevice:iPhone4]];
    totalkmTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:totalkmTitle];
    [totalkmTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH, 0.4 * WeakSelf.locGraphTotalkmLable.h));
        make.left.mas_offset(0);
        make.top.mas_equalTo(WeakSelf.locGraphTotalkmLable.mas_bottom).with.offset(0);
    }];
    
// 图标的适配
    UIImageView *stepCountIconImageView = [[UIImageView alloc] init];
    stepCountIconImageView.image = [UIImage imageNamed:@"runboy_foot"];
    stepCountIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:stepCountIconImageView];
    [stepCountIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.1 * HEIGHT, 0.1 * HEIGHT));
        make.left.mas_offset(30);
        make.top.equalTo(totalkmTitle.mas_bottom).with.offset(0);
    }];
    
    UIImageView *speedIconImageView = [[UIImageView alloc] init];
    speedIconImageView.image = [UIImage imageNamed:@"runprepare_2"];
    speedIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:speedIconImageView];
    [speedIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.1 * HEIGHT, 0.1 * HEIGHT));
        make.centerX.mas_equalTo(WeakSelf);
        make.top.equalTo(totalkmTitle.mas_bottom).with.offset(0);
    }];
    
    UIImageView *calorieIconImageView = [[UIImageView alloc] init];
    calorieIconImageView.image = [UIImage imageNamed:@"runboy_calorie"];
    calorieIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:calorieIconImageView];
    [calorieIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.1 * HEIGHT, 0.1 * HEIGHT));
        make.right.mas_offset(-30);
        make.top.equalTo(totalkmTitle.mas_bottom).with.offset(0);
    }];
// 2排数据显示
    self.locGraphStepNumLable = [[UILabel alloc] init];
    self.locGraphStepNumLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:[Tools autoSuitFontSize:23 DesignDevice:iPhone4]];
    self.locGraphStepNumLable.textAlignment = NSTextAlignmentCenter;
    self.locGraphStepNumLable.text = @"9999";

    [self addSubview:self.locGraphStepNumLable];
    [self.locGraphStepNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.top.equalTo(calorieIconImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(stepCountIconImageView);
    }];
    
    self.locGraphCalorieLable = [[UILabel alloc] init];
    self.locGraphCalorieLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:[Tools autoSuitFontSize:23 DesignDevice:iPhone4]];
    self.locGraphCalorieLable.textAlignment = NSTextAlignmentCenter;
    self.locGraphCalorieLable.text = @"9999";

    [self addSubview:self.locGraphCalorieLable];
    [self.locGraphCalorieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.top.equalTo(calorieIconImageView.mas_bottom).with.offset(0);
        make.centerX.equalTo(calorieIconImageView);
    }];
    
    self.locGraphTempoLable = [[UILabel alloc] init];
    self.locGraphTempoLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:[Tools autoSuitFontSize:23 DesignDevice:iPhone4]];
    self.locGraphTempoLable.textAlignment = NSTextAlignmentCenter;
    self.locGraphTempoLable.text = @"99.99";
    [self addSubview:self.locGraphTempoLable];
    [self.locGraphTempoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.top.equalTo(calorieIconImageView.mas_bottom).with.offset(0);
        make.centerX.mas_equalTo(WeakSelf);
    }];
   // 2排title
    UILabel *stepCountLable = [[UILabel alloc] init];
    stepCountLable.text = @"累计步数";
    stepCountLable.font = [UIFont fontWithName:@"System Medium" size:[Tools autoSuitFontSize:14 DesignDevice:iPhone4]];
    stepCountLable.textAlignment = NSTextAlignmentCenter;

    [self addSubview:stepCountLable];
    [stepCountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.centerX.mas_equalTo(WeakSelf.locGraphStepNumLable);
        make.top.mas_equalTo(WeakSelf.locGraphCalorieLable.mas_bottom).with.offset(0);
    }];
    self.stepCountLable = stepCountLable;

    UILabel *calorieLable = [[UILabel alloc] init];
    calorieLable.text = @"累计卡路里";
    calorieLable.font = [UIFont fontWithName:@"System Medium" size:[Tools autoSuitFontSize:14 DesignDevice:iPhone4]];
    calorieLable.textAlignment = NSTextAlignmentCenter;
//    calorieLable.backgroundColor = COLOR;
    [self addSubview:calorieLable];
    [calorieLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.centerX.mas_equalTo(calorieIconImageView);
        make.top.mas_equalTo(WeakSelf.locGraphCalorieLable.mas_bottom).with.offset(0);
    }];
    
    UILabel *speedLable = [[UILabel alloc] init];
    speedLable.text = @"跑步累时";
    speedLable.font = [UIFont fontWithName:@"System Medium" size:[Tools autoSuitFontSize:14 DesignDevice:iPhone4]];
//    NSLog(@"suit font size :%f", [Tools autoSuitFontSize:14 DesignDevice:iPhone4]);
    speedLable.textAlignment = NSTextAlignmentCenter;
//    speedLable.backgroundColor = COLOR;
    [self addSubview:speedLable];
    [speedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(0.28 * WIDTH, 0.0875 * WIDTH));
        make.centerX.mas_equalTo(WeakSelf);
        make.top.mas_equalTo(WeakSelf.locGraphCalorieLable.mas_bottom).with.offset(0);
    }];
 
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
