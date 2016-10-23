//
//  QCNetworkTool.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCNetworkTool : NSObject<NSCopying>

+(instancetype)sharedNetworkTool;

- (void)loadDataInfo:(nullable NSString *)URLString
          parameters:(nullable id)parameters
             success:(nullable void (^)(id _Nullable responseObject))success
             failure:(nullable void (^)(NSError *_Nullable error))failure;

-(void)loadDataInfoPost:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

-(void)loadDataInfoDelete:(NSString *)URLString parameters:(id)parameters success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

@end
