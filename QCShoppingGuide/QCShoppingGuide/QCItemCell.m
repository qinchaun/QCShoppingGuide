//
//  QCItemCell.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/10.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCItemCell.h"
#import <UIImageView+WebCache.h>
#import "QCNetworkTool.h"
#import "QCLoginViewController.h"
#import "QCNavigationController.h"

@interface QCItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UIButton *placeBtn;

@property (weak, nonatomic) IBOutlet UIButton *favoriteBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation QCItemCell

-(void)setItem:(QCItemModel *)item{
    _item = item;
    
    __weak typeof(self)weakSelf = self;
    self.titleLabel.text = item.title;
    [self.favoriteBtn setTitle:[NSString stringWithFormat:@"%ld ",item.likes_count] forState:UIControlStateNormal];
    self.favoriteBtn.selected = (item.status == 1? YES:NO);
    [self.bgImage sd_setImageWithURL:[NSURL URLWithString:item.cover_image_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.placeBtn.hidden = YES;
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.favoriteBtn.layer.cornerRadius = self.favoriteBtn.mr_height*0.5;
    self.favoriteBtn.layer.masksToBounds = YES;
    //开启离屏渲染
    self.favoriteBtn.layer.rasterizationScale = [[UIScreen mainScreen]scale];
    self.favoriteBtn.layer.shouldRasterize = YES;
    
    self.bgImage.layer.cornerRadius = 8;
    self.bgImage.layer.masksToBounds = YES;
    //开启离屏渲染
    self.bgImage.layer.shouldRasterize = YES;
    self.bgImage.layer.rasterizationScale = [[UIScreen mainScreen]scale];
}

- (IBAction)likeBtnClick:(UIButton *)btn {
    NSString *url = nil;
    if (btn.selected) { // 已经被选中
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/posts/%ld/like?",self.item.itemID];
        //想服务器发送点赞请求
        [[QCNetworkTool sharedNetworkTool]loadDataInfoDelete:url parameters:nil success:^(id responseObject) {
            NSString *message = responseObject[@"message"];
            if ([message isEqualToString:@"OK"]) {//操作成功，后台已更新
                //发送通知
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LYThemeLikeNotification" object:nil];
                btn.selected = !btn.selected;
            }
        } failure:^(NSError *error) {
            
        }];
    }else{//未选中
        url = [NSString stringWithFormat:@"http://api.dantangapp.com/v1/posts/%ld/like",self.item.itemID];
        //想服务器发送点赞请求
        [[QCNetworkTool sharedNetworkTool]loadDataInfoPost:url parameters:nil success:^(id responseObject) {
            NSString *message = responseObject[@"message"];
            if ([message isEqualToString:@"OK"]) {
                //发送通知
                [[NSNotificationCenter defaultCenter]postNotificationName:@"LYThemeLikeNotification" object:nil];
                btn.selected = !btn.selected;
            }
        } failure:^(NSError *error) {
            
        }];
    }

//    QCLoginViewController *vc = [[QCLoginViewController alloc]init];
//    QCNavigationController *loginNav = [[QCNavigationController alloc] initWithRootViewController:vc];
//    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:loginNav animated:YES completion:nil];
//    
//    [btn setImage:[UIImage imageNamed:@"content-details_like_selected_16x16_"] forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    static CGFloat const margin = 10;
    
    frame.size.width -= 2*margin;
    frame.origin.x = margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
