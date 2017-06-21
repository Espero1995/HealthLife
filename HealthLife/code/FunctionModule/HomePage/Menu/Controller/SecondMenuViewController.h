//
//  SecondMenuViewController.h
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "QViewController.h"

@interface SecondMenuViewController : QViewController
//数据视图协议
<
UITableViewDelegate,
UITableViewDataSource
>
{
    //创建数据视图
    UITableView *_tableView;
    //    创建数据源对象
    NSMutableArray *_arrayData;
    
}

@property(retain,nonatomic)NSString *id;
@end
