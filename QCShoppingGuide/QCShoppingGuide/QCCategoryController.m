//
//  QCCategoryController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/9/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCategoryController.h"
#import "QCSearchController.h"
#import "QCThemeCollectionController.h"
#import "QCCollectionDetailController.h"
#import "QCCategoryBottomView.h"

@interface QCCategoryController ()<QCCategoryGroupDelegate>

@end

@implementation QCCategoryController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    
    [self setupUI];
}

-(void)setupUI{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Feed_SearchBtn_18x18_"] style:UIBarButtonItemStylePlain target:self action:@selector(categorySearchClick)];
    
    //设置下面的视图的具体内容
    [self setupScrollView];
}

-(void)setupScrollView{
    UIScrollView *sc = [[UIScrollView alloc]init];
    sc.frame = self.view.bounds;
    [self.view addSubview:sc];
    
    QCThemeCollectionController *themeVc = [[QCThemeCollectionController alloc]init];
    [self addChildViewController:themeVc];
    themeVc.view.frame = CGRectMake(0, 0, kScreenW, 140);
    [sc addSubview:themeVc.view];
    
    QCCategoryBottomView *bottomView = [[QCCategoryBottomView alloc]init];
    bottomView.frame = CGRectMake(0, CGRectGetMaxY(themeVc.view.frame) , kScreenW, kScreenH - 150);
    bottomView.groupDelegate = self;
    
    [sc addSubview:bottomView];
}

-(void)categorySearchClick{
    QCSearchController *searchVc = [[QCSearchController alloc]init];
    [self.navigationController pushViewController:searchVc animated:YES];
}

#pragma mark - <QCCategoryGroupDelegate>
-(void)groupButtonItemClick:(UIButton *)btn{
    QCCollectionDetailController *detailVc = [[QCCollectionDetailController alloc]init];
    detailVc.type = @"风格品类";
    detailVc.ID = btn.tag;
    detailVc.title = btn.titleLabel.text;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
