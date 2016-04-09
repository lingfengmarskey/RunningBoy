//
//  RBrunprepareCell.m
//  RuningBoy
//
//  Created by marskey on 16/3/27.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBrunprepareCell.h"

@implementation RBrunprepareCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
        
    }
    return self;
}
- (void)creatSubViews{
    self.titleLable = [[UILabel alloc] init];
    self.titleLable.textAlignment = NSTextAlignmentCenter;
    self.titleLable.font = [UIFont fontWithName:@"Helvetica Bold" size:[Tools autoSuitFontSize:30 DesignDevice:iPhone4]];
    [self.contentView addSubview:self.titleLable];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.titleLable.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height * 0.5);
    
}
@end
