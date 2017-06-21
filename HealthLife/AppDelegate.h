//
//  AppDelegate.h
//  HealthLife
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"

//关于登录注册的
#import "Constant.h"
#import "XMPPFramework.h"

@protocol LoginRegistDelegate
- (void)showAlert:(NSString*) message;
@optional  //可选
- (void)loginSuccess;
@end



@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(strong,nonatomic)MainTabBarController *mainTabarController;

//登录注册
@property (weak, nonatomic) id<LoginRegistDelegate> loginRegistDelegate;
@property (strong, nonatomic) XMPPStream* xmppStream;//2.在代理里面引入包，并定义流属性
@property (strong, nonatomic) dispatch_queue_t queue;
// 用于临时存储接收到的消息
@property (strong, nonatomic) NSMutableDictionary<NSString*, NSMutableArray<XMPPMessage*>*>* historyMessage ;

- (BOOL)connect:(BOOL)isRegist;//判断是否注册
- (void)goOffline;


@end

