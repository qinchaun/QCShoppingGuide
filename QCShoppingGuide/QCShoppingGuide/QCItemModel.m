//
//  QCItem.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCItemModel.h"
#import "MJExtension.h"

@implementation QCItemModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"itemID"] = @"id";
    return dict;
}

@end
