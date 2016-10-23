//
//  QCShareBtnsView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCShareBtnsView.h"
#import "QCVerticalButton.h"

@interface QCShareBtnsView ()
/**
 *  图片数组
 */
@property(nonatomic,strong)NSArray *images;
/**
 *  标题数组
 */
@property(nonatomic,strong)NSArray *titles;


@end

@implementation QCShareBtnsView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

-(void)setupUI{
    [self layoutIfNeeded];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger maxCols = 3;
    CGFloat width = 70;
    CGFloat height = width + 30;
    CGFloat margin = (self.mr_width - (maxCols * width))/(maxCols + 1);
    
    for (NSInteger index = 0; index<self.images.count; index++) {
        CGFloat x = margin + (margin + width)*(index %maxCols);
        CGFloat y = (index / maxCols) * height;
        QCVerticalButton *btn = [[QCVerticalButton alloc]init];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.tag = index;
        btn.frame = CGRectMake(x, y, width, height);
        [btn setImage:[UIImage imageNamed:self.images[index]] forState:UIControlStateNormal];
        [btn setTitle:self.titles[index] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.titleLabel.textColor = [UIColor blackColor];
        [btn addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

/**
 *  分享按钮被点击
 */
-(void)shareButtonClick:(QCVerticalButton *)btn{
    if ([self.delegate respondsToSelector:@selector(shareBtnClickWithTag:)]) {
        [self.delegate shareBtnClickWithTag:btn.tag];
    }
}

-(NSArray *)images{
    if (!_images) {
        _images = @[@"Share_WeChatTimelineIcon_70x70_", @"Share_WeChatSessionIcon_70x70_", @"Share_WeiboIcon_70x70_", @"Share_QzoneIcon_70x70_", @"Share_QQIcon_70x70_", @"Share_CopyLinkIcon_70x70_"];
    }
    return _images;
}

-(NSArray *)titles{
    if (!_titles) {
         _titles = @[@"微信朋友圈", @"微信好友", @"微博", @"QQ 空间", @"QQ 好友", @"复制链接"];
    }
    return _titles;
}


@end
