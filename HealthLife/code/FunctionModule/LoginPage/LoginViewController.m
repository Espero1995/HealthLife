//
//  LoginViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "LoginViewController.h"


@interface LoginViewController ()<LoginRegistDelegate>//协议

@property (weak, nonatomic) IBOutlet UIImageView *iv_bg;//背景图
//登录按钮样式
@property (weak, nonatomic) IBOutlet UIButton *loginStyle;
//登录名
@property (weak, nonatomic) IBOutlet UITextField *usernameText;
//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@end

@implementation LoginViewController
//-------------------------------------system-------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置样式
    self.usernameView.layer.cornerRadius=6.0f;
    self.usernameView.layer.borderWidth=1;
    self.usernameView.layer.borderColor= [[UIColor colorWithRed:120/255.0 green:176/255.0 blue:233/255.0 alpha:1] CGColor];
    self.password.layer.cornerRadius=6.0f;
    self.password.layer.borderWidth=1;
    self.password.layer.borderColor= [[UIColor colorWithRed:120/255.0 green:176/255.0 blue:233/255.0 alpha:1] CGColor];
    //按钮样式
    self.loginStyle.layer.borderWidth=1.0f;
    self.loginStyle.layer.cornerRadius=17.0f;
    self.loginStyle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    

    //登录-获取应用程序代理
    __appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    __appDelegate.loginRegistDelegate =self;
}

//在登录页面导航栏设置为透明
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [((QNavigationController*)self.navigationController) setLineHidden:YES];
    [((QNavigationController*)self.navigationController) setAlpha:0];
    ((QNavigationController*)self.navigationController).navigationBar.hidden=YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self bgAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//-------------------------------------method-------------------------------------
//登录按钮
- (IBAction)login_click:(id)sender {
//    self.mainTabarController=[[MainTabBarController alloc]init];
//    [self.navigationController pushViewController:self.mainTabarController animated:YES];

    [self loginOrRegist:NO];//登录
}

///背景图动画
-(void)bgAnimation
{
    [UIView animateWithDuration:10 delay:1 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
        if (self.iv_bg.frame.origin.x==0) {
            self.iv_bg.frame=CGRectMake(-S_WIDTH, self.iv_bg.frame.origin.y, self.iv_bg.frame.size.width, self.iv_bg.frame.size.height);
        }else{
            self.iv_bg.frame=CGRectMake(0, self.iv_bg.frame.origin.y, self.iv_bg.frame.size.width, self.iv_bg.frame.size.height);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            [self bgAnimation];
        }
    }];
}


// 定义处理用户登录或注册的方法
- (void)loginOrRegist:(BOOL)isRegist{
    NSString* userText = self.usernameText.text;
    NSString* passText = self.passwordText.text;
    NSString* serverText =@"127.0.0.1";
    if (userText != nil && passText != nil && serverText != nil &&
        userText.length > 0 && passText.length > 0 &&
        serverText.length > 0) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userText forKey:USER_KEY];
        [defaults setObject:passText forKey:PASS_KEY];
        [defaults setObject:serverText forKey:SERVER_KEY];
        // 保存
        [defaults synchronize];
        // 调用AppDelegate的connect方法来发送请求
        [self._appDelegate connect:isRegist];
        
    } else {
//        [Toast showInfo:@"请输入用户名、密码"];
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Warming", nil)
                                    subtitle:NSLocalizedString(@"请输入用户名、密码!", nil)
                                        type:TSMessageNotificationTypeWarning];
    }
}


// 登录成功
- (void)loginSuccess {
        self.mainTabarController=[[MainTabBarController alloc]init];
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Success", nil)
                                subtitle:NSLocalizedString(@"登录成功!", nil)
                                    type:TSMessageNotificationTypeSuccess];
    
    
    NSUserDefaults *nsUserDefaults = [NSUserDefaults standardUserDefaults];
    [nsUserDefaults setObject:self.usernameText.text forKey:@"userName"];
    [nsUserDefaults synchronize];
    
    [self.navigationController pushViewController:self.mainTabarController animated:YES];
    
}



///注册
- (IBAction)register:(id)sender {
    registViewController *regist=[[registViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}



//-------------------------------------delegate-------------------------------------
// 定义显示提示框的方法
- (void)showAlert:(NSString*)message {
    
    
    //    [Toast showInfo:message];
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Error", nil)
                                subtitle:NSLocalizedString(message, nil)
                                    type:TSMessageNotificationTypeError];
}
@end
