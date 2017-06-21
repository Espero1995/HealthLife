//
//  QViewController.h
//  App
//
//  Created by Yu on 16/2/27.
//  Copyright © 2016年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNavigationController.h"
#import "Constant.h"

@interface QViewController : UIViewController

///左上角按钮点击事件(默认图标：箭头)
-(void)leftBarClick;

///右上角按钮点击事件(默认图标：无，要使用自己添加)
-(void)rightBarClick;

///设置当有navigationController时，子view是否自动下移64(默认不下移,当启用时navigationBar透明度不能设置成0)
-(void)setChildViewAutoMoveDown64:(BOOL)on;

///设置当有navigationController时，且第一个子view是UIScrollView类型的时，是否自动下移64(默认开启)
-(void)setScrollViewAutoAdjust:(BOOL)on;

///设置默认的导航栏样式
-(void)setDefaultNavigationBarStyle;

///是否在显示
-(BOOL)controllerIsShow;

@end
