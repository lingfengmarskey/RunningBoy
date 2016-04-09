//
//  UIDevice+RBIPhoneModel.h
//  RuningBoy
//
//  Created by marskey on 16/3/25.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, iPhoneModel) {
    iPhone4 = 0,
    iPhone5,
    iPhone6,
    iPhone6P
};

@interface UIDevice (RBIPhoneModel)

//@property (nonatomic, assign, readonly) iPhoneModel iPhoneDeviceModel;
// 获取当前机型
- (iPhoneModel)getCurrentDevcieModel;
+ (CGFloat)getWidthFromeDevice:(iPhoneModel)deviceModel;
+ (CGFloat)getHeightFromeDevice:(iPhoneModel)deviceModel;
@end
