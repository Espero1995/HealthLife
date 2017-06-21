//
//  Constant.h
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//



@interface Constant : NSObject


///高德地图key



//----------------------------------------------常用方法
///设置字体大小
#define Font(f) [UIFont systemFontOfSize:f]

///导航栏背景颜色
#define BAR_TINT_COLOR ([UIColor whiteColor])

///导航栏按钮颜色
#define BAR_BTN_COLOR ([UIColor colorWithWhite:0.603 alpha:1.000])

///nav_bar文字大小
#define NAVBER_TITLE_FONT 17

///tabbar文字大小
#define TABBER_TITLE_FONT 10


///导航栏背景颜色
#define BAR_TINT_COLOR ([UIColor whiteColor])

//----------------------------------------------屏幕尺寸
///屏幕宽度
#define S_WIDTH ([[UIScreen mainScreen] bounds].size.width)

///屏幕高度
#define S_HEIGHT ([[UIScreen mainScreen] bounds].size.height)

#define MAIN_TONE_COLOR [UIColor colorWithRed:126/255.0 green:185/255.0 blue:245/255.0 alpha:1]

//关于登录注册
// 定义一些常量
#define USER_KEY @"userId"
#define PASS_KEY @"userPass"
#define SERVER_KEY @"server"
#define HOST_SUFFIX @"@yeeku-pro.local"
#define ROOM_SUFFIX @"conference.yeeku-pro.local"
#define GET_ROOMS_ID @"fkgetrooms"


//网上的API接口
//健康资讯
#define KEY_HEALTH @"e690c17edaf1dcc4f83ccb0e8340afd8"
//菜谱
#define MENU @"0be14dc72ad28ac6ddbbeba6e423d3e3"

@end
