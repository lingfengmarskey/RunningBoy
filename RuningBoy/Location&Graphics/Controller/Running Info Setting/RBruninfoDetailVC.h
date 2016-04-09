//
//  RBruninfoDetailVC.h
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBBaseViewController.h"

typedef void(^saveSettingBlock)(NSString *str, NSInteger num);
@interface RBruninfoDetailVC : RBBaseViewController
@property (nonatomic, assign) NSInteger selectedRowNum;
@property (nonatomic, copy) saveSettingBlock saveBlock;
@property (nonatomic, copy) NSString *unitString;

@end
