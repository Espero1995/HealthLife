//
//  QViewController.m
//  App
//
//  Created by Yu on 16/2/27.
//  Copyright © 2016年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

#import "QViewController.h"

@interface QViewController ()

@end

@implementation QViewController

//--------------------------------------------System----------------------------------------------//

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_black"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//--------------------------------------------Click Method-----------------------------------------//

-(void)leftBarClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBarClick
{
    
}

//--------------------------------------------Method-----------------------------------------//

//讲解例子：http://blog.csdn.net/cny901111/article/details/26529949
-(void)setChildViewAutoMoveDown64:(BOOL)on
{
    if (on) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }else{
        self.edgesForExtendedLayout = UIRectEdgeAll;
    }
}

-(void)setScrollViewAutoAdjust:(BOOL)on
{
    if (on) {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
}

-(void)setDefaultNavigationBarStyle
{
//    [self.navigationController setNavigationBarHidden:NO];
    self.navigationController.navigationBar.hidden=NO;
    [((QNavigationController *)self.navigationController) setLineHidden:NO];
    [((QNavigationController *)self.navigationController) setBgColor:BAR_TINT_COLOR];
    [((QNavigationController*)self.navigationController) setAlpha:1];
}

-(BOOL)controllerIsShow
{
    if (self.isViewLoaded && self.view.window) {
        return YES;
    }else{
        return NO;
    }
}

@end
