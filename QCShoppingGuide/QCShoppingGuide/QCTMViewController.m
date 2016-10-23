//
//  QCTMViewController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCTMViewController.h"

@interface QCTMViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation QCTMViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"商品详情";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"checkUserType_backward_9x15_"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
    //自动对页面进行缩放以适应屏幕
    self.webView.scalesPageToFit = YES;
    self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.product.purchase_url]]];
}

//返回事件
-(void)navigationBackClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
