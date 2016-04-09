//
//  LDPNetWorkTool.h
//  ZhiFuBao
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^SuccessBlock)(id result);
typedef void(^FailureBlock)(NSError *error);




//返回值类型
typedef NS_ENUM(NSUInteger, ResponseType){
    ResponseTypeDATA,
    ResponseTypeJSON,
    ResponseTypeXML
};
//body体类型
typedef NS_ENUM(NSUInteger,BodyType) {
    BodyTypeJSONString,
    BodyTypeNomal,
    
    
};


@interface LDPNetWorkTool : NSObject
/**
 *  GET请求
 *
 *  @param url          url
 *  @param parameter      参数
 *  @param header        请求头
 *  @param responseType    返回值类型
 *  @param progress      进度
 *  @param success       成功
 *  @param failure       失败
 */
+ (void)getWithURL:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary<NSString *, NSString *> *)header responsType:(ResponseType)responsType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure;


+ (void)postWithURL:(NSString *)url body:(id )body bodyType:(BodyType)bodyType httpHeader:(NSDictionary<NSString *, NSString *> *)header responsType:(ResponseType)responsType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure;




@end
