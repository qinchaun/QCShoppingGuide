//
//  QCNetworkTool.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCNetworkTool.h"

@interface QCNetworkTool ()

@end

@implementation QCNetworkTool

+(void)initialize{
    [SVProgressHUD setMinimumDismissTimeInterval:1.0];
}

#pragma mark - 单例

static id _instance;

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+(instancetype)sharedNetworkTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"ncajsdhn");
        _instance = [[self alloc]init];
    });
    
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

#pragma mark - 工具类方法
/**
 *  加载数据
 */
- (void)loadDataInfo:(NSString *)URLString
          parameters:(id)parameters
             success:(void (^)(id _Nullable responseObject))success
             failure:(void (^)(NSError *error))failure {
    
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [[AFHTTPSessionManager manager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 回调成功之后的block
        success(responseObject);
        [SVProgressHUD showSuccessWithStatus:@"加载完成!"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        // 回调失败之后的block
        [SVProgressHUD showErrorWithStatus:@"加载失败~"];
                failure(error);
    }];
    
    [SVProgressHUD dismiss];
}

-(void)loadDataInfoPost:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[AFHTTPSessionManager manager]POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //回调成功后的block
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //回调失败之后的block
        failure(error);
    }];
    [SVProgressHUD dismiss];
}

-(void)loadDataInfoDelete:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [[AFHTTPSessionManager manager]DELETE:URLString parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    [SVProgressHUD dismiss];
}


@end
