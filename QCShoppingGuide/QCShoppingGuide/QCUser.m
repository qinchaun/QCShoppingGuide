//
//  QCUser.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCUser.h"

@implementation QCUser

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"userID"] = @"id";
    return dict;
}

@end
