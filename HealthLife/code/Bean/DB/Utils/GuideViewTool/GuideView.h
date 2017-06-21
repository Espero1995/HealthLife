//
//  GuideView.h
//  GuideView
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface GuideView : NSObject

@property(nonatomic,strong)UIWindow *window;
/**
 *  创建单例模式:
 *至少需要做以下四个步骤：　　
        1、为单例对象实现一个静态实例，并初始化，然后设置成nil，　　
        2、实现一个实例构造方法检查上面声明的静态实例是否为nil，如果是则新建并返回一个本类的实例，　　
        3、重写allocWithZone方法，用来保证其他人直接使用alloc和init试图获得一个新实力的时候不产生一个新实例，　　
        4、适当实现
 *
 *  @return 单例
 */
+(instancetype)sharedInstance;//共享实例

/**
 *  引导页图片
 *
 *  @param images      引导页图片
 *  @param title       按钮文字
 *  @param titleColor  文字颜色
 *  @param bgColor     按钮背景颜色
 *  @param borderColor 按钮边框颜色
 */
-(void)showGuideViewWithImages:(NSArray *)images
                    andButtonTitle:(NSString *)title
                    andButtonTitleColor:(UIColor *)titleColor
                    andButtonBGColor:(UIColor *)bgColor
                    andButtonBorderColor:(UIColor *)borderColor;

@end
