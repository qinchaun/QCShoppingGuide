//
//  QCSearchSortView.h
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QCSearchSortView;

typedef enum : NSUInteger{
    QCSortTypeDefault,  //默认
    QCSortTypeHot,   //热度
    QCSortTypePriceAase,  //价格从低到高
    QCSortTypePriceAdese  //价格从高到低
}QCSortType;

@protocol QCSortDelegate <NSObject>

@optional
-(void)sortViewItemDidClick:(QCSearchSortView *)sortView sortType:(NSString *)type;

@end

@interface QCSearchSortView : UIView

@property(nonatomic,weak)id<QCSortDelegate> delegate;

-(void)show;

@end
