//
//  QCProductDetailToolBar.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCProductDetailToolBarDelegate <NSObject>

@optional
-(void)toolBarDidClickedTMALLButton;

@end

@interface QCProductDetailToolBar : UIView

@property(nonatomic,weak)id<QCProductDetailToolBarDelegate> delegate;

@end
