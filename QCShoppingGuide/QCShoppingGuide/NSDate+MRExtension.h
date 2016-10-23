//
//  NSDate+MRExtension.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MRExtension)

/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
/**
 *  时间戳转换时间字符串
 */
+ (NSString *)dateWithTimeStamp:(NSString *)timeStampString;

@end
