//
//  QCSearchSortView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/12.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCSearchSortView.h"

@interface QCSearchSortView ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,weak)UITableView *tableView;

@property(nonatomic,strong)NSArray *items;

//数据
@property(nonatomic,strong)NSArray *apis;

@end

static NSString * const sortViewCell = @"sortCell";

@implementation QCSearchSortView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [self setUp];
}

-(void)setUp{
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    UIImageView *bgIv = [[UIImageView alloc]init];
    bgIv.frame = CGRectMake(kScreenW - 145, 60, 140, 150);
    bgIv.image = [UIImage imageNamed:@"bg_menu_sort_140x46_"];
    bgIv.userInteractionEnabled = YES;
    [self addSubview:bgIv];
    
    UITableView *tv = [[UITableView alloc]init];
    tv.backgroundColor = [UIColor clearColor];
    tv.delegate = self;
    tv.dataSource = self;
    
    tv.frame = CGRectMake(0, 10, bgIv.mr_width, bgIv.mr_height-10);
    [tv registerClass:[UITableViewCell class] forCellReuseIdentifier:sortViewCell];
    [bgIv addSubview:tv];
    self.tableView = tv;
}

-(void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
}

-(void)dismiss{
    [self removeFromSuperview];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

-(NSArray *)items{
    if (!_items) {
        _items = @[@"默认",@"热度",@"价格从低到高",@"价格从高到低"];
    }
    return _items;
}

-(NSArray *)apis{
    if (!_apis) {
        _apis = @[@"",@"hot",@"price%3Aasc",@"price%3Adesc"];
    }
    return _apis;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *sortCell = [tableView dequeueReusableCellWithIdentifier:sortViewCell];
    sortCell.textLabel.text = self.items[indexPath.row];
    sortCell.selectionStyle = UITableViewCellAccessoryNone;
    sortCell.textLabel.textColor = [UIColor whiteColor];
    sortCell.backgroundColor = [UIColor clearColor];
    return sortCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(sortViewItemDidClick:sortType:)]) {
        [self.delegate sortViewItemDidClick:self sortType:self.apis[indexPath.row]];
    }
    
    //移除排序视图
    [self dismiss];
}

@end
