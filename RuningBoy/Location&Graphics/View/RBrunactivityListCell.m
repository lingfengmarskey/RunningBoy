//
//  RBrunactivityListCell.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunactivityListCell.h"

@interface RBrunactivityListCell();
@property (nonatomic, retain) UIImageView *tempRecordImageView;
@property (nonatomic, retain) UIImageView *timeRecordImageView;


@end

@implementation RBrunactivityListCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews
{
    self.creatTimeLable = [[UILabel alloc]init];
    [self.contentView addSubview:self.creatTimeLable];
    self.creatTimeLable.font = [UIFont systemFontOfSize:MLF_Width(13, iPhone4)];
    self.creatTimeLable.text = @"日期:2016/03/31";
    
    self.totalkiloLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.totalkiloLable];
    self.totalkiloLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.totalkiloLable.text = @"9999公里";
    self.totalkiloLable.textAlignment = NSTextAlignmentCenter;
    
    self.stateImageView =  [[UIImageView alloc] init];
    [self.contentView addSubview:self.stateImageView];
    self.stateImageView.userInteractionEnabled = YES;
    self.stateImageView.contentMode = UIViewContentModeScaleAspectFit;
   // feedback lable
    self.feedbackLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.feedbackLable];
    self.feedbackLable.font = [UIFont systemFontOfSize:MLF_Width(15, iPhone4)];
    self.feedbackLable.text = @"之前发布的消息概要**********";
    self.feedbackLable.numberOfLines = 0;
    
    // temp
    self.tempRecordLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.tempRecordLable];
    self.tempRecordLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.tempRecordLable.text = @"00'00''";
    self.tempRecordLable.adjustsFontSizeToFitWidth = YES;
    self.tempRecordLable.textAlignment = NSTextAlignmentCenter;
    
    // time lable
    self.timeRecordLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeRecordLable];
    self.timeRecordLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
    self.timeRecordLable.text = @"00:00";
    self.timeRecordLable.adjustsFontSizeToFitWidth = YES;
    self.timeRecordLable.textAlignment = NSTextAlignmentCenter;
    
    
    self.tempRecordImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.tempRecordImageView];
    self.tempRecordImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.tempRecordImageView.image = [UIImage imageNamed:@"runboy_tempo"];
    
    self.timeRecordImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.timeRecordImageView];
    self.timeRecordImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.timeRecordImageView.image = [UIImage imageNamed:@"runprepare_2"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.creatTimeLable.frame = CGRectMake(MLF_Width(8, iPhone4), MLF_Height(8, iPhone4), MLF_Width(104, iPhone4), MLF_Height(21, iPhone4));
    self.totalkiloLable.frame = CGRectMake(self.creatTimeLable.x, MLF_Height(35, iPhone4), self.creatTimeLable.w, MLF_Height(49, iPhone4));
    self.stateImageView.frame = CGRectMake(MLF_Width(131, iPhone4), self.creatTimeLable.y, MLF_Width(39, iPhone4), MLF_Width(39, iPhone4));
    //feed back lable
    self.feedbackLable.frame = CGRectMake(MLF_Width(181, iPhone4), self.creatTimeLable.y, MLF_Width(131, iPhone4), self.stateImageView.h);
    // temp record imageview
    self.tempRecordImageView.frame = CGRectMake(self.stateImageView.x, MLF_Height(57, iPhone4), MLF_Width(21, iPhone4), MLF_Width(21, iPhone4));
    // temp record lable
    self.tempRecordLable.frame = CGRectMake(MLF_Width(155, iPhone4), self.tempRecordImageView.y, MLF_Width(53, iPhone4), self.tempRecordImageView.h);
    // time record imageview
    self.timeRecordImageView.frame = CGRectMake(MLF_Width(241, iPhone4), self.tempRecordImageView.y, self.tempRecordImageView.w, self.tempRecordImageView.h);
    // time record lable
    self.timeRecordLable.frame = CGRectMake(MLF_Width(266, iPhone4), self.timeRecordImageView.y, MLF_Width(46, iPhone4), self.timeRecordImageView.h);

    
}

- (void)setModel:(Route *)model
{
    _model = model;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    self.creatTimeLable.text = [formatter stringFromDate:model.beginDate];
    if (model.totalDistances.floatValue > 1000) {
        CGFloat distance = model.totalDistances.floatValue / 1000.0;
        self.totalkiloLable.text = [NSString stringWithFormat:@"%.1f公里", distance];
    }else{
        self.totalkiloLable.text = [NSString stringWithFormat:@"%.1f米", model.totalDistances.floatValue];
    }
    self.feedbackLable.text = model.feedBack;
    
    self.tempRecordLable.text = [NSString stringWithFormat:@"%.1f m/s", model.averageVelocity.floatValue ? : 0.0];
    
    self.timeRecordLable.text = [NSString stringWithFormat:@"%@", model.totalTime];
    if ([model.runState isEqualToString:@"bad"]) {
        self.stateImageView.image = [UIImage imageNamed:@"iconfont-bad"];
    }else if ([model.runState isEqualToString:@"normal"]){
        self.stateImageView.image = [UIImage imageNamed:@"iconfont-normal"];
    }else{
        self.stateImageView.image = [UIImage imageNamed:@"iconfont-smile"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
