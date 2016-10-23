//
//  QCSearchController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCSearchController.h"
#import "QCProductDetailController.h"
#import "QCNetworkTool.h"
#import "QCProductModel.h"
#import "QCProductCell.h"
#import "QCSearchSortView.h"

static NSString * const searchCell = @"searchCell";

@interface QCSearchController ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,QCSortDelegate>
/**
 *  搜索条
 */
@property(nonatomic,strong)UISearchBar *searchBar;
/**
 *  collectionView
 */
@property(nonatomic,strong)UICollectionView *collectionView;
/**
 *  products数组
 */
@property(nonatomic,strong)NSMutableArray *productsArr;
/**
 *  next_url
 */
@property(nonatomic,copy)NSString *next_url;

@end

@implementation QCSearchController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchBar becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

-(UISearchBar *)searchBar{
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.placeholder = @"搜索商品、专题";
    }
    return _searchBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setupNav];
}

//设置导航栏
-(void)setupNav{
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.delegate = self;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:[[UIView alloc]init]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
}

-(void)navigationBackClick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([QCProductCell class]) bundle:nil] forCellWithReuseIdentifier:searchCell];
    self.collectionView.backgroundColor = self.view.backgroundColor;
    self.collectionView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        //加载更多
        if (self.next_url != nil && [self.next_url isEqual:[NSNull null]]) {
            [self loadProductInfoWithURL:self.next_url andType:QCLoadTypeMore];
        }
        
    }];
    [self.view addSubview:self.collectionView];
}

-(void)loadProductInfoWithURL:(NSString *)urlString andType:(QCLoadType)type{
    __weak typeof(self)weakSelf = self;
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:urlString parameters:nil success:^(id  _Nullable responseObject) {
        
        NSArray *dicts = responseObject[@"data"][@"items"];
        NSMutableArray *products = [QCProductModel mj_objectArrayWithKeyValuesArray:dicts];
        
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];
        switch (type) {
            case QCLoadTypeNew:
                weakSelf.productsArr = products;
                break;
            case QCLoadTypeMore:
                [weakSelf.productsArr addObjectsFromArray:products];
                break;
                
            default:
                break;
        }
        //刷新数据
        [weakSelf.collectionView reloadData];
        [weakSelf.collectionView.mj_footer endRefreshing];
    } failure:^(NSError * _Nullable error) {
        [weakSelf.collectionView.mj_footer endRefreshing];
    }];
}

//加载更新
-(void)loadNewInfoWithKeyword:(NSString *)word sortType:(NSString *)type{
    //拼接请求参数
    NSString *urlStr = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/search/item?keyword=%@&limit=20&offset=0&sort=%@", word, type];
     //请求搜索结果
    [self loadProductInfoWithURL:urlStr andType:QCLoadTypeNew];
}

-(void)sortButtonClick{
    QCSearchSortView *sortView = [[QCSearchSortView alloc]init];
    sortView.delegate = self;
    [sortView show];
}

#pragma mark - <UISearchBarDelegate>
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    //设置collectionView
    [self setupCollectionView];
    
    return YES;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    //关闭第一响应者
    [self.searchBar resignFirstResponder];
    
    if ([searchBar.text length]>0) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"checkUserType_backward_9x15_"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBackClick)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_sort_21x21_"] style:UIBarButtonItemStylePlain target:self action:@selector(sortButtonClick)];
        
        //根据搜索条件进行搜索
        NSString *keyword = searchBar.text;
        [self loadNewInfoWithKeyword:keyword sortType:@""];
    }else{  //无输入
        return;
    }
}


-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionView *cv = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        cv.contentInset = UIEdgeInsetsMake(QCNavBarHeight, 0, 0, 0);
        cv.scrollIndicatorInsets = cv.contentInset;
        cv.delegate = self;
        cv.dataSource = self;
        _collectionView = cv;
    }
    return _collectionView;
}

-(NSMutableArray *)productsArr{
    if (!_productsArr) {
        _productsArr = [NSMutableArray array];
    }
    return _productsArr;
}

#pragma mark - <UICollectionViewDataSource>
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.productsArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCProductCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:searchCell forIndexPath:indexPath];
    QCProductModel *product = self.productsArr[indexPath.row];
    cell.product = product;
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    QCProductDetailController *detailVc = [[QCProductDetailController alloc]init];
    QCProductModel *product = self.productsArr[indexPath.row];
    detailVc.product = product;
    [self.navigationController pushViewController:detailVc animated:YES];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenW - 20) / 2;
    CGFloat height = 245;
    
    return CGSizeMake(width, height);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - <LYSearchSortView>
-(void)sortViewItemDidClick:(QCSearchSortView *)sortView sortType:(NSString *)type{
    //按照输入的关键字进行搜索
    [self loadNewInfoWithKeyword:self.searchBar.text sortType:type];
}


@end
