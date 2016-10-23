//
//  QCCollectionPost.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCollectionPost.h"

@implementation QCCollectionPost

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"Id"] = @"id";
    return dict;
}

@end
