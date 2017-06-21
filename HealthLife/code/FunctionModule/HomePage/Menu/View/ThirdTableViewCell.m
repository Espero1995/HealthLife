//
//  ThirdTableViewCell.m
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.stepImg.layer.masksToBounds=YES;
    self.stepImg.layer.cornerRadius=10.0f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
