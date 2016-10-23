//
//  QCMineHeaderView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCMineHeaderDelegate <NSObject>

@optional

-(void)headerMessageClick:(UIButton *)btn;
-(void)headerSettingClick:(UIButton *)btn;
-(void)headerIconClick:(UIButton *)btn;

@end

@interface QCMineHeaderView : UIView

@property(nonatomic,weak)id<QCMineHeaderDelegate> delegate;
@property(nonatomic,strong)UIImageView *bgImageView;
@property(nonatomic,strong)UIButton *iconButton;
@property(nonatomic,strong)UILabel *nameLabel;

-(void)changeStatus;

@end
