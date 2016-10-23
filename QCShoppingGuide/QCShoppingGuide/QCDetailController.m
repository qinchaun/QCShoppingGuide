//
//  QCDetailController.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCDetailController.h"

@interface QCDetailController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@end

@implementation QCDetailController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"攻略详情";
    [self.view addSubview:self.webView];
    //加载数据
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.content_url]]];
}

-(UIWebView *)webView{
    if (!_webView) {
        UIWebView *web = [[UIWebView alloc]init];
        web.frame = self.view.bounds;
        web.scalesPageToFit = YES;
        web.dataDetectorTypes = UIDataDetectorTypeAll;
        web.delegate = self;
        _webView = web;
    }
    return _webView;
}

#pragma mark -UIWebViewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"数据加载中...O__O"];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD showSuccessWithStatus:@"加载完成！O(∩_∩)O~~"];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"出错啦~(⊙o⊙)"];
}

@end
