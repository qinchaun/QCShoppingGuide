//
//  QCCategoryBottomView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCCategoryGroupDelegate <NSObject>

@optional
-(void)groupButtonItemClick:(UIButton *)btn;

@end

@interface QCCategoryBottomView : UIView

/** 协议 */
@property(nonatomic,weak)id<QCCategoryGroupDelegate> groupDelegate;

@end
