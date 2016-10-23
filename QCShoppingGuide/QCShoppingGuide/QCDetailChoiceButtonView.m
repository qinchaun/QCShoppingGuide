//
//  QCDetailChoiceButtonView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCDetailChoiceButtonView.h"

@interface QCDetailChoiceButtonView ()

@property (weak, nonatomic) IBOutlet UIButton *detailDescBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation QCDetailChoiceButtonView

-(void)awakeFromNib{
    [super awakeFromNib];
}

//点击图文详情
- (IBAction)detailDescBtnClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.lineView.mr_x = 0;
    }];
    if ([self.delegate respondsToSelector:@selector(descBtnClick)]) {
        [self.delegate descBtnClick];
    }
}


- (IBAction)detailCommentClick:(UIButton *)sender {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.lineView.mr_x = kScreenW/2;
    }];
    if ([self.delegate respondsToSelector:@selector(commentsBtnClick)]) {
        [self.delegate commentsBtnClick];
    }
}


@end
