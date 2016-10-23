//
//  QCMineChoiceBar.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCMineChoiceBarDelegate <NSObject>

@optional
-(void)choiceBarClick:(NSInteger)index;

@end

@interface QCMineChoiceBar : UIView

@property(nonatomic,weak)id<QCMineChoiceBarDelegate> delegate;

@end
