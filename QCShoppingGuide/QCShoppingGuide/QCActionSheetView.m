//
//  QCActionSheetView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCActionSheetView.h"
#import "QCShareBtnsView.h"
#import "UMSocial.h"

@interface QCActionSheetView ()<QCShareBtnDelegate,UMSocialUIDelegate>
/**
 *  顶部
 */
@property(nonatomic,strong)UIView *bgView;
/**
 *  上面titleLabel
 */
@property(nonatomic,strong)UILabel *titleLabel;
/**
 *  中间分享
 */
@property(nonatomic,strong)QCShareBtnsView *shareView;
/**
 *  底部取消
 */
@property(nonatomic,strong)UIButton *cancelBtn;
/**
 *  view
 */
@property(nonatomic,strong)UIView *backView;

@end

@implementation QCActionSheetView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

//初始化布局
-(void)setupUI{
    //添加子控件
    UIView *backView = [[UIView alloc]init];
    backView.frame = CGRectMake(10, kScreenH, kScreenW - 20, 330);
    self.backView = backView;
    [self addSubview:backView];
    [backView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.shareView];
    [backView addSubview:self.cancelBtn];
}

+(void)show{
    QCActionSheetView *sheetView = [[QCActionSheetView alloc]init];
    sheetView.frame = [UIScreen mainScreen].bounds;
    sheetView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:sheetView];
    
    [UIView animateWithDuration:kAnimationTime animations:^{
        sheetView.backView.mr_y = kScreenH - 330;
    } completion:nil];
    
}

-(void)cancelBtnClicked{
    [UIView animateWithDuration:kAnimationTime animations:^{
        self.backView.mr_y = kScreenH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc]init];
        _bgView.frame = CGRectMake(0, 0, kScreenW-20, 250);
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = kQCCornerRadius;
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.frame = CGRectMake(0, 0, self.bgView.mr_width, 50);
        label.text = @"分享到";
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        label.textAlignment = NSTextAlignmentCenter;
        _titleLabel = label;
    }
    return _titleLabel;
}

-(QCShareBtnsView *)shareView{
    if (!_shareView) {
        QCShareBtnsView *btnView = [[QCShareBtnsView alloc]init];
        btnView.delegate = self;
        btnView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), self.bgView.mr_width, 200);
        _shareView = btnView;
    }
    return _shareView;
}

-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 265, self.bgView.mr_width, 45);
        btn.titleLabel.font = [UIFont systemFontOfSize:18];
        [btn setTitleColor:kRGBColor(74, 140, 240) forState:UIControlStateNormal];
        [btn setTitle:@"取  消" forState:UIControlStateNormal];
        btn.backgroundColor = [UIColor whiteColor];
        [btn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = kQCCornerRadius;
        btn.layer.masksToBounds = YES;
        _cancelBtn = btn;
    }
    return _cancelBtn;
}

#pragma mark <QCShareBtnDelegate>

-(void)shareBtnClickWithTag:(NSInteger)index{
    //[self cancelBtnClicked];
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57e0f5f767e58e6bb0003a82"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToDouban]
                                       delegate:self];

    
}

@end
