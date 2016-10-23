//
//  QCProductDetailToolBar.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCProductDetailToolBar.h"
#import "QCNavigationController.h"
#import "QCLoginViewController.h"
#import "QCUser.h"

@interface QCProductDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UIButton *goTMBtn;

@end

@implementation QCProductDetailToolBar

-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.likeBtn.layer.borderColor = kGlobalBg.CGColor;
    self.likeBtn.layer.borderWidth = 1;
    self.likeBtn.layer.cornerRadius = 15;
    [self.likeBtn setImage:[UIImage imageNamed:@"content-details_like_16x16_"] forState:UIControlStateNormal];
    [self.likeBtn setImage:[UIImage imageNamed:@"content-details_like_selected_16x16_"] forState:UIControlStateSelected];
    
    self.goTMBtn.layer.cornerRadius = 15;
}

- (IBAction)likeBtnClick:(UIButton *)sender {
    //判断是否登录
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"isLogin"]) {
        sender.selected = !sender.selected;
        //想服务器发送点赞请求
        
        
    }else{
        QCLoginViewController *loginVC = [[QCLoginViewController alloc]init];
        loginVC.block = ^(QCUser *user){
            //保存登录状态
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"isLogin"];
            [[NSUserDefaults standardUserDefaults]setObject:user.avatar_url forKey:@"avatar_url"];
            [[NSUserDefaults standardUserDefaults]setObject:user.nickname forKey:@"nickname"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            //发送通知
            [[NSNotificationCenter defaultCenter]postNotificationName:@"QCLoginNotification" object:nil];
        };
        QCNavigationController *loginNav = [[QCNavigationController alloc]initWithRootViewController:loginVC];
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
    }
        
}


- (IBAction)goTMButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(toolBarDidClickedTMALLButton)]) {
        [self.delegate toolBarDidClickedTMALLButton];
    }
}


@end
