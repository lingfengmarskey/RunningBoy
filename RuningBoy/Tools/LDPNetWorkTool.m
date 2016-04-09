//
//  LDPNetWorkTool.m
//  ZhiFuBao
//
//  Created by dllo on 16/2/25.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "LDPNetWorkTool.h"
#import <AFNetworking.h>


@implementation LDPNetWorkTool

+ (void)getWithURL:(NSString *)url parameter:(NSDictionary *)parameter httpHeader:(NSDictionary<NSString *, NSString *> *)header responsType:(ResponseType)responsType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure{
    // 1. 初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. 处理请求头
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    // 3. 处理返回值类型
    switch (responsType) {
        case ResponseTypeDATA: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case ResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case ResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
    }
    // 4. 设置返回值支持的文本类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    // 5. GET 请求
    [manager GET:url parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}





+ (void)postWithURL:(NSString *)url body:(id )body
           bodyType:(BodyType)bodyType httpHeader:(NSDictionary<NSString *, NSString *> *)header responsType:(ResponseType)responsType progress:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlock)failure{
    
    // 1. 初始化sessionManager
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2. 处理请求头
    for (NSString *key in header.allKeys) {
        [manager.requestSerializer setValue:header[key] forHTTPHeaderField:key];
    }
    // 3. 处理返回值类型
    switch (responsType) {
        case ResponseTypeDATA: {
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        }
        case ResponseTypeJSON: {
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
        }
        case ResponseTypeXML: {
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        }
    }
    // 4. 设置返回值支持的文本类型
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    //    5.处理body类型
    switch (bodyType) {
        case BodyTypeJSONString:{
            [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
                return parameters;
            }];
            break;
        }case BodyTypeNomal:{
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            
            break;
        }}
    
    [manager POST:url parameters:body progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
    
}









@end
