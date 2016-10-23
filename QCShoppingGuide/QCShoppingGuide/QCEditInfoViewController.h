//
//  QCEditInfoViewController.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCBaseViewController.h"

@interface QCEditInfoViewController : QCBaseViewController

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)void (^saveFinishBlock)(NSString *name,UIImage *image);

@end
