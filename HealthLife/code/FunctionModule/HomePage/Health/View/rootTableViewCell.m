//
//  rootTableViewCell.m
//  健康数据源获取
//
//  Created by Espero on 2017/6/19.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "rootTableViewCell.h"


@interface rootTableViewCell()

@end


@implementation rootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lv_image.layer.masksToBounds=YES;
    self.lv_image.layer.cornerRadius=10.0f;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
