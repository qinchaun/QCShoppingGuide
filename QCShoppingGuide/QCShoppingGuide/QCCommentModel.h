//
//  QCComment.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QCUser.h"

@interface QCCommentModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger item_id;
@property (nonatomic, strong) QCUser *user;

@end
