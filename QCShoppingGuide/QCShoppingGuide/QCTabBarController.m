
//
//  QCTabBarController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/9/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCTabBarController.h"
#import "QCNavigationController.h"
#import "QCDanTangController.h"
#import "QCDanPingController.h"
#import "QCCategoryController.h"
#import "QCMeController.h"

@interface QCTabBarController ()<UITabBarDelegate>

@end

@implementation QCTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加子控制器
    [self addChildViewController:[[QCDanTangController alloc]init] imageName:@"TabBar_home_23x23_" selectedImage:@"TabBar_home_23x23_selected" title:@"首页"];
    
    [self addChildViewController:[[QCDanPingController alloc] init] imageName:@"TabBar_gift_23x23_" selectedImage:@"TabBar_gift_23x23_selected" title:@"单品"];
    
    [self addChildViewController:[[QCCategoryController alloc] init] imageName:@"TabBar_category_23x23_" selectedImage:@"TabBar_category_23x23_selected" title:@"分类"];
    
    [self addChildViewController:[[QCMeController alloc] init] imageName:@"TabBar_me_boy_23x23_" selectedImage:@"TabBar_me_boy_23x23_selected" title:@"个人"];
}

//设置TabBarItem主题
+(void)initialize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = kGlobalBg;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}


/**
 *	@brief	添加子控制器
 *
 *	@param 	childVC 	子控制期器
 *	@param 	imageName 	默认图片
 *	@param 	selectedName 	选中图片
 *	@param 	title 	标题
 */
-(void)addChildViewController:(UIViewController *)childVC imageName:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    //设置文字和图片
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage mr_imageOriginalWithName:image];
    childVC.tabBarItem.selectedImage = [UIImage mr_imageOriginalWithName:selectedImage];
    
    //包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    QCNavigationController *nav = [[QCNavigationController alloc]initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
