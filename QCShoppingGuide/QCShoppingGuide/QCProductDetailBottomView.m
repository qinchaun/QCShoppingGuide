//
//  QCProductDetailBottomView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCProductDetailBottomView.h"
#import "QCNetworkTool.h"
#import "QCDetailChoiceButtonView.h"
#import "QCCommentModel.h"
#import "QCCommentCell.h"

@interface QCProductDetailBottomView ()<QCDetailChoiceDelegate,UIWebViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)QCDetailChoiceButtonView *choiceView;
//展示图文详情
@property(nonatomic,strong)UIWebView *webView;
//展示评论
@property(nonatomic,strong)UITableView *commentTableView;

@property(nonatomic,strong)NSArray *comments;

@end

static NSString * const commentCellID = @"commentCellID";

@implementation QCProductDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.choiceView];
    [self addSubview:self.webView];
    [self addSubview:self.commentTableView];
}

-(void)setProduct:(QCProductModel *)product{
    _product = product;
    
    __weak typeof(self) weakSelf = self;
    
    //请求图文详情数据
    NSString *detailURL = [NSString stringWithFormat:@"http://api.dantangapp.com/v2/items/%ld", product.productID];
    
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:detailURL parameters:nil success:^(id  _Nullable responseObject) {
        NSString *commentCount = responseObject[@"data"][@"comments_count"];
        [weakSelf.choiceView.commentBtn setTitle:[NSString stringWithFormat:@"评论(%@)",commentCount] forState:UIControlStateNormal];
        NSString *detail_html = responseObject[@"data"][@"detail_html"];
        [weakSelf.webView loadHTMLString:detail_html baseURL:nil];
    } failure:^(NSError * _Nullable error) {
        
    }];
    
    //请求商品评论数据
    NSString *commentsURL = [NSString stringWithFormat:@"http://api.dantangapp.com/v2/items/%ld/comments", product.productID];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"limit"] = @(20);
    params[@"offset"] = @(0);
    [[QCNetworkTool sharedNetworkTool]loadDataInfo:commentsURL parameters:nil success:^(id  _Nullable responseObject) {
        NSArray *dicts = responseObject[@"data"][@"comments"];
        NSMutableArray *comments = [NSMutableArray array];
        for (NSDictionary *dict in dicts) {
            QCCommentModel *comment = [QCCommentModel mj_objectWithKeyValues:dict];
            [comments addObject:comment];
        }
        weakSelf.comments = comments;
        [weakSelf.commentTableView reloadData];
    } failure:^(NSError * _Nullable error) {
        
    }];
}

-(QCDetailChoiceButtonView *)choiceView{
    if (!_choiceView) {
        _choiceView = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([QCDetailChoiceButtonView class]) owner:nil options:nil]lastObject];
        _choiceView.delegate = self;
    }
    return _choiceView;
}

-(UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc]init];
        //自动对页面进行缩放以适应屏幕
        _webView.scalesPageToFit = YES;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.delegate = self;
    }
    return _webView;
}

-(UITableView *)commentTableView{
    if (!_commentTableView) {
        _commentTableView = [[UITableView alloc]init];
        _commentTableView.hidden = YES;
        [_commentTableView registerNib:[UINib nibWithNibName:NSStringFromClass([QCCommentCell class]) bundle:nil] forCellReuseIdentifier:commentCellID];
        _commentTableView.dataSource = self;
        _commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _commentTableView.rowHeight = 64;
    }
    return _commentTableView;
}

-(NSArray *)comments{
    if (!_comments) {
        _comments = [NSArray array];
    }
    return _comments;
}

#pragma mark - <LYDetailChoiceButtonViewDelegate>
-(void)descBtnClick{
    self.webView.hidden = NO;
    self.commentTableView.hidden = YES;
}

-(void)commentsBtnClick{
    self.webView.hidden = YES;
    self.commentTableView.hidden = NO;
}

#pragma mark - <UIWebViewDelegate>
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.choiceView.frame = CGRectMake(0, 0, kScreenW, 45);
    self.webView.frame = CGRectMake(0, CGRectGetMaxY(self.choiceView.frame), kScreenW, self.mr_height-45);
    self.commentTableView.frame = self.webView.frame;
}

#pragma mark - <UITableViewDataSource>
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QCCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellID];
    cell.comment = self.comments[indexPath.row];
    return cell;
}


@end
