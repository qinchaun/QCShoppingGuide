//
//  QCProductDetailController.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCBaseViewController.h"
#import "QCProductModel.h"

@interface QCProductDetailController : QCBaseViewController
/**
 *  商品
 */
@property(nonatomic,strong)QCProductModel *product;

@end
