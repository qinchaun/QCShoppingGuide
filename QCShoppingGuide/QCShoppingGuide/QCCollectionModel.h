//
//  QCCollection.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCCollectionModel : NSObject

@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy) NSString *banner_image_url;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, assign) NSInteger collectionID;
@property (nonatomic, assign) NSInteger created_at;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cover_image_url;
@property (nonatomic, assign) NSInteger updated_at;
@property (nonatomic, assign) NSInteger posts_count;

@end
