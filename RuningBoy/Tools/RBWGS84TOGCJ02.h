//
//  RBWGS84TOGCJ02.h
//  RuningBoy
//
//  Created by marskey on 16/4/22.
//  Copyright © 2016年 marskey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBWGS84TOGCJ02 : NSObject
// 判断范围
+(BOOL)isLocationOutOfChina:(CLLocationCoordinate2D)location;
// 转换坐标

+(CLLocationCoordinate2D)transformFromWGSToGCJ:(CLLocationCoordinate2D)wgsLoc;
@end
