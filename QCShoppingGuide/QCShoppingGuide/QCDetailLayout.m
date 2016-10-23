//
//  QCDetailLayout.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/13.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCDetailLayout.h"

@implementation QCDetailLayout

//准备布局
-(void)prepareLayout{
    [super prepareLayout];
    
    //设置layout布局
    self.itemSize = CGSizeMake(kScreenW, 375);
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置contentView属性
    self.collectionView.showsVerticalScrollIndicator = NO;
    //self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
}

@end
