//
//  QCCollectionDetailController.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QCCollectionDetailController : UITableViewController
/**
 *  类型
 */
@property(nonatomic,copy)NSString *type;

/**
 *  id
 */
@property(nonatomic,assign)NSInteger ID;

@end
