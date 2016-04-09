//
//  RBrunmusicPlistCell.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunmusicPlistCell.h"

@implementation RBrunmusicPlistCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews{
    
    __weak typeof(self) weakSelf = self;
    self.bgImageView = [UIImageView new];
    [self.contentView addSubview:self.bgImageView];
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.bgImageView.layer.masksToBounds = YES;
    self.bgImageView.userInteractionEnabled = YES;
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel *labe = [UILabel new];
    [self.contentView addSubview:labe];
    labe.text = @">>";
    labe.font = [UIFont systemFontOfSize:MLF_Width(24, iPhone4)];
    labe.textColor = [UIColor blackColor];
    [labe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf);
        make.right.offset(-10);
        make.top.offset(20);
        make.top.offset(-20);
    }];
    
    self.musicTitleLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.musicTitleLable];
    self.musicTitleLable.font = [UIFont systemFontOfSize:MLF_Width(24, iPhone4)];
    self.musicTitleLable.textColor = [UIColor blackColor];
    self.musicTitleLable.backgroundColor = COLOR;
    [self.musicTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(10);
        make.centerY.mas_equalTo(weakSelf);
        make.top.offset(20);
        make.bottom.offset(-20);
        make.width.mas_equalTo(160);
    }];
    
    
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
