//
//  QCDanPingController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/9/27.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCDanPingController.h"
#import "QCProductDetailController.h"
#import "QCNetworkTool.h"
#import "QCProductModel.h"
#import "QCProductCell.h"

static NSString * const collectionCellID = @"collectionCell";

@interface QCDanPingController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,weak)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *products;
@property(nonatomic,copy)NSString *next_url;

@end

@implementation QCDanPingController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    //设置collectionView
    [self setupCollectionView];
    
    //请求数据
    [self.collectionView.mj_header beginRefreshing];
}

-(void)setupCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QCProductCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadProductIntroWithURL:@"http://api.dantangapp.com/v2/items?generation=2&gender=1&limit=20&offset=0" AndType:QCLoadTypeNew];
    }];
    self.collectionView.mj_header.automaticallyChangeAlpha = YES;
    
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        if (self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
            [self loadProductIntroWithURL:self.next_url AndType:QCLoadTypeMore];
        }
    }];
    [self.view addSubview:self.collectionView];
}

-(void)loadProductIntroWithURL:(NSString *)urlString AndType:(QCLoadType)type{
    __weak typeof(self)weakSelf = self;
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:urlString parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *dicts = responseObject[@"data"][@"items"];
        NSMutableArray *pros = [NSMutableArray array];
        for (NSDictionary *dic in dicts) {
            QCProductModel *product = [QCProductModel mj_objectWithKeyValues:dic[@"data"]];
            [pros addObject:product];
        }
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];
        switch (type) {
            case QCLoadTypeNew:
                weakSelf.products = pros;
                break;
            case QCLoadTypeMore:
                [weakSelf.products addObjectsFromArray:pros];
                break;
                
            default:
                break;
        }
        
        //刷新列表数据
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nullable error) {
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        cv.delegate = self;
        cv.dataSource = self;
        _collectionView = cv;
    }
    return _collectionView;
}

-(NSMutableArray *)products{
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}

#pragma mark - <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.products.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    QCProductModel *product = self.products[indexPath.row];
    cell.product = product;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QCProductDetailController *vc = [[QCProductDetailController alloc]init];
    vc.product = self.products[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    CGFloat width = (kScreenW - 20)/2;
    CGFloat height = 245;
    
    return CGSizeMake(width, height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
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
