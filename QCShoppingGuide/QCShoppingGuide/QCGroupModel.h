//
//  QCGroupModel.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCGroupModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, assign) NSInteger group_id;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger items_count;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *name;

@end
