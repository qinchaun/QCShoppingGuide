//
//  QCCategoryCollectionCell.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/15.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCategoryCollectionCell.h"
#import <UIImageView+WebCache.h>

@interface QCCategoryCollectionCell ()

@property (weak, nonatomic) IBOutlet UIButton *placeholderBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation QCCategoryCollectionCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setCollection:(QCCollectionModel *)collection{
    _collection = collection;
    
    __weak typeof(self)weakSelf = self;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:collection.banner_image_url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.placeholderBtn.hidden = YES;
    }];
}


@end
