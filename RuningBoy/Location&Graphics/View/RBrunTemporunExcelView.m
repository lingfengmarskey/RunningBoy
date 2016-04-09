//
//  RBrunTemporunExcelView.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunTemporunExcelView.h"
#import "RBvelocityTimeExcelView.h"
@interface RBrunTemporunExcelView();
@property (nonatomic, retain) UIImageView *timeImageView;

@property (nonatomic, retain) UIImageView *tempoImageView;

@property (nonatomic, retain) UIImageView *calorieImageView;

@property (nonatomic, retain) RBvelocityTimeExcelView *excelView;
@end

@implementation RBrunTemporunExcelView

//- (instancetype)initWithFrame:(CGRect)frame{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self creatSubViews];
//        
//    }
//    return self;
//}
- (instancetype)initWithFrame:(CGRect)frame BeginDate:(NSDate *)beginDate{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews:beginDate];
    }
    return self;
}
- (void)creatSubViews:(NSDate *)beginDate{
    self.excelView = [[RBvelocityTimeExcelView alloc] initWithFrame:self.bounds BeginDate:beginDate];
    [self addSubview:self.excelView];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.backBtn];
    [self.backBtn setImage:[UIImage imageNamed:@"iconfont-back"] forState:UIControlStateNormal];
    self.backBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.topTimeLable = [UILabel new];
    [self addSubview:self.topTimeLable];
    self.topTimeLable.textAlignment = NSTextAlignmentCenter;
    self.topTimeLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.topTimeLable.text = @"toptimelable";
    self.topTimeLable.adjustsFontSizeToFitWidth = YES;
    
    self.totalDistance = [UILabel new];
    self.totalDistance.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.totalDistance];
    self.totalDistance.textAlignment = NSTextAlignmentCenter;
    self.totalDistance.font = [UIFont systemFontOfSize:MLF_Width(20, iPhone4)];
    self.totalDistance.text = @"total distance";

    
    // 平均配速 时间 卡路里
    self.timeImageView = [UIImageView new];
    self.timeImageView.image = [UIImage imageNamed:@"runprepare_2"];
    [self addSubview:self.timeImageView];
    
    self.tempoImageView = [UIImageView new];
    self.tempoImageView.image = [UIImage imageNamed:@"runboy_tempo"];
    [self addSubview:self.tempoImageView];
    
    self.calorieImageView = [UIImageView new];
    self.calorieImageView.image = [UIImage imageNamed:@"runboy_calorie"];
    self.calorieImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:self.calorieImageView];
    
   
    self.timeLable = [UILabel new];
    self.timeLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.timeLable.textAlignment = NSTextAlignmentCenter;
    self.timeLable.text = @"00:00";
    [self addSubview:self.timeLable];
//    self.timeLable.backgroundColor = COLOR;
    
    self.tempoLable = [UILabel new];
    self.tempoLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.tempoLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.tempoLable];
    self.tempoLable.text = @"00'00''";
//    self.tempoLable.backgroundColor = COLOR;
    
    self.calorieLable = [UILabel new];
    self.calorieLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.calorieLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.calorieLable];
    self.calorieLable.adjustsFontSizeToFitWidth = YES;
    self.calorieLable.text = @"9999cal";
//    self.calorieLable.backgroundColor = COLOR;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backBtn.frame = CGRectMake(MLF_Width(15, iPhone4), MLF_Height(20, iPhone4), MLF_Width(44, iPhone4), MLF_Width(44, iPhone4));
    
    self.topTimeLable.frame = CGRectMake(0, 0, MLF_Width(154, iPhone4), self.backBtn.h);
    CGPoint point = self.topTimeLable.center;
    point = CGPointMake(0.5 * WIDTH, self.backBtn.center.y);
    self.topTimeLable.center = point;
    
    self.totalDistance.frame = CGRectMake(self.backBtn.x, self.backBtn.y + self.backBtn.h + MLF_Height(15, iPhone4), MLF_Width(105, iPhone4), MLF_Height(70, iPhone4));
 
    //
    self.timeImageView.frame = CGRectMake(MLF_Width(9, iPhone4), MLF_Height(258, iPhone4), MLF_Width(23, iPhone4), MLF_Width(23, iPhone4));
    self.timeLable.frame = CGRectMake(MLF_Width(33, iPhone4), self.timeImageView.y, MLF_Width(48, iPhone4), self.timeImageView.h);
    self.tempoImageView.frame = CGRectMake(MLF_Width(114, iPhone4), self.timeImageView.y, self.timeImageView.w, self.timeImageView.h);
    self.tempoLable.frame = CGRectMake(MLF_Width(138, iPhone4), self.tempoImageView.y, MLF_Width(68, iPhone4), self.tempoImageView.h);
    self.calorieImageView.frame = CGRectMake(MLF_Width(234, iPhone4), self.tempoImageView.y, self.tempoImageView.w, self.tempoImageView.h);
    self.calorieLable.frame = CGRectMake(MLF_Width(258, iPhone4), self.tempoImageView.y, MLF_Width(51, iPhone4), self.tempoImageView.h);
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
