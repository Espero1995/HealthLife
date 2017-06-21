//
//  LoginViewController.h
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

#import "AppDelegate.h"

#import "QNavigationController.h"
#import "Toast.h"
#import "TSMessageView.h"
#import "Constant.h"
#import "registViewController.h"
@interface LoginViewController : UIViewController
@property(strong,nonatomic)MainTabBarController *mainTabarController;

@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *password;

@property AppDelegate* _appDelegate;//关于登录注册

@end
