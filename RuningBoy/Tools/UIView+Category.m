//
//  UIView+Category.m
//  UI13_UITableViewCell自适应
//
//  Created by dllo on 16/1/6.
//  Copyright © 2016年 u. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

- (void)setX:(CGFloat)x{
    CGRect fram = self.frame;
    fram.origin.x = x;
    self.frame = fram;
    
}
- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect fram = self.frame;
    fram.origin.y = y;
    self.frame = fram;
    
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w{
    CGRect fram = self.frame;
    fram.size.width = w;
    self.frame = fram;
}
- (CGFloat)w{
    return self.frame.size.width;
}
- (void)setH:(CGFloat)h{
    CGRect fram = self.frame;
    fram.size.height = h;
    self.frame = fram;
}
- (CGFloat)h{
    return self.frame.size.height;
}




@end
