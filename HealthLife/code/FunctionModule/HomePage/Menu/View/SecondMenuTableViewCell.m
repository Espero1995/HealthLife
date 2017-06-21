//
//  SecondMenuTableViewCell.m
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "SecondMenuTableViewCell.h"

@implementation SecondMenuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lv_image.layer.masksToBounds=YES;
    self.lv_image.layer.cornerRadius=10.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
