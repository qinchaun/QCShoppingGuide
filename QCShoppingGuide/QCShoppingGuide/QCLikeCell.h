//
//  QCLikeCell.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCItemModel.h"
#import "QCProductModel.h"

@interface QCLikeCell : UITableViewCell

@property(nonatomic,strong)QCItemModel *item;
@property(nonatomic,strong)QCProductModel *product;

@end
