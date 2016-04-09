//
//  RBrunmusicPlistDetailCell.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunmusicPlistDetailCell.h"

@implementation RBrunmusicPlistDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
//    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.headImageView = [UIImageView new];
    [self.contentView addSubview:self.headImageView];
    self.headImageView.backgroundColor = COLOR;
    self.headImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headImageView.userInteractionEnabled = YES;
    
    self.songNameLable = [UILabel new];
    [self.contentView addSubview:self.songNameLable];
    self.songNameLable.text = @"歌曲名字";
    self.songNameLable.font = [UIFont fontWithName:@"System Medium" size:MLF_Width(16, iPhone4)];
//    self.songNameLable.textAlignment = NSTextAlignmentCenter;

    self.singerNameLable = [UILabel new];
    [self.contentView addSubview:self.singerNameLable];
    self.singerNameLable.text = @"歌手名字";
    self.singerNameLable.font = [UIFont fontWithName:@"System Medium" size:MLF_Width(16, iPhone4)];
//    self.singerNameLable.textAlignment = NSTextAlignmentCenter;
    
    self.songTimeLable = [UILabel new];
    [self.contentView addSubview:self.songTimeLable];
    self.songTimeLable.backgroundColor = COLOR;
    self.songTimeLable.text = @"歌曲时间";
    self.songTimeLable.font = [UIFont fontWithName:@"System Medium" size:MLF_Width(16, iPhone4)];
    self.songTimeLable.textAlignment = NSTextAlignmentCenter;
    
    self.moreLable = [UILabel new];
    [self.contentView addSubview:self.moreLable];
    self.moreLable.text = @"...";
    self.moreLable.backgroundColor = [UIColor blackColor];
    self.moreLable.userInteractionEnabled = YES;
    self.moreLable.textAlignment = NSTextAlignmentCenter;
    self.moreLable.textColor = [UIColor whiteColor];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.headImageView.frame = CGRectMake(MLF_Width(13, iPhone4), MLF_Height(3, iPhone4), MLF_Width(48, iPhone4), MLF_Width(48, iPhone4));
    self.songNameLable.frame = CGRectMake(MLF_Width(65, iPhone4), self.headImageView.y, MLF_Width(135, iPhone4), MLF_Height(21, iPhone4));
    self.singerNameLable.frame = CGRectMake(self.songNameLable.x, MLF_Height(30, iPhone4), self.songNameLable.w, self.songNameLable.h);
    self.songTimeLable.frame = CGRectMake(MLF_Width(216, iPhone4), MLF_Height(16, iPhone4), MLF_Width(47, iPhone4), MLF_Height(21, iPhone4));
    self.moreLable.frame = CGRectMake(MLF_Width(274, iPhone4), MLF_Height(16, iPhone4), MLF_Width(30, iPhone4), self.songTimeLable.h);
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
