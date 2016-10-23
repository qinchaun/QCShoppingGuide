//
//  QCLikeCell.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/17.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCLikeCell.h"

@interface QCLikeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@end


@implementation QCLikeCell

-(void)setItem:(QCItemModel *)item{
    _item = item;
    
    self.titleLb.text = item.title;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url]];
}

-(void)setProduct:(QCProductModel *)product{
    _product = product;
    
    self.titleLb.text = product.name;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:product.cover_image_url]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
