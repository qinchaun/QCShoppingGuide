//
//  QCCommentCell.m
//  QCShoppingGuide
//
//  Created by tarena on 16/10/14.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "QCCommentCell.h"
#import "QCUser.h"
#import <UIImageView+WebCache.h>
#import "NSDate+MRExtension.h"

@interface QCCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end


@implementation QCCommentCell

-(void)setComment:(QCCommentModel *)comment{
    _comment = comment;
    QCUser *user = comment.user;
    NSString *url = user.avatar_url;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:url]];
    self.nickNameLabel.text = user.nickname;
    self.contentLabel.text = comment.content;
    self.timeLabel.text = [NSDate dateWithTimeStamp:comment.created_at];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
