//
//  QCChannels.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QCChannelsModel : NSObject
/**
 *  id
 */
@property(nonatomic,assign)NSInteger channelsID;

/**
 *  eidtable
 */
@property(nonatomic,assign)NSInteger editable;

/**
 *  name
 */
@property(nonatomic,copy)NSString *name;

@end
