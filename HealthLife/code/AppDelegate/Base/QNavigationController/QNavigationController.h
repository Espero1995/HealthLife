//
//  QNavigationController.h
//  App
//
//  Created by Yu on 16/2/27.
//  Copyright © 2016年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 
 自定义navigationBar背景颜色和透明度的QNavigationController
 
 */
@interface QNavigationController : UINavigationController

///设置背景颜色
-(void)setBgColor:(UIColor*)color;

///设置背景颜色，自定义是否开启渐变动画，动画时长
-(void)setBgColor:(UIColor*)color Animation:(BOOL)on Duration:(CGFloat)time;

///设置navigationBar透明度
-(void)setAlpha:(CGFloat)alpha;

///设置navigationBar透明度，自定义是否开启渐变动画，动画时长
-(void)setAlpha:(CGFloat)alpha Animation:(BOOL)on Duration:(CGFloat)time;

///设置是否隐藏navigationBar底部的黑线(默认显示)
-(void)setLineHidden:(BOOL)on;



@end
