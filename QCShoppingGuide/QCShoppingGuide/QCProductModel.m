//
//  QCProductModel.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCProductModel.h"

@implementation QCProductModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"productID"] = @"id";
    dict[@"describe"] = @"description";
    return dict;
}

@end
