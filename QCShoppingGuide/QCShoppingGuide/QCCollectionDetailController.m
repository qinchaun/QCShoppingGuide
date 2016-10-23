//
//  QCCollectionDetailController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCollectionDetailController.h"
#import "QCCollectionPost.h"
#import "QCDetailController.h"
#import "QCNetworkTool.h"
#import "QCItemCell.h"

@interface QCCollectionDetailController ()
/**
 *  collectionPosts
 */
@property(nonatomic,strong)NSArray *posts;

@end

static NSString * QCCollectionDetailCellID = @"LYCollectionTableViewCell";

@implementation QCCollectionDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

-(void)setupUI{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCItemCell class]) bundle:nil] forCellReuseIdentifier:QCCollectionDetailCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = QCHomeCellHeight;
    
    [self loadInfo];
}

-(void)loadInfo{
    
    __block NSString *url = nil;
    __weak typeof(self)weakSelf = self;
    
    if ([weakSelf.type isEqualToString:@"专题合集"]) {
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/collections/%ld/posts?gender=1&generation=1&limit=20&offset=0", self.ID];
    }else if([self.type isEqualToString:@"风格品类"]){
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/channels/%ld/items?limit=20&offset=0", self.ID];
    }
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:url parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *dict = nil;
        if ([weakSelf.type isEqualToString:@"专题合集"]) {
            dict = responseObject[@"data"][@"posts"];
        }else if ([weakSelf.type isEqualToString:@"风格品类"]){
            dict = responseObject[@"data"][@"items"];
        }
        weakSelf.posts = [QCCollectionPost mj_objectArrayWithKeyValuesArray:dict];
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError * _Nullable error) {
        
    }];
}



#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QCItemCell *cell = [tableView dequeueReusableCellWithIdentifier:QCCollectionDetailCellID];
    
    cell.selectionStyle = UITableViewCellSeparatorStyleNone; // 取消选中样式
    QCItemModel *item = self.posts[indexPath.row];
    cell.item = item;
    
    return cell;
}

#pragma mark - TableViewDelgate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QCDetailController *detailVc = [[QCDetailController alloc]init];
    detailVc.item = self.posts[indexPath.row];
    
    [self.navigationController pushViewController:detailVc animated:YES];
}

-(NSArray *)posts{
    if (!_posts) {
        _posts = [NSArray array];
    }
    return _posts;
}


@end
