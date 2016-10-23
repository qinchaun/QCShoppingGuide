//
//  QCChannels.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCChannelsModel.h"

@implementation QCChannelsModel

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"channelsID"] = @"id";
    return dic;
}

@end
