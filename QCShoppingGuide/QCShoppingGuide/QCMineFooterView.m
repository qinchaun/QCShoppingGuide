//
//  QCMineFooterView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCMineFooterView.h"
#import "QCNavigationController.h"
#import "QCLoginViewController.h"

@interface QCMineFooterView ()

@property(nonatomic,strong)UIButton *meBlankButton;
@property(nonatomic,strong)UILabel *messageLabel;

@end

@implementation QCMineFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self addSubview:self.meBlankButton];
    [self addSubview:self.messageLabel];
}

-(UIButton *)meBlankButton{
    if (!_meBlankButton) {
        _meBlankButton = [[UIButton alloc]init];
        _meBlankButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_meBlankButton setImage:[UIImage imageNamed:@"Me_blank_50x50_"] forState:UIControlStateNormal];
        [_meBlankButton.imageView sizeToFit];
        _meBlankButton.frame = CGRectMake((kScreenW-100)/2, 50, 100, 100);
    }
    return _meBlankButton;
}

-(UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]init];
        _messageLabel.text = @"登录以查看更多信息";
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:15.0];
        _messageLabel.textColor = kRGBColor(200, 200, 200);
        _messageLabel.frame = CGRectMake((kScreenW-200)/2, 130, 200, 40);
    }
    return _messageLabel;
}


@end
