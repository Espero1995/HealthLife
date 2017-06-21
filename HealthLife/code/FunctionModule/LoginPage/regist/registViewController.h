//
//  registViewController.h
//  HealthLife
//
//  Created by Espero on 2017/6/12.
//  Copyright © 2017年 Espero. All rights reserved.
//


#import "QViewController.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "TSMessageView.h"
#import "UserAgreementViewController.h"
@interface registViewController : QViewController
//勾选按钮
@property (weak, nonatomic) IBOutlet UIButton *unselected;
//用户协议button
- (IBAction)UserAgreement:(id)sender;

@end
