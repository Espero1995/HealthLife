//
//  registViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/12.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "registViewController.h"

@interface registViewController ()<LoginRegistDelegate>//注册的代理
@property (weak, nonatomic) IBOutlet UITextField *userName;//注册名
@property (weak, nonatomic) IBOutlet UITextField *password;//密码
@property (weak, nonatomic) IBOutlet UITextField *confirmPass;//确认密码

@property (weak, nonatomic) IBOutlet UIButton *registBtStyle;
//注册按钮样式


@end

@implementation registViewController{
    AppDelegate* _appDelegate;
}

//-------------------------------------system-------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 获取应用程序代理
    _appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    _appDelegate.loginRegistDelegate = self;
    
    //按钮样式
    self.registBtStyle.layer.borderWidth=1.0f;
    self.registBtStyle.layer.cornerRadius=17.0f;
    self.registBtStyle.layer.borderColor=[[UIColor lightGrayColor]CGColor];
    
    
    //selected/unselected(不出现高亮状态)
    [self.unselected setImage:[UIImage imageNamed:@"unselected.gif"] forState:UIControlStateNormal];
    [self.unselected setImage:[UIImage imageNamed:@"unselected.gif"] forState:UIControlStateHighlighted];
    [self.unselected setImage:[UIImage imageNamed:@"selected.gif"] forState:UIControlStateSelected];
    [self.unselected setImage:[UIImage imageNamed:@"selected.gif"] forState:UIControlStateSelected | UIControlStateHighlighted];
    //协议按钮选择状态事件
    [self.unselected addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];

    
}

//设置页面的导航栏为默认
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [((QNavigationController*)self.navigationController) setLineHidden:YES];
    [((QNavigationController*)self.navigationController) setAlpha:0];
    ((QNavigationController*)self.navigationController).navigationBar.hidden=YES;
    
}




//-------------------------------------method-------------------------------------

- (IBAction)backLogin:(id)sender {
    LoginViewController *login=[[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

//协议按钮选择状态事件
-(void)touchUpInside:(UIButton *)button{
    button.selected=!button.selected;
}

- (IBAction)regist:(id)sender {
    [self loginOrRegist:YES];  // 注册
}


// 定义处理用户登录或注册的方法
- (void)loginOrRegist:(BOOL)isRegist{
    NSString* userText = self.userName.text;
    NSString* passText = self.password.text;
    NSString* serverText =@"127.0.0.1";
    if (userText != nil && passText != nil&&userText.length > 0 && passText.length > 0&&self.confirmPass.text!=nil&&self.confirmPass.text.length>0&&[passText isEqualToString:self.confirmPass.text]&&self.unselected.selected) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:userText forKey:USER_KEY];
        [defaults setObject:passText forKey:PASS_KEY];
        [defaults setObject:serverText forKey:SERVER_KEY];
        // 保存
        [defaults synchronize];
        // 调用AppDelegate的connect方法来发送请求
        [_appDelegate connect:isRegist];
        
    } else if([userText isEqualToString:@""]||[passText isEqualToString:@""]||[self.confirmPass.text isEqualToString:@""]){
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Warming", nil)
                                    subtitle:NSLocalizedString(@"请输入用户名、密码以及确认密码!", nil)
                                        type:TSMessageNotificationTypeWarning];
    }else if(passText!=self.confirmPass.text){
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Warming", nil)
                                             subtitle:NSLocalizedString(@"两次密码不一致", nil)
                                                 type:TSMessageNotificationTypeWarning];

    }else if (!self.unselected.selected){
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Warming", nil)
                                    subtitle:NSLocalizedString(@"你还未同意Health用户协议", nil)
                                        type:TSMessageNotificationTypeWarning];

    }else{
        [self registSuccess];//注册成功！！
    }
    
    
}

-(void)registSuccess{
    
        LoginViewController *login=[[LoginViewController alloc]init];
    
    [TSMessage showNotificationWithTitle:NSLocalizedString(@"Success", nil)
                                subtitle:NSLocalizedString(@"注册成功!\n您可输入刚注册的用户名、密码登陆系统", nil)
                                    type:TSMessageNotificationTypeSuccess];
    

    [self.navigationController pushViewController:login animated:YES];
}

//-------------------------------------delegate-------------------------------------
// 定义显示提示框的方法
- (void)showAlert:(NSString*)message {
    if([message isEqualToString:@"注册失败！\n请稍后使用新的用户名尝试"]){
        [TSMessage showNotificationWithTitle:NSLocalizedString(@"Error", nil)
                                    subtitle:NSLocalizedString(message, nil)
                                        type:TSMessageNotificationTypeError];
    }else{
         [self registSuccess];//注册成功！！
    }
}

- (IBAction)UserAgreement:(id)sender {
    UserAgreementViewController *agree=[[UserAgreementViewController alloc]init];
    [self.navigationController pushViewController:agree animated:YES];
}
@end
