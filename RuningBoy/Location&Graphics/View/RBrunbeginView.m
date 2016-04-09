//
//  RBrunbeginView.m
//  RuningBoy
//
//  Created by marskey on 16/3/28.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunbeginView.h"

@interface RBrunbeginView()

@property (nonatomic, retain) UIImageView *logoImageView;
@property (nonatomic, retain) UIImageView *sequenceImageView;
@property (nonatomic, retain) UIImageView *reverseImageView;


@end
//NSString *const DefaultString = @"默认字符串";
@implementation RBrunbeginView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
    }
    return self;
}
- (void)creatSubViews{
    self.bgImageView = [UIImageView new];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView.layer.masksToBounds = YES;
    self.bgImageView.userInteractionEnabled = YES;
    self.bgImageView.image = [UIImage imageNamed:@"runboybg_test_1"];
    [self addSubview:self.bgImageView];
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blur];
    blurView.alpha = 0;
    blurView.frame = self.bounds;
    [self addSubview:blurView];
    self.blurView = blurView;
    
    self.topMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.topMapBtn.layer.masksToBounds = YES;
    [self.topMapBtn setImage:[UIImage imageNamed:@"runboy_map_test_2"] forState:UIControlStateNormal];
    [self addSubview:self.topMapBtn];
    
    self.photoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.photoBtn setImage:[UIImage imageNamed:@"runboy_photo_1"] forState:UIControlStateNormal];
    self.photoBtn.layer.masksToBounds = YES;
    self.photoBtn.alpha = 0;
    [self addSubview:self.photoBtn];

    self.topLockBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topLockBtn setImage:[UIImage imageNamed:@"runboy_unlock_test_1"] forState:UIControlStateNormal];
    self.topLockBtn.layer.masksToBounds = YES;
    [self addSubview:self.topLockBtn];
   

    
    UIImageView *logoImageView = [UIImageView new];
    logoImageView.image = [UIImage imageNamed:@"runbboylogo_test_2"];
    logoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:logoImageView];
    self.logoImageView = logoImageView;
    
    self.showDataLable = [UILabel new];
    self.showDataLable.textAlignment = NSTextAlignmentCenter;
    self.showDataLable.font = [UIFont fontWithName:@"Helvetica Neue" size:MLF_Width(70, iPhone4)];
    self.showDataLable.textColor = [UIColor whiteColor];
    self.showDataLable.text = @"0.00";
    [self addSubview:self.showDataLable];
    
    self.dataUnitLabe = [UILabel new];
    self.dataUnitLabe.textAlignment = NSTextAlignmentCenter;
    self.dataUnitLabe.font = [UIFont systemFontOfSize:MLF_Width(22, iPhone4)];
    self.dataUnitLabe.textColor = Mlf_Color(248, 248, 248);

    self.dataUnitLabe.text = @"公里";
    [self addSubview:self.dataUnitLabe];
    // tempo----
    self.sequenceTimeLable = [UILabel new];
    self.sequenceTimeLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:MLF_Width(22, iPhone4)];
    self.sequenceTimeLable.textAlignment = NSTextAlignmentCenter;
    self.sequenceTimeLable.textColor = [UIColor whiteColor];
    self.sequenceTimeLable.text = @"00'00''";
    [self addSubview:self.sequenceTimeLable];

    self.sequenceImageView = [UIImageView new];
    self.sequenceImageView.image = [UIImage imageNamed:@"runboy_tempo_1"];
    self.sequenceImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.sequenceImageView];

    
    // time----
    self.reverseImageView = [UIImageView new];
    self.reverseImageView.image = [UIImage imageNamed:@"runboy_time_1"];
    self.reverseImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.reverseImageView];
    
    self.reverseTimeLable = [UILabel new];
    self.reverseTimeLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:MLF_Width(22, iPhone4)];
    self.reverseTimeLable.textAlignment = NSTextAlignmentCenter;
    self.reverseTimeLable.textColor = [UIColor whiteColor];
    self.reverseTimeLable.text = @"00:00";
    [self addSubview:self.reverseTimeLable];
   // stop btn
    self.stopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.stopBtn.backgroundColor = [UIColor redColor];
    [self.stopBtn setImage:[UIImage imageNamed:@"runboy_checkflag_1"] forState:UIControlStateNormal];
    [self.stopBtn setImage:[UIImage imageNamed:@"runboy_stopbtn_highlight_1"] forState:UIControlStateHighlighted];
    self.stopBtn.layer.masksToBounds = YES;
    self.stopBtn.contentMode = UIViewContentModeCenter;
    self.stopBtn.alpha = 0; // default is 0
    [self addSubview:self.stopBtn];
    
    // 开始按钮
    self.startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.startBtn setImage:[UIImage imageNamed:@"runboy_pause_test_1"] forState:UIControlStateNormal];
    self.startBtn.layer.masksToBounds = YES;
    [self addSubview:self.startBtn];
    
    // unlock lable
    self.unlockLable = [UILabel new];
    self.unlockLable.userInteractionEnabled = YES;
    self.unlockLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:MLF_Width(17, iPhone4)];
    self.unlockLable.textColor = [UIColor whiteColor];
    self.unlockLable.text = @"滑动屏幕以解锁";
    self.unlockLable.alpha = 0;
    self.unlockLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.unlockLable];
    
    // current lable or unlock place
    self.currentLable = [UILabel new];
    self.currentLable.userInteractionEnabled = YES;
    self.currentLable.font = [UIFont fontWithName:@"Helvetica Neue Medium" size:MLF_Width(17, iPhone4)];
    self.currentLable.textColor = [UIColor whiteColor];
    self.currentLable.text = @"当前音乐/无音乐";
    self.currentLable.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.currentLable];
    
    // last song btn
    self.lastSongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.lastSongBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.lastSongBtn setImage:[UIImage imageNamed:@"runboy_lastsong_2"] forState:UIControlStateNormal];
    [self addSubview:self.lastSongBtn];
    [self.lastSongBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-MLF_Height(12, iPhone4));
        make.left.offset(MLF_Width(20, iPhone4));
        make.size.mas_equalTo(CGSizeMake(MLF_Width(74, iPhone4), MLF_Height(30, iPhone4)));
    }];
    
    
    // next song btn
    self.nextSontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.nextSontBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.nextSontBtn setImage:[UIImage imageNamed:@"runboy_nextsong_2"] forState:UIControlStateNormal];
    [self addSubview:self.nextSontBtn];
    [self.nextSontBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-MLF_Height(12, iPhone4));
        make.right.offset(-MLF_Width(20, iPhone4));
        make.size.mas_equalTo(CGSizeMake(MLF_Width(74, iPhone4), MLF_Height(30, iPhone4)));
    }];
    
    
    // play or pause btn
    self.playOrPauseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playOrPauseBtn setImage:[UIImage imageNamed:@"runboy_play_2"] forState:UIControlStateNormal];
    [self addSubview:self.playOrPauseBtn];
    self.playOrPauseBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    __weak typeof(self) WeakSelf = self;
    [self.playOrPauseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.lastSongBtn.mas_right).with.offset(13);
        make.right.mas_equalTo(WeakSelf.nextSontBtn.mas_left).with.offset(-13);
        make.centerY.mas_equalTo(WeakSelf.lastSongBtn.mas_centerY);
        make.height.mas_equalTo(WeakSelf.lastSongBtn.mas_height);
    }];
    
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.bgImageView.frame = self.bounds;
    
    self.topMapBtn.frame = CGRectMake(0, 20, MLF_Width(29, iPhone4),MLF_Width(29, iPhone4));
    self.topMapBtn.layer.cornerRadius = 0.5 * MLF_Width(29, iPhone4);
    
    
    self.topLockBtn.frame = CGRectMake(self.bounds.size.width - MLF_Width(29, iPhone4), 20, MLF_Width(29, iPhone4),MLF_Width(29, iPhone4));
    self.topLockBtn.layer.cornerRadius = 0.5 * MLF_Width(29, iPhone4);
    
    self.photoBtn.frame = self.topLockBtn.frame;
    
    self.logoImageView.frame = CGRectMake(0, 0, MLF_Width(140, iPhone4), MLF_Width(29, iPhone4));
    self.logoImageView.center = CGPointMake(WIDTH * 0.5, MLF_Width(29, iPhone4) * 0.5 + 20);
    
    self.showDataLable.frame = CGRectMake(0, self.logoImageView.h + self.logoImageView.y, WIDTH, MLF_Height(103, iPhone4));
    
    
    self.dataUnitLabe.frame = CGRectMake(0, 0, MLF_Width(59, iPhone4), MLF_Height(28, iPhone4));
    
    self.dataUnitLabe.center = CGPointMake(WIDTH * 0.5, MLF_Height(28, iPhone4) * 0.5 + self.showDataLable.h + self.showDataLable.y);
    
    // 正序时间的图标
    self.sequenceImageView.frame = CGRectMake(MLF_Width(24, iPhone4), self.dataUnitLabe.h + self.dataUnitLabe.y + MLF_Height(21, iPhone4), MLF_Width(30, iPhone4), MLF_Width(30, iPhone4));
    // 正序的时间
    self.sequenceTimeLable.frame = CGRectMake(self.sequenceImageView.x + self.sequenceImageView.w, self.sequenceImageView.y, MLF_Width(80, iPhone4), self.sequenceImageView.h);

    // 倒序的图标
    self.reverseImageView.frame = CGRectMake(self.sequenceImageView.x, self.sequenceImageView.h + self.sequenceImageView.y + MLF_Height(71, iPhone4), self.sequenceImageView.w, self.sequenceImageView.h);
    // 倒序的时间
    self.reverseTimeLable.frame = CGRectMake(self.sequenceTimeLable.x, self.reverseImageView.y, self.sequenceTimeLable.w, self.sequenceTimeLable.h);
    
    // 停止按钮
    self.stopBtn.frame = CGRectMake(MLF_Width(192, iPhone4), 0, MLF_Width(96, iPhone4), MLF_Width(95, iPhone4));
    CGPoint point = self.stopBtn.center;
    point.y = self.sequenceImageView.y + self.sequenceImageView.h + MLF_Height(35, iPhone4);
    self.stopBtn.center = point;
    self.stopBtn.layer.cornerRadius = 0.5 * MLF_Width(96, iPhone4);
    
    // 开始按钮
    self.startBtn.frame = CGRectMake(MLF_Width(192, iPhone4), 0, MLF_Width(96, iPhone4), MLF_Width(96, iPhone4));
    point = self.startBtn.center;
    point.y = self.sequenceImageView.y + self.sequenceImageView.h + MLF_Height(35, iPhone4);
    self.startBtn.center = point;
    self.startBtn.layer.cornerRadius = 0.5 * MLF_Width(95, iPhone4);
    
    // 解锁lable
    self.unlockLable.frame = CGRectMake(self.reverseImageView.x, self.reverseImageView.y + self.reverseImageView.h + MLF_Height(8, iPhone4), WIDTH - 2 * self.reverseImageView.x, MLF_Height(40, iPhone4));
    // 当前音乐lable 或滑动区域
    self.currentLable.frame = CGRectMake(self.unlockLable.x, self.unlockLable.y + self.unlockLable.h + 2, self.unlockLable.w, self.unlockLable.h);
    
    //上一曲 下一曲 开始播放 按钮

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
