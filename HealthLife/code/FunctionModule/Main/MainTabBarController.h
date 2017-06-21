//
//  MainTabBarController.h
//  MainTabBar
//
//  Created by Espero on 2017/5/27.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "ChatViewController.h"
#import "OtherViewController.h"
#import "MyViewController.h"
@interface MainTabBarController : UITabBarController<UITabBarControllerDelegate>
@property(strong,nonatomic)HomeViewController *home;
@property(strong,nonatomic)ChatViewController *chat;
@property(strong,nonatomic)OtherViewController *other;
@property(strong,nonatomic)MyViewController *my;
@end
