//
//  RBrunmusicPlistDetailHeaderView.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunmusicPlistDetailHeaderView.h"

@implementation RBrunmusicPlistDetailHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews{
    // 列表图片
    self.plistImageView = [UIImageView new];
    [self.contentView addSubview:self.plistImageView];
    self.plistImageView.image = [UIImage imageNamed:@"iconfont-normal"];
    self.plistImageView.userInteractionEnabled = YES;
    // 列表题目
    self.plistTitleLable = [UILabel new];
    [self.contentView addSubview:self.plistTitleLable];
    self.plistTitleLable.text = @"列表题目";
    self.plistTitleLable.backgroundColor = COLOR;
    self.plistTitleLable.textColor = [UIColor whiteColor];
    self.plistTitleLable.textAlignment = NSTextAlignmentCenter;
    self.plistTitleLable.font = [UIFont systemFontOfSize:MLF_Width(25, iPhone4)];
    // 列表简介
    self.plistInfoLable = [UILabel new];
    [self.contentView addSubview:self.plistInfoLable];
    self.plistInfoLable.text = @"列表简介";
    self.plistInfoLable.backgroundColor = COLOR;
    self.plistInfoLable.textColor = [UIColor whiteColor];
    self.plistInfoLable.textAlignment = NSTextAlignmentCenter;
    self.plistInfoLable.font = [UIFont systemFontOfSize:MLF_Width(16, iPhone4)];
    // 列表曲目总数
    self.plistCountLable = [UILabel new];
    [self.contentView addSubview:self.plistCountLable];
    self.plistCountLable.text = @"列表曲目总数";
    self.plistCountLable.backgroundColor = COLOR;
    self.plistCountLable.textColor = [UIColor grayColor];
    self.plistCountLable.textAlignment = NSTextAlignmentCenter;
    self.plistCountLable.font = [UIFont systemFontOfSize:MLF_Width(16, iPhone4)];
    
    // 系列按钮
    // share
    self.musicShareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.musicShareBtn setTitle:@"share" forState:UIControlStateNormal];
    self.musicShareBtn.titleLabel.font = [UIFont systemFontOfSize:MLF_Width(17  , iPhone4)];
    [self.contentView addSubview:self.musicShareBtn];
    self.musicShareBtn.backgroundColor = COLOR;
    // like
    self.musicLikeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.musicLikeBtn setTitle:@"like" forState:UIControlStateNormal];
    [self.contentView addSubview:self.musicLikeBtn];
    self.musicLikeBtn.backgroundColor = COLOR;
    // add
    self.musicPlistAddBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.musicPlistAddBtn setTitle:@"add" forState:UIControlStateNormal];
    [self.contentView addSubview:self.musicPlistAddBtn];
    self.musicPlistAddBtn.backgroundColor = COLOR;
    // etc.
    self.etcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.etcBtn setTitle:@"..." forState:UIControlStateNormal];
    [self.contentView addSubview:self.etcBtn];
    self.etcBtn.backgroundColor = COLOR;
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.plistImageView.frame = CGRectMake(MLF_Width(8, iPhone4), MLF_Height(12, iPhone4), MLF_Width(130, iPhone4), MLF_Width(130, iPhone4));
    self.plistTitleLable.frame = CGRectMake(MLF_Width(146, iPhone4), self.plistImageView.y, MLF_Width(161, iPhone4), MLF_Height(36, iPhone4));
    self.plistInfoLable.frame = CGRectMake(self.plistTitleLable.x, MLF_Height(49, iPhone4), self.plistTitleLable.w, MLF_Width(21, iPhone4));
    self.plistCountLable.frame = CGRectMake(self.plistTitleLable.x, MLF_Height(71, iPhone4), self.plistTitleLable.w, MLF_Height(21, iPhone4));
    // btn
    self.musicShareBtn.frame = CGRectMake(MLF_Width(163, iPhone4), MLF_Height(112, iPhone4), MLF_Width(30, iPhone4), MLF_Width(30, iPhone4));
    self.musicLikeBtn.frame = CGRectMake(MLF_Width(201, iPhone4), self.musicShareBtn.y, self.musicShareBtn.w, self.musicShareBtn.h);
    self.musicPlistAddBtn.frame = CGRectMake(MLF_Width(239, iPhone4), self.musicShareBtn.y, self.musicShareBtn.w, self.musicShareBtn.h);
    self.etcBtn.frame = CGRectMake(MLF_Width(277, iPhone4), self.musicShareBtn.y, self.musicShareBtn.w, self.musicShareBtn.h);
    
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
