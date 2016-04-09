//
//  RBMusicPlayerView.m
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBMusicPlayerView.h"

@implementation RBMusicPlayerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
    }
    return self;
}
- (void)creatSubViews{
    __weak typeof(self) WeakSelf = self;
    self.musicCurrentListLable = [[UILabel alloc] init];
    self.musicCurrentListLable.text = @"当前音乐列表";
    self.musicCurrentListLable.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:17 DesignDevice:iPhone4]];
    self.musicCurrentListLable.textAlignment = NSTextAlignmentCenter;

    [self addSubview:self.musicCurrentListLable];
    [self.musicCurrentListLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset([Tools autoSuitHeight:15 DesignDevice:iPhone4]);
        make.centerX.mas_equalTo(WeakSelf);
        make.size.mas_equalTo(CGSizeMake([Tools autoSuitFontSize:138 DesignDevice:iPhone4], [Tools autoSuitHeight:40 DesignDevice:iPhone4]));
        
    }];
    NSLog(@"suit heit = %f", [Tools autoSuitHeight:40 DesignDevice:iPhone4]);
    // 音乐图片
    self.musicPosterImageView = [[UIImageView alloc] init];
    self.musicPosterImageView.contentMode = UIViewContentModeScaleAspectFit;
//    self.musicPosterImageView.layer.masksToBounds = YES;
    [self addSubview:self.musicPosterImageView];
    self.musicPosterImageView.image = [UIImage imageNamed:@"iconfont-album"];
    [self.musicPosterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(WeakSelf.musicCurrentListLable.mas_left).with.offset(-[Tools autoSuitFontSize:20 DesignDevice:iPhone4]);
        make.centerY.mas_equalTo(WeakSelf.musicCurrentListLable);
        make.width.height.mas_equalTo(WeakSelf.musicCurrentListLable.mas_height);
    }];
//    self.musicPosterImageView.backgroundColor = COLOR;
    
    // 音乐列表
    self.musicLlistImageView = [[UIImageView alloc] init];
    self.musicLlistImageView.userInteractionEnabled = YES;
    self.musicLlistImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.musicLlistImageView.image = [UIImage imageNamed:@"iconfont-plist"];
    [self addSubview:self.musicLlistImageView];
    [self.musicLlistImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WeakSelf.musicCurrentListLable.mas_right).with.offset([Tools autoSuitFontSize:20 DesignDevice:iPhone4]);
        make.centerY.mas_equalTo(WeakSelf.musicCurrentListLable);
        make.width.height.mas_equalTo(WeakSelf.musicCurrentListLable.mas_height);
    }];
    
    // 上一曲\播放\下一曲
    
    self.musicPlayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.musicPlayBtn];
    [self.musicPlayBtn setTitle:@"播放" forState:UIControlStateNormal];
    self.musicPlayBtn.titleLabel.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:15 DesignDevice:iPhone4]];
    [self.musicPlayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(WeakSelf);
        make.top.mas_offset([Tools autoSuitHeight:66 DesignDevice:iPhone4]);
        make.bottom.mas_offset(-[Tools autoSuitHeight:75 DesignDevice:iPhone4]);
        make.left.mas_offset([Tools autoSuitFontSize:91 DesignDevice:iPhone4]);
        make.right.mas_offset(-[Tools autoSuitFontSize:91 DesignDevice:iPhone4]);
    }];
    
    self.musicNextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.musicNextBtn];
//    self.musicNextBtn.backgroundColor = COLOR;
    [self.musicNextBtn setTitle:@"下一曲" forState:UIControlStateNormal];
    self.musicNextBtn.titleLabel.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:15 DesignDevice:iPhone4]];
    [self.musicNextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(WeakSelf.musicPlayBtn);
        make.width.mas_equalTo([Tools autoSuitFontSize:45 DesignDevice:iPhone4]);
        make.height.mas_equalTo(WeakSelf.musicPlayBtn.mas_height);
        make.left.mas_equalTo(WeakSelf.musicPlayBtn.mas_right).with.offset([Tools autoSuitFontSize:33 DesignDevice:iPhone4]);
    }];

    
    self.musicLastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.musicLastBtn];
    self.musicLastBtn.titleLabel.font = [UIFont systemFontOfSize:[Tools autoSuitFontSize:15 DesignDevice:iPhone4]];
    [self.musicLastBtn setTitle:@"上一首" forState:UIControlStateNormal];
//    self.musicLastBtn.backgroundColor = COLOR;
    [self.musicLastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(WeakSelf.musicPlayBtn);
        make.width.mas_equalTo([Tools autoSuitFontSize:45 DesignDevice:iPhone4]);
        make.height.mas_equalTo(WeakSelf.musicPlayBtn.mas_height);
        make.right.mas_equalTo(WeakSelf.musicPlayBtn.mas_left).with.offset(-[Tools autoSuitFontSize:33 DesignDevice:iPhone4]);
    }];
// progress view
    self.musicProgressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
//    self.musicProgressView.backgroundColor = COLOR;
    self.musicProgressView.progress = 0.5;
    self.musicProgressView.tintColor = [UIColor greenColor];
    self.musicProgressView.trackTintColor = [UIColor redColor];
    [self addSubview:self.musicProgressView];
    [self.musicProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(WeakSelf);
        make.bottom.mas_offset(-[Tools autoSuitHeight:26 DesignDevice:iPhone4]);
        make.width.mas_equalTo([Tools autoSuitFontSize:221 DesignDevice:iPhone4]);
        make.height.mas_equalTo(2);
    }];
    
    
    
// time lable
    self.musicProgressTimeLable = [[UILabel alloc] init];
    self.musicProgressTimeLable.textAlignment = NSTextAlignmentCenter;
//    self.musicProgressTimeLable.backgroundColor = COLOR;
    self.musicProgressTimeLable.text = @"00:00";
    self.musicProgressTimeLable.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.musicProgressTimeLable];
    [self.musicProgressTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(WeakSelf.musicProgressView);
        make.height.mas_equalTo([Tools autoSuitHeight:20 DesignDevice:iPhone4]);
        make.left.mas_offset([Tools autoSuitFontSize:9 DesignDevice:iPhone4]);
        make.right.mas_equalTo(WeakSelf.musicProgressView.mas_left).with.offset(-[Tools autoSuitFontSize:3 DesignDevice:iPhone4]);
    }];
// total time lable
    self.musicTotalTimeLable = [[UILabel alloc] init];
    self.musicTotalTimeLable.text = @"00:00";
    self.musicTotalTimeLable.textAlignment = NSTextAlignmentCenter;
//    self.musicTotalTimeLable.backgroundColor = COLOR;
    [self addSubview:self.musicTotalTimeLable];
    self.musicTotalTimeLable.adjustsFontSizeToFitWidth = YES;
    [self.musicTotalTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(WeakSelf.musicProgressView);
        make.height.mas_equalTo([Tools autoSuitHeight:20 DesignDevice:iPhone4]);
        make.right.mas_offset(-[Tools autoSuitFontSize:9 DesignDevice:iPhone4]);
        make.left.mas_equalTo(WeakSelf.musicProgressView.mas_right).with.offset([Tools autoSuitFontSize:3 DesignDevice:iPhone4]);
    }];
}




@end
