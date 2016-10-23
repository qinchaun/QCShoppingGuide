//
//  QCThemeCollectionController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCThemeCollectionController.h"
#import "QCNetworkTool.h"
#import "QCCollectionModel.h"
#import "QCCategoryCollectionCell.h"
#import "QCSeeAllTopicController.h"
#import "QCCollectionDetailController.h"

@interface QCThemeCollectionController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  collections
 */
@property(nonatomic,strong)NSArray *collections;
/**
 *  collectionView
 */
@property(nonatomic,weak)UICollectionView *collectionView;

@end

static NSString * const CollectionCellID = @"CollectionCellID";

@implementation QCThemeCollectionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:@"http://api.dantangapp.com/v1/collections?limit=20&offset=0" parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dictArr = responseObject[@"data"][@"collections"];
        self.collections = [QCCollectionModel mj_objectArrayWithKeyValuesArray:dictArr];
        [self.collectionView reloadData];
        
    } failure:nil];
    
    [self setupUI];
}

-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc]init];
    label.mr_x = 10;
    label.mr_y = 5;
    label.mr_size = CGSizeMake(100, 35);
    label.text = @"专题合集";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"查看全部>" forState:UIControlStateNormal];
    [btn sizeToFit];
    btn.mr_x = self.view.frame.size.width - btn.mr_width - 5;
    btn.mr_centerY = label.mr_centerY;
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showAll:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 40, kScreenW, 100) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QCCategoryCollectionCell class]) bundle:nil] forCellWithReuseIdentifier:CollectionCellID];
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
}

-(void)showAll:(UIButton *)btn {
    QCSeeAllTopicController *allVc = [[QCSeeAllTopicController alloc]init];
    
    [self.navigationController pushViewController:allVc animated:YES];
}

#pragma mark - <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QCCollectionDetailController *detailVc = [[QCCollectionDetailController alloc]init];
    QCCollectionModel *collection = self.collections[indexPath.row];
    detailVc.type = @"专题合集";
    detailVc.ID = collection.collectionID;
    detailVc.title = collection.title;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.collections.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionCellID forIndexPath:indexPath];
    cell.collection = self.collections[indexPath.row];
    return cell;
}

#pragma mark - <UICollectionViewFlowLayoutDelegate>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(150, 80);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}

-(NSArray *)collections{
    if (!_collections) {
        _collections = [NSArray array];
    }
    return _collections;
}


@end
