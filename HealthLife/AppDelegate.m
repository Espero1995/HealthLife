//
//  AppDelegate.m
//  HealthLife
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//
//确定id唯一就行
#import "AppDelegate.h"

#import "Constant.h"
#import "GuideView.h"

#import "IQKeyboardManager.h"//键盘
#import "QNavigationController.h"
#import "MainTabBarController.h"

#import "REFrostedViewController.h"
//#import "MenuTableViewController.h"
#import "LoginViewController.h"

@interface AppDelegate ()<XMPPStreamDelegate>

@end

@implementation AppDelegate{
    // 控制注册或登陆的旗标
    BOOL _isRegist;
}

//--------------------------------------------System----------------------------------------------//
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    
    ///显示主界面
    [self showMainTabBarController];
    [self guide];
    return YES;
}

///将要进入后台
- (void)applicationWillResignActive:(UIApplication *)application {
    
}

///进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

///将要进入前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

///进入前台
- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

///完全退出
- (void)applicationWillTerminate:(UIApplication *)application {
  
}

//--------------------------------------------method----------------------------------------------//

///显示主界面
-(void)showMainTabBarController
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldResignOnTouchOutside = YES;//点击屏幕键盘是否消失
    manager.enableAutoToolbar=NO;
    
    self.window=[[UIWindow alloc] initWithFrame:[UIScreen  mainScreen].bounds];//显示窗口配置
    
//    self.mainTabarController=[[MainTabBarController alloc] init];
    
//    QNavigationController *nav=[[QNavigationController alloc] initWithRootViewController:self.mainTabarController];
    
    LoginViewController *login=[[LoginViewController alloc]init];
    QNavigationController *nav=[[QNavigationController alloc] initWithRootViewController:login];
   
    nav.navigationBar.barStyle = UIBarStyleDefault;
    
    [nav.navigationBar setBarTintColor:BAR_TINT_COLOR];//标题栏背景颜色
    
    [nav.navigationBar setTintColor:BAR_BTN_COLOR];//标题栏按钮颜色
    
    [nav.navigationBar setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithWhite:0.322 alpha:1.000], NSForegroundColorAttributeName, Font(NAVBER_TITLE_FONT), NSFontAttributeName, nil]];//标题文字大小和颜色
    
    
    
    
    //加入menu面板
//    MenuTableViewController *menuController=[[MenuTableViewController alloc]initWithStyle:UITableViewStylePlain];
//    
//    // Create frosted view controller(覆盖)
//    REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:nav menuViewController:menuController];
//    //方向
//    frostedViewController.direction=REFrostedViewControllerDirectionLeft;
//    frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    
    
    
    
    self.window.rootViewController=nav;
    
//    self.window.rootViewController=nav;
    
    //设置Window为主窗口并显示出来
    [self.window makeKeyAndVisible];
}


//------------------------------------------关于引导图-------------------------------------------
//第一次启动引导图
-(void)guide{
    //建立引导图可变数组
    NSMutableArray *images = [NSMutableArray new];
    [images addObject:[UIImage imageNamed:@"1"]];
    [images addObject:[UIImage imageNamed:@"2"]];
    [images addObject:[UIImage imageNamed:@"3"]];
    
    GuideView *guideView = [GuideView sharedInstance];
        guideView.window = self.window;
    [guideView showGuideViewWithImages:images
                        andButtonTitle:@"欢迎注册"
                   andButtonTitleColor:[UIColor whiteColor]
                      andButtonBGColor:[UIColor clearColor]
                  andButtonBorderColor:[UIColor whiteColor]];
}

