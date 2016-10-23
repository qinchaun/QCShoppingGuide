//
//  QCShareBtnsView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCShareBtnDelegate <NSObject>

@optional
-(void)shareBtnClickWithTag:(NSInteger)index;

@end

@interface QCShareBtnsView : UIView

@property(nonatomic,weak)id<QCShareBtnDelegate> delegate;

@end
