//
//  RBrunendShareView.m
//  RuningBoy
//
//  Created by marskey on 16/3/29.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunendShareView.h"

@implementation RBrunendShareView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
    }
    return self;
}
- (void)creatSubViews{
    self.smillBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.smillBtn.backgroundColor = COLOR;
    [self.smillBtn setImage:[UIImage imageNamed:@"iconfont-smile"] forState:UIControlStateNormal];
    self.smillBtn.contentMode = UIViewContentModeScaleAspectFill;
    self.smillBtn.tag = 1;
    [self addSubview:self.smillBtn];
    
    self.normalBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.normalBtn.backgroundColor = COLOR;
    [self.normalBtn setImage:[UIImage imageNamed:@"iconfont-normal"] forState:UIControlStateNormal];
    self.normalBtn.contentMode = UIViewContentModeScaleAspectFill;
    self.normalBtn.tag = 2;
    [self addSubview:self.normalBtn];
    
    self.badBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.badBtn.backgroundColor = COLOR;
    [self.badBtn setImage:[UIImage imageNamed:@"iconfont-bad"] forState:UIControlStateNormal];
    self.badBtn.contentMode = UIViewContentModeScaleAspectFill;
    self.badBtn.tag = 3;
    [self addSubview:self.badBtn];
    
    
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.submitBtn setTitle:@"submit" forState:UIControlStateNormal];
    [self addSubview:self.submitBtn];
    
    self.submitBtn.backgroundColor = [UIColor redColor];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.height.mas_equalTo(49);
    }];
// share text
    self.shareTextField = [UITextField new];
    [self addSubview:self.shareTextField];
    self.shareTextField.placeholder = @"发布当前想说的话";
    self.shareTextField.backgroundColor = Mlf_Color(254, 212, 65);
    self.shareTextField.font = [UIFont systemFontOfSize:MLF_Width(14, iPhone4)];


}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.smillBtn.frame = CGRectMake(MLF_Width(20, iPhone4), MLF_Height(16, iPhone4), MLF_Width(61, iPhone4), MLF_Width(61, iPhone4));
    self.normalBtn.frame = CGRectMake(MLF_Width(130, iPhone4), self.smillBtn.y, self.smillBtn.w, self.smillBtn.h);
    self.badBtn.frame = CGRectMake(MLF_Width(239, iPhone4), self.smillBtn.y, self.smillBtn.w, self.smillBtn.h);
    self.shareTextField.frame = CGRectMake(MLF_Width(15, iPhone4), MLF_Height(92, iPhone4), MLF_Width(285, iPhone4), MLF_Height(30, iPhone4));
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
