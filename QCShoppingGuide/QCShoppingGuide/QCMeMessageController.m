//
//  QCMeMessageController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCMeMessageController.h"

@interface QCMeMessageController ()

@end

@implementation QCMeMessageController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"Me_message_20x20_"];
    imageView.frame = CGRectMake(0, 0, 30, 30);
    imageView.center = self.view.center;
    imageView.layer.borderColor = [UIColor grayColor].CGColor;
    imageView.layer.cornerRadius = 15;
    [self.view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, CGRectGetMaxY(imageView.frame)+10, 200, 40);
    label.text = @"您暂时还没有消息";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.mr_centerX = imageView.mr_centerX;
    [self.view addSubview:label];
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
