//
//  UIImage+MRExtension.h
//  QCShoppingGuide
//
//  Created by tarena on 16/9/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MRExtension)
/**
 *	@brief	生成可拉伸的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	可拉伸的图片
 */
+ (instancetype)mr_resizingImage:(NSString *)imageName;

/**
 *	@brief	生成一张禁止用系统渲染的图片
 *
 *	@param 	imageName 	原始图片名
 *
 *	@return	禁用系统渲染的图片
 */
+ (instancetype)mr_imageOriginalWithName:(NSString *)imageName;

/**
 *	@brief	带边框(optional)圆形图片裁剪
 *
 *	@param 	clipImageName 	待裁剪图片名
 *	@param 	borderWidth 	圆环宽度
 *	@param 	borderColor 	圆环颜色
 *
 *	@return	裁剪之后的图片
 */
+ (instancetype)mr_imageWithClipImageNamed:(NSString *)clipImageName borderWidth:(CGFloat)borderWidth borderCorlor:(UIColor *)borderColor;


@end
