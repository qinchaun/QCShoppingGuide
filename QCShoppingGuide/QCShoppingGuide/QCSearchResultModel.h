//
//  QCSearchResultModel.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCSearchResultModel : NSObject

/**
 *  resultID
 */
@property (nonatomic, assign) NSInteger resultID;
/**
 *  favorites_count
 */
@property (nonatomic, assign) NSInteger favorites_count;

/**
 *  likes_count
 */
@property (nonatomic, assign) NSInteger likes_count;

/**
 * price
 */
@property (nonatomic, copy) NSString *price;

/**
 *  liked
 */
@property (nonatomic, assign) BOOL liked;

/**
 * cover_image_url
 */
@property (nonatomic, copy) NSString *cover_image_url;

/**
 * describe
 */
@property (nonatomic, copy) NSString *describe;

/**
 * name
 */
@property (nonatomic, copy) NSString *name;

@end
