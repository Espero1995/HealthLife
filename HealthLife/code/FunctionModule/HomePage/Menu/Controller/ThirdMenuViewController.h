//
//  ThirdMenuViewController.h
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "QViewController.h"

#import "MenuDetail.h"
@interface ThirdMenuViewController : QViewController
{
    //    创建数据源对象
    NSMutableArray *_arrayData;
    
}
@property MenuDetail *detailMenu;
@end
