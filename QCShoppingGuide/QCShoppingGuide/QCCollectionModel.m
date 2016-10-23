//
//  QCCollection.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCollectionModel.h"

@implementation QCCollectionModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"collectionID"] = @"id";
    return dic;
}

@end
