//
//  QCVerticalButton.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCVerticalButton.h"

@implementation QCVerticalButton

//代码创建
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

//xib创建回调方法
-(void)awakeFromNib{
    [self setUp];
}

//初始化设置
-(void)setUp{
    //设置文字居中对齐
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//调整图片和文字的布局
-(void)layoutSubviews{
    [super layoutSubviews];
    //边距
    CGFloat margin = 10;
    //图片顶部对齐
    self.imageView.mr_x = margin;
    self.imageView.mr_y = margin;
    self.imageView.mr_width = self.mr_width - 2*margin;
    self.imageView.mr_height = self.imageView.mr_width;
    
    //文字标题居于图片下方
    self.titleLabel.mr_x = 0;
    self.titleLabel.mr_y = margin + self.imageView.mr_height;
    self.titleLabel.mr_width = self.mr_width;
    self.titleLabel.mr_height = self.mr_height - self.titleLabel.mr_y;
}


@end
