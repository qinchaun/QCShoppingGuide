//
//  QCChannelController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCChannelController.h"
#import "QCDetailController.h"
#import "QCNetworkTool.h"
#import "QCItemModel.h"
#import "QCItemCell.h"

static NSString * const HomeCell = @"HomeCell";

@interface QCChannelController ()<UITableViewDelegate,UITableViewDataSource>
/**
 *  下一页的请求地址
 */
@property(nonatomic,copy)NSString *next_url;

/**
 *  item 数组
 */
@property(nonatomic,strong)NSMutableArray *items;
@end

@implementation QCChannelController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTable];
    
    [self.tableView.mj_header beginRefreshing];
}

/**
 *  初始化表格
 */
-(void)setupTable{
    self.tableView.contentInset = UIEdgeInsetsMake(QCNavBarHeight + QCTitlesViewH, 0, self.tabBarController.tabBar.mr_height, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //给表格视图添加下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        NSString *urlString = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?gender=1&generation=1&limit=20&offset=0", self.channesID];
        [self loadItemInfo:urlString withType:0];
    }];
    //给表格视图添加加载更多
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (self.next_url != nil && ![self.next_url isEqual:[NSNull null]]) {
            [self loadItemInfo:self.next_url withType:1];
        }else{
            NSLog(@"null");
        }
    }];
    
    //注册单元格
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCItemCell class]) bundle:nil] forCellReuseIdentifier:HomeCell];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = QCHomeCellHeight;
}

/**
 *  请求数据
 */
-(void)loadItemInfo:(NSString *)urlString withType:(NSInteger)type{
    __weak typeof(self) weakSelf = self;
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:urlString parameters:nil success:^(id responseObject) {
        NSArray *dictArr = responseObject[@"data"][@"items"];
        NSMutableArray *items = [QCItemModel mj_objectArrayWithKeyValuesArray:dictArr];
        if (type == 0) { //下拉刷新
            weakSelf.items = items;
        }else{
            [weakSelf.items addObjectsFromArray:items];
        }
        
        weakSelf.next_url = responseObject[@"data"][@"paging"][@"next_url"];
        
        //刷新表格
        [weakSelf.tableView reloadData];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeCell];
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone; //取消选中样式
    QCItemModel *item = self.items[indexPath.row];
    cell.item = item;  //设置数据源
    
    return cell;
}



//单元格点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCDetailController *detailVc = [[QCDetailController alloc]init];
    detailVc.item = self.items[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}



@end
