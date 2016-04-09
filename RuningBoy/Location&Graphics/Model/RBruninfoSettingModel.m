//
//  RBruninfoSettingModel.m
//  RuningBoy
//
//  Created by marskey on 16/3/26.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import "RBruninfoSettingModel.h"

@implementation RBruninfoSettingModel

+ (NSArray *)getRunInfoSettingModels{
    RBruninfoSettingModel *model = [RBruninfoSettingModel new];
    model.runSettingTitle = @"计算单位";
    model.componnetArr = @[@[@"公制", @"英制"]];
    
    NSMutableArray *stareArr = [NSMutableArray array];
    for (int i = 54 ; i <= 246; i++) {
        [stareArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    NSMutableArray *demArr = [NSMutableArray array];
    for (int i = 0; i <= 9; i++) {
        [demArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    RBruninfoSettingModel *modelstare = [RBruninfoSettingModel new];
    modelstare.runSettingTitle = @"身高";
    modelstare.componnetArr = @[stareArr, demArr];
    NSMutableArray *weightArr = [NSMutableArray array];
    for (int i = 2; i <= 250 ; i++) {
        [weightArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    RBruninfoSettingModel *modelweight = [RBruninfoSettingModel new];
    modelweight.runSettingTitle = @"体重";
    modelweight.componnetArr = @[weightArr, demArr];
    
    RBruninfoSettingModel *modelgender = [RBruninfoSettingModel new];
    modelgender.runSettingTitle = @"性别";
    modelgender.componnetArr = @[@[@"男性", @"女性", @"你还想干啥"]];

    return @[model, modelstare, modelweight, modelgender];
}
+ (NSArray *)getRunInfoSettingBritishModels{
    RBruninfoSettingModel *model = [RBruninfoSettingModel new];
    model.runSettingTitle = @"计算单位";
    model.componnetArr = @[@[@"公制", @"英制"]];
    
    NSMutableArray *stareArr = [NSMutableArray array];
    for (int i = 1 ; i <= 8; i++) {
        [stareArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    NSMutableArray *demArr = [NSMutableArray array];
    for (int i = 0; i <= 9; i++) {
        [demArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    RBruninfoSettingModel *modelstare = [RBruninfoSettingModel new];
    modelstare.runSettingTitle = @"身高";
    modelstare.componnetArr = @[stareArr, demArr];
    
    NSMutableArray *weightArr = [NSMutableArray array];
    for (int i = 5; i <= 550 ; i++) {
        [weightArr addObject:[NSString stringWithFormat:@"%d", i]];
    }
    RBruninfoSettingModel *modelweight = [RBruninfoSettingModel new];
    modelweight.runSettingTitle = @"体重";
    modelweight.componnetArr = @[weightArr, demArr];
    
    RBruninfoSettingModel *modelgender = [RBruninfoSettingModel new];
    modelgender.runSettingTitle = @"性别";
    modelgender.componnetArr = @[@[@"男性", @"女性", @"你还想干啥"]];
    
    return @[model, modelstare, modelweight, modelgender];
    
    
}
@end
