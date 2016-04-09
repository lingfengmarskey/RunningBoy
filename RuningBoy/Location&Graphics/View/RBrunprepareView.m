//
//  RBrunprepareView.m
//  RuningBoy
//
//  Created by marskey on 16/3/27.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunprepareView.h"

@implementation RBrunprepareView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}
- (void)creatSubViews{

    self.runprepareViewTitle = [[UILabel alloc] init];
    [self addSubview:self.runprepareViewTitle];
    self.runprepareViewTitle.font = [UIFont fontWithName:@"Helvetica Bold" size:[Tools autoSuitFontSize:35 DesignDevice:iPhone4]];
    self.runprepareViewTitle.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.runprepareViewTitle];
    
    
    self.runprepareViewImageView = [UIImageView new];
    [self addSubview:self.runprepareViewImageView];
    self.runprepareViewImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.runprepareViewImageView.userInteractionEnabled = YES;
    [self addSubview:self.runprepareViewImageView];

}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.runprepareViewTitle.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.3);
    self.runprepareViewImageView.frame = CGRectMake(0, self.bounds.size.height * 0.3, self.bounds.size.width, self.bounds.size.height * 0.7);
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
