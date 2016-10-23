//
//  QCItemCell.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCItemModel.h"

@interface QCItemCell : UITableViewCell

/**
 *  item
 */
@property(nonatomic,strong)QCItemModel *item;

@end
