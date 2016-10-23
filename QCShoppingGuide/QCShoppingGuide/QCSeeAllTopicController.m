//
//  QCSeeAllTopicController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCSeeAllTopicController.h"
#import "QCCollectionModel.h"
#import "QCSeeAllTopicCell.h"
#import "QCNetworkTool.h"
#import "QCCollectionDetailController.h"

@interface QCSeeAllTopicController ()
/**
 *  专题数组
 */
@property(nonatomic,strong)NSArray *collections;

/**
 *  下一页地址
 */
@property(nonatomic,copy)NSString *next_url;

@end

static NSString * seeAllTopicCellID = @"seeAllTopicCellID";

@implementation QCSeeAllTopicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI{
    
    self.title = @"全部专题";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCSeeAllTopicCell class]) bundle:nil]forCellReuseIdentifier:seeAllTopicCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 160;
    
    __weak typeof(self)weakSelf = self;
    
    //获取 分类界面 顶部 专题合集数据
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:@"http://api.dantangapp.com/v1/collections?limit=20&offset=0" parameters:nil success:^(id  _Nullable responseObject) {
        weakSelf.collections = [QCCollectionModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"collections"]];
        
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collections.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCSeeAllTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:seeAllTopicCellID];
    
    cell.collection = self.collections[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCCollectionDetailController *detailVc = [[QCCollectionDetailController alloc]init];
    QCCollectionModel *collection = self.collections[indexPath.row];
    detailVc.type = @"专题合集";
    detailVc.ID = collection.collectionID;
    detailVc.title = collection.title;
    [self.navigationController pushViewController:detailVc animated:YES];
}



@end
