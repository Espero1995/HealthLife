//
//  VideoCellTableViewCell.h
//  cell情况下播放视频
//
//  Created by Espero on 2017/6/8.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoModel;


@interface VideoCellTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *coverView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;

@property (nonatomic, strong) VideoModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (CGFloat)cellHeight;

@end
