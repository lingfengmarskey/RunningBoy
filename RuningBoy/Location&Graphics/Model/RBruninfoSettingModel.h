//
//  RBruninfoSettingModel.h
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SettingPubUnits, SettingStature, SettingBodyWeight, SettingGender;
@interface RBruninfoSettingModel : NSObject
@property (nonatomic, copy) NSString *runSettingTitle;
@property (nonatomic, retain) NSArray *componnetArr;
+ (NSArray *)getRunInfoSettingModels;
+ (NSArray *)getRunInfoSettingBritishModels;
@end
