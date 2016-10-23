//
//  QCSearchResultModel.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCSearchResultModel.h"

@implementation QCSearchResultModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"resultID"] = @"id";
    dict[@"describle"] = @"description";
    return dict;
}

@end
