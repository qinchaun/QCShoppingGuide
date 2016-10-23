//
//  QCDetailChoiceButtonView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QCDetailChoiceDelegate <NSObject>

-(void)descBtnClick;

-(void)commentsBtnClick;

@end

@interface QCDetailChoiceButtonView : UIView

@property (weak, nonatomic) IBOutlet UIButton *commentBtn;

@property(nonatomic,weak)id<QCDetailChoiceDelegate> delegate;

@end
