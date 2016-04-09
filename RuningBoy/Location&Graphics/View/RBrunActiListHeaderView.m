//
//  RBrunActiListHeaderView.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunActiListHeaderView.h"

@implementation RBrunActiListHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{

self.dateLable = [UILabel new];
[self.contentView addSubview:self.dateLable];
self.dateLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
self.dateLable.textAlignment = NSTextAlignmentLeft;
self.dateLable.text = @"3月";

self.monthDistanceLable = [UILabel new];
[self.contentView addSubview:self.monthDistanceLable];
self.monthDistanceLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
self.monthDistanceLable.textAlignment = NSTextAlignmentLeft;
self.monthDistanceLable.text = @"总公里数";

self.monthCalorieLable = [UILabel new];
[self.contentView addSubview:self.monthCalorieLable];
self.monthCalorieLable.font = [UIFont systemFontOfSize:MLF_Width(17, iPhone4)];
self.monthCalorieLable.textAlignment = NSTextAlignmentLeft;
self.monthCalorieLable.text = @"总卡路里数";
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.dateLable.frame = CGRectMake(MLF_Width(8, iPhone4), 0, MLF_Width(56, iPhone4), MLF_Height(21, iPhone4));
    self.monthDistanceLable.frame = CGRectMake(self.dateLable.x + self.dateLable.w, self.dateLable.y, MLF_Width(124, iPhone4), self.dateLable.h);
    self.monthCalorieLable.frame = CGRectMake(MLF_Width(188, iPhone4), self.monthDistanceLable.y, self.monthDistanceLable.w, self.monthDistanceLable.h);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
