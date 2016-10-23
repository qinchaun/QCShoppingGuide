//
//  QCLoginViewController.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCBaseViewController.h"
#import "QCUser.h"

typedef void (^LoginSuccessBlock)(QCUser *);

@interface QCLoginViewController : QCBaseViewController
/** 登录成功之后的回调闭包 */
@property(nonatomic,copy)LoginSuccessBlock block;

@end
