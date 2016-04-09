//
//  UIDevice+RBIPhoneModel.m
//  RuningBoy
//
//  Created by marskey on 16/3/25.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "UIDevice+RBIPhoneModel.h"

@implementation UIDevice (RBIPhoneModel)


- (iPhoneModel)getCurrentDevcieModel{
    CGFloat currentWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat currentHeight = [UIScreen mainScreen].bounds.size.height;
    if (currentHeight == 480 && currentWidth == 320) {
//        NSLog(@"current device model: iPhone 4/4s");
        return iPhone4;
    }else if (currentWidth == 320 && currentHeight == 568){
//        NSLog(@"current device model: iPhone 5/5s");
        return iPhone5;
    }else if (currentWidth == 375 && currentHeight == 667){
//        NSLog(@"current device model: iPhone 6/6s");
        return iPhone6;
    }else{
//        NSLog(@"current device model: iPhone 6 plus");
        return iPhone6P;
    }
}
+ (CGFloat)getWidthFromeDevice:(iPhoneModel)deviceModel{
    switch (deviceModel) {
        case iPhone4:
            return 320.0;
            break;
        case iPhone5:
            return 320;
            break;
        case iPhone6:
            return 375;
            break;
        case iPhone6P:
            return 414;
            break;
        default:
            break;
    }
}

+ (CGFloat)getHeightFromeDevice:(iPhoneModel)deviceModel{
    switch (deviceModel) {
        case iPhone4:
            return 480;
            break;
        case iPhone5:
            return 568;
            break;
        case iPhone6:
            return 667;
            break;
        case iPhone6P:
            return 736;
            break;
        default:
            break;
    }
}
@end
