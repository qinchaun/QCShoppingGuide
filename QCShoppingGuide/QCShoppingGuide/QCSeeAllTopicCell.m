//
//  QCSeeAllTopicCell.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/16.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCSeeAllTopicCell.h"

@interface QCSeeAllTopicCell ()
@property (weak, nonatomic) IBOutlet UIButton *placeholderBtn;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;


@end

@implementation QCSeeAllTopicCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)setCollection:(QCCollectionModel *)collection{
    _collection = collection;
    
    self.titleLabel.text = collection.title;
    self.subtitleLabel.text = collection.subtitle;
    
    __weak typeof(self)weakSelf = self;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:collection.cover_image_url]completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.placeholderBtn.hidden = YES;
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
