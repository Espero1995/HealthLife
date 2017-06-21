//
//  VideoCellTableViewCell.m
//  cell情况下播放视频
//
//  Created by Espero on 2017/6/8.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "VideoCellTableViewCell.h"
#import "VideoModel.h"
#import "UIImageView+WebCache.h"

@interface VideoCellTableViewCell()

@end

@implementation VideoCellTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"VideoCellTableViewCell";
    
    VideoCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setModel:(VideoModel *)model
{
    _model = model;
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.backImageView sd_setImageWithURL:[NSURL URLWithString:model.article_image]];
    });
    self.timeLabel.text = model.video_length;
    self.titleLabel.text = model.article_title;
    self.descLabel.text = model.article_abstract;
    
}

- (CGFloat)cellHeight
{
    [self layoutIfNeeded];
    
    return CGRectGetMaxY(self.descLabel.frame) + 25;
}

- (IBAction)sender:(id)sender {
}



@end
