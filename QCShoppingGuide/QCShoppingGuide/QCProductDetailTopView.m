//
//  QCProductDetailTopView.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCProductDetailTopView.h"
#import "QCProductModel.h"
#import "QCDetailLayout.h"
#import "QCDetailCollectinViewCell.h"
#import <UIImageView+WebCache.h>

@interface QCProductDetailTopView ()<UICollectionViewDelegate,UICollectionViewDataSource>

//imageURLs,图片地址数组
@property(nonatomic,strong)NSArray *imageURLs;
//collectionView
@property(nonatomic,strong)UICollectionView *collectionView;
//pageControl
@property(nonatomic,strong)UIPageControl *pageControl;
//标题
@property(nonatomic,strong)UILabel *titleLabel;
//价格
@property(nonatomic,strong)UILabel *priceLabel;
//，描述
@property(nonatomic,strong)UILabel *describeLabel;

@end

static NSString * const detailCollectionViewCellID = @"detailCollectionViewCellID";

@implementation QCProductDetailTopView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


-(void)setupUI{
    [self addSubview:self.collectionView];
    
    self.pageControl.frame = CGRectMake(0, self.collectionView.mr_height-40, 100, 40);
    self.pageControl.contentMode = UIViewContentModeCenter;
    [self addSubview:self.pageControl];
    self.titleLabel.frame = CGRectMake(5, CGRectGetMaxY(self.collectionView.frame)+5, kScreenW - 10, 25);
    [self addSubview:self.titleLabel];
    self.priceLabel.frame = CGRectMake(5, CGRectGetMaxY(self.titleLabel.frame)+5, kScreenW - 10, 20);
    [self addSubview:self.priceLabel];
    self.describeLabel.frame = CGRectMake(5, CGRectGetMaxY(self.priceLabel.frame)+5, kScreenW - 10, 80);
    [self addSubview:self.describeLabel];
}

-(void)setProduct:(QCProductModel *)product{
    _product = product;
    
    self.imageURLs = product.image_urls;
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = self.imageURLs.count;
    self.pageControl.mr_centerX = self.collectionView.mr_centerX;
    self.titleLabel.text = product.name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",product.price];
    self.describeLabel.text = product.describe;
}

-(NSArray *)imageURLs{
    if (!_imageURLs) {
        NSArray *array = [NSArray array];
        _imageURLs = array;
    }
    return _imageURLs;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        QCDetailLayout *layout = [[QCDetailLayout alloc]init];
        UICollectionView *vc = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, 375) collectionViewLayout:layout];
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([QCDetailCollectinViewCell class]) bundle:nil];
        [vc registerNib:nib forCellWithReuseIdentifier:detailCollectionViewCellID];
        vc.showsHorizontalScrollIndicator = NO;
        vc.delegate = self;
        vc.dataSource = self;
        vc.backgroundColor = [UIColor whiteColor];
        _collectionView = vc;
    }
    return _collectionView;
}

-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]init];
        _priceLabel.numberOfLines = 0;
        _priceLabel.textColor = kGlobalBg;
        _priceLabel.font = [UIFont systemFontOfSize:16];
    }
    return _priceLabel;
}

-(UILabel *)describeLabel{
    if (!_describeLabel) {
        _describeLabel = [[UILabel alloc]init];
        _describeLabel.numberOfLines = 0;
        _describeLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        _describeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _describeLabel;
}

#pragma mark - UICollectionView

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageURLs.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    QCDetailCollectinViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:detailCollectionViewCellID forIndexPath:indexPath];
    NSString *url = self.imageURLs[indexPath.row];
    
    [cell.bgImage sd_setImageWithURL:[NSURL URLWithString:url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        cell.placeholderBtn.hidden = YES;
    }];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat page = offsetX / scrollView.mr_width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

@end