//------------------------------------------关于登录注册-------------------------------------------
// 创建并初始化XMPPStream
-(void)setupStream{
    self.historyMessage = [NSMutableDictionary dictionary];
    // 简单起见，直接使用主线程创建串行队列
    self.queue = dispatch_get_main_queue();
    // 初始化XMPPStream
    self.xmppStream = [[XMPPStream alloc] init];
    // 为XMPPStream添加代理
    [self.xmppStream addDelegate:self delegateQueue:self.queue];
    
    
    
}
-(BOOL)connect:(BOOL)isRegist{
    // 创建并初始化XMPPStream和XMPPRoster
    [self setupStream];
    // 从本地取得用户名，和服务器地址
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* userId = [defaults stringForKey:USER_KEY];
    NSString* server = [defaults stringForKey:SERVER_KEY];
    // 如果xmppStream已经建立了连接，先断开连接
    if ([self.xmppStream isConnected]){
        NSLog(@"已经连接了 ");
        [self goOffline];  // 发送下线通知
        [self.xmppStream disconnect];
    }
    if (userId == nil || userId.length == 0
        || server == nil || server.length == 0){
        return NO;
    }
    // 控制注册或登陆的旗标
    _isRegist = isRegist;
    //设置服务器
    self.xmppStream.hostName = server;
    // 设置连接时的用户名
    self.xmppStream.myJID = [XMPPJID jidWithString:[NSString stringWithFormat:
                                                    @"%@%@", userId, HOST_SUFFIX]];
    NSError* error;
    [self.xmppStream connectWithTimeout:2 error: &error];
    if (error == nil) {
        NSLog(@"-------connect方法执行完成！！！------");
        return YES;
    }else{
        NSLog(@"连接服务器出现错误%@", error);
        return NO;
    }
    
    
}





// 定义发送上线的方法
- (void)goOnline{
    // 发送在线状态
    XMPPPresence* presence = [XMPPPresence presence];
    [self.xmppStream sendElement:presence];
}
// 定义发送下线的方法
- (void)goOffline{
    // 发送下线状态
    XMPPPresence* presence = [XMPPPresence presenceWithType: @"unavailable"];
    [self.xmppStream sendElement:presence];
}


//------------------XMPPStreamDelegate代理中的方法--------------—
- (void)xmppStream:(XMPPStream *)sender didReceiveError:(DDXMLElement *)error{
    NSLog(@"收到错误！");
}
- (void)xmppStream:(XMPPStream *)sender socketDidConnect:(GCDAsyncSocket *)socket{
    NSLog(@"底层网络Socket已经连接成功");
}
- (void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    NSLog(@"连接超时！");
}

// 连接服务器成功时激发该方法
- (void)xmppStreamDidConnect:(XMPPStream *)sender{
    // 从本地取得密码
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* pass = [defaults stringForKey:PASS_KEY];
    if (pass == nil || pass.length == 0) {
        [self.loginRegistDelegate showAlert:@"用户没有输入有效的密码!"];
        return;
    }
    if (_isRegist) {
        // 注册用户
        [self.xmppStream registerWithPassword:pass error: nil];
    }else{
        // 验证密码来登陆系统
        [self.xmppStream authenticateWithPassword:pass error: nil];
    }
}

// 验证通过
- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    [self goOnline];
    // 调用loginRegistDelegate的loginSuccess显示登录成功
    [self.loginRegistDelegate loginSuccess];
}
// 验证不通过
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"%@", error);
    [self.loginRegistDelegate showAlert:@"登录失败!请确认您输入的用户名、密码正确。\n如果还没有账户，请先注册"];
    //    [Toast showInfo:@"账户或密码错误！"];
}

// 注册成功
- (void)xmppStreamDidRegister:(XMPPStream *)sender{
    [self.loginRegistDelegate showAlert:@"注册成功!\n您可输入刚注册的用户名、密码登陆系统"];
}
// 注册失败
- (void)xmppStream:(XMPPStream *)sender didNotRegister:(DDXMLElement *)error{
    NSLog(@"%@", error);
    [self.loginRegistDelegate showAlert:@"注册失败！\n请稍后使用新的用户名尝试"];
}

@end
