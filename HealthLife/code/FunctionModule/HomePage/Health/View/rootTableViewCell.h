//
//  rootTableViewCell.h
//  健康数据源获取
//
//  Created by Espero on 2017/6/19.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface rootTableViewCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *lv_image;
//标题
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
//发布时间
@property (weak, nonatomic) IBOutlet UILabel *lab_time;
//关键字
@property (weak, nonatomic) IBOutlet UILabel *lab_keywords;

@end
