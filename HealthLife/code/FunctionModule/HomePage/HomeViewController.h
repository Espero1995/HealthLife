//
//  HomeViewController.h
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QViewController.h"

//轮播图
#import "SDCycleScrollView.h"
//刷新
#import "MJRefresh.h"

//网络
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

//健康资讯需要的类
#import "HealthInfo.h"//model
#import "HealthDetailViewController.h"//健康详情页面
#import "rootTableViewCell.h"//cell样式

//视频播放需要的类
#import "VideoModel.h"
#import "VideoCellTableViewCell.h"
#import "WMPlayer.h"

//菜谱需要的类
#import "MenuList.h"
#import "SecondMenuViewController.h"


@interface HomeViewController : QViewController<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate,UIScrollViewDelegate,WMPlayerDelegate>


@end
