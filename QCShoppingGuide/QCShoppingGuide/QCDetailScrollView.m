//
//  QCDetailScrollView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCDetailScrollView.h"
#import "QCProductDetailTopView.h"
#import "QCProductDetailBottomView.h"

@interface QCDetailScrollView ()

@property(nonatomic,strong)QCProductDetailTopView *topView;
@property(nonatomic,strong)QCProductDetailBottomView *bottomView;

@end

@implementation QCDetailScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    
    [self addSubview:self.topView];
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame)+10,kScreenW, kScreenH-64-45);
    [self addSubview:self.bottomView];
    self.backgroundColor = kBgColor;
}

-(void)setProduct:(QCProductModel *)product{
    _product = product;
    
    self.topView.product = product;
    self.bottomView.product = product;
}

-(QCProductDetailTopView *)topView{
    if (!_topView) {
        _topView = [[QCProductDetailTopView alloc]init];
        _topView.frame = CGRectMake(0, 0, kScreenW, 520);
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

-(QCProductDetailBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[QCProductDetailBottomView alloc]init];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}

@end
