//
//  QCMineChoiceBar.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCMineChoiceBar.h"

@interface QCMineChoiceBar ()

@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
@property(nonatomic,strong)UIView *indicatorView;

@end

@implementation QCMineChoiceBar

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    self.leftBtn.frame = CGRectMake(0, 0, kScreenW/2, 44);
    self.rightBtn.frame = CGRectMake(kScreenW/2, 0, kScreenW/2, 44);
    self.indicatorView.frame = CGRectMake(0, CGRectGetMaxY(self.leftBtn.frame)-2, kScreenW/2, 2);
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.indicatorView];
}

-(UIButton *)leftBtn{
    if (!_leftBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"收藏的商品" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = kRGBColor(230, 230, 230).CGColor;
        btn.layer.borderWidth = 1;
        btn.selected = YES;
        _leftBtn = btn;
    }
    return _leftBtn;
}

-(UIButton *)rightBtn{
    if (!_rightBtn) {
        UIButton *btn = [[UIButton alloc]init];
        [btn setTitle:@"喜欢的专题" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7] forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.borderColor = kRGBColor(230, 230, 230).CGColor;
        btn.layer.borderWidth = 1;
        _rightBtn = btn;
    }
    return _rightBtn;
}

-(UIView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc]init];
        _indicatorView.backgroundColor = kRGBColor(245, 80, 83);
    }
    return _indicatorView;
}

//点击按钮
-(void)buttonClick:(UIButton *)btn{
    btn.selected = !btn.selected;
    NSInteger type = 0;
    if (btn == self.leftBtn) {
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.mr_x = 0;
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.mr_x = kScreenW/2;
        }];
        type = 1;
    }
    if ([self.delegate respondsToSelector:@selector(choiceBarClick:)]) {
        [self.delegate choiceBarClick:type];
    }
}



@end
