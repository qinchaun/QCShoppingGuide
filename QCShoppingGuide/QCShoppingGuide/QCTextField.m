//
//  QCTextField.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCTextField.h"
#import <objc/runtime.h>

static NSString * const QCPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation QCTextField

+(void)initialize{
    
}

-(void)awakeFromNib{
    //设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
}

//当文本框聚焦的时候调用
-(BOOL)becomeFirstResponder{
    //修改占位文字颜色
    [self setValue:self.textColor forKeyPath:QCPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

//当文本框失去焦点的时候调用
-(BOOL)resignFirstResponder{
    [self setValue:[UIColor grayColor] forKeyPath:QCPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
