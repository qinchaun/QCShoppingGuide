//
//  QCDetailScrollView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCProductModel.h"

@interface QCDetailScrollView : UIScrollView

@property(nonatomic,strong)QCProductModel *product;

@end
