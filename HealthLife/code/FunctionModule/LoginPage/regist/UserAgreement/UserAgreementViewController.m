//
//  UserAgreementViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/18.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "UserAgreementViewController.h"

@interface UserAgreementViewController ()
@property (weak, nonatomic) IBOutlet UITextView *MytextView;

@end

@implementation UserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Health用户协议";
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//设置页面的导航栏为默认
-(void)viewWillAppear:(BOOL)animated
{
        [super viewWillAppear:animated];
        [self setDefaultNavigationBarStyle];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [self.MytextView setContentOffset:CGPointZero animated:NO];
}



@end
