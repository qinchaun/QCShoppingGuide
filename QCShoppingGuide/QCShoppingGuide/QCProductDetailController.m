//
//  QCProductDetailController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCProductDetailController.h"
#import "QCProductDetailToolBar.h"
#import "QCNavigationController.h"
#import "QCDetailScrollView.h"
#import "QCActionSheetView.h"
#import "QCTMViewController.h"
#import "UMSocial.h"


@interface QCProductDetailController ()<QCProductDetailToolBarDelegate,UIScrollViewDelegate,UMSocialUIDelegate>

@property(nonatomic,strong)QCDetailScrollView *scrollView;
@property(nonatomic,strong)QCProductDetailToolBar *toolBar;

@end

@implementation QCProductDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];

}

-(void)setProduct:(QCProductModel *)product{
    _product = product;
    
    self.scrollView.product = product;
}

//设置导航栏和底部工具栏
-(void)setupUI{
    self.title = @"商品详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"GiftShare_icon_18x22_"] style:UIBarButtonItemStylePlain target:self action:@selector(shareItemClick)];
    //添加详情视图
    [self.view addSubview:self.scrollView];
    
    //详情页面底部工具条
    self.toolBar.frame = CGRectMake(0, kScreenH-45, kScreenW, 45);
    [self.view addSubview:self.toolBar];
}

//点击分享
-(void)shareItemClick{
    //弹出分享框
    //[QCActionSheetView show];
    
    [UMSocialData defaultData].extConfig.title = @"分享的title";
    [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"57e0f5f767e58e6bb0003a82"
                                      shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
                                     shareImage:[UIImage imageNamed:@"icon"]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToEmail,UMShareToDouban,UMShareToRenren,UMShareToFacebook]
                                       delegate:self];
}



-(QCDetailScrollView *)scrollView{
    if (!_scrollView) {
        QCDetailScrollView *sc = [[QCDetailScrollView alloc] init];
        sc.frame = CGRectMake(0, 0, kScreenW, kScreenH - 44);
        sc.contentSize = CGSizeMake(kScreenW, kScreenH - 64 - 45 + kMargin + 520);
        sc.delegate = self;
        _scrollView = sc;
    }
    return _scrollView;
}

-(QCProductDetailToolBar *)toolBar{
    if (!_toolBar) {
        _toolBar = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([QCProductDetailToolBar class]) owner:nil options:nil]lastObject];
        _toolBar.delegate = self;
    }
    return _toolBar;
}

#pragma mark - <QCProductDetailToolBarDelegate>
//点击去天猫购买
-(void)toolBarDidClickedTMALLButton{
    QCTMViewController *TMVc = [[QCTMViewController alloc]init];
    TMVc.product = self.product;
    QCNavigationController *nav = [[QCNavigationController alloc]initWithRootViewController:TMVc];
    [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //当向下滑动超过一定的值 返回固定contentOffset.y值
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY >= 465) {
        offsetY = 465.0;
        scrollView.contentOffset = CGPointMake(0, offsetY);
    }
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
