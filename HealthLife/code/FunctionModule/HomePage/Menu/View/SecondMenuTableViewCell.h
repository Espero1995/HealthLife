//
//  SecondMenuTableViewCell.h
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondMenuTableViewCell : UITableViewCell
//图片
@property (weak, nonatomic) IBOutlet UIImageView *lv_image;
//标题
@property (weak, nonatomic) IBOutlet UILabel *lab_title;
//关键字
@property (weak, nonatomic) IBOutlet UILabel *lab_keywords;

@end
