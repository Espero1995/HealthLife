//
//  MainTabBarController.m
//  MainTabBar
//
//  Created by Espero on 2017/5/27.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "MainTabBarController.h"
#import "QNavigationController.h"
#import "Constant.h"
#import "MyTabBar.h"



#define TAB_HOME @"首页"
#define TAB_CHAT @"聊天"
#define TAB_OTHER @"其他"
#define TAB_MY @"我"
@interface MainTabBarController ()

@end

@implementation MainTabBarController
//--------------------------------------------System----------------------------------------------//
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [((QNavigationController *)self.navigationController) setLineHidden:NO];
    [((QNavigationController*)self.navigationController) setAlpha:1];
}

//---------------------------------------------init-----------------------------------------------//
///初始化界面
-(void)initView
{

    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(rightBarClick)];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftBarClick)];
    
    
    
    //因为一般为了不让tableView 不延伸到 navigationBar 下面， 属性设置为 UIRectEdgeNone
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.delegate=self;//设置代理
    
    self.home=[[HomeViewController alloc]init];
    [self initTabBarItem:self.home.tabBarItem Title:TAB_HOME SelectedImage:@"sHome.png" UnselectedImage:@"Home.png"];

    
    self.chat=[[ChatViewController alloc]init];
    [self initTabBarItem:self.chat.tabBarItem Title:TAB_CHAT SelectedImage:@"sHypno.png" UnselectedImage:@"Hypno.png"];


    self.other=[[OtherViewController alloc]init];
    [self initTabBarItem:self.other.tabBarItem Title:TAB_OTHER SelectedImage:@"sUser.png" UnselectedImage:@"User.png"];

    
    self.my=[[MyViewController alloc]init];
    [self initTabBarItem:self.my.tabBarItem Title:TAB_MY SelectedImage:@"sUser.png" UnselectedImage:@"User.png"];
    
    
    [self addChildViewController:self.home];
    [self addChildViewController:self.chat];
    [self addChildViewController: self.other];
    [self addChildViewController:self.my];
    
    [self changeNavigationBar:TAB_HOME];
    //给TabBar设置动画效果
    MyTabBar *myTabBar = [[MyTabBar alloc] init];
    [self setValue:myTabBar forKey:@"tabBar"];
}
//--------------------------------------------method----------------------------------------------//

///初始化TabBarItem
-(void)initTabBarItem:(UITabBarItem *)tabBarItem Title:(NSString*)title SelectedImage:(NSString*)selectedImage UnselectedImage:(NSString*)unselectedImage
{
    [tabBarItem setTitle:title];
    
    [tabBarItem setImage:[[UIImage imageNamed:unselectedImage] imageWithRenderingMode:UIImageRenderingModeAutomatic]];//设置未选中时的图片

    [tabBarItem setSelectedImage:[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];//设置选中时的图片


    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        Font(TABBER_TITLE_FONT), NSFontAttributeName,[UIColor colorWithWhite:0.698 alpha:1.000],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateNormal];//设置未选中时的字体大小和颜色
    
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        Font(TABBER_TITLE_FONT),NSFontAttributeName,[UIColor colorWithRed:121/255.0 green:174/255.0 blue:228/255.0 alpha:1],NSForegroundColorAttributeName,
                                        nil] forState:UIControlStateSelected];//设置选中时的字体大小和颜色
}




///改变导航栏
-(void)changeNavigationBar:(NSString*)title
{
  
    if([title isEqualToString:TAB_HOME]){//首页
        self.title=@"首页";
        self.navigationItem.titleView=nil;
        [self changeNavigationBarLeftRightBtn:nil leftImg:[UIImage imageNamed:@"bigShadow.png"] rightTxt:nil rightImg:nil];
    }else if([title isEqualToString:TAB_CHAT]){//聊天
        self.title=@"聊天";
        self.navigationItem.titleView=nil;
        [self changeNavigationBarLeftRightBtn:nil leftImg:nil rightTxt:nil rightImg:nil];
        }else if([title isEqualToString:TAB_OTHER]){//其他
        self.title=@"其他";
        self.navigationItem.titleView=nil;
        [self changeNavigationBarLeftRightBtn:nil leftImg:nil rightTxt:nil rightImg:nil];
        }else{
            self.title=@"我";
            self.navigationItem.titleView=nil;
            [self changeNavigationBarLeftRightBtn:nil leftImg:nil rightTxt:nil rightImg:nil];
        }
}

///改变导航栏左右按钮
-(void)changeNavigationBarLeftRightBtn:(NSString*)leftText leftImg:(UIImage*)limg rightTxt:(NSString*)rightText rightImg:(UIImage*)rimg
{
    self.navigationItem.leftBarButtonItem.title=leftText;
    self.navigationItem.leftBarButtonItem.image=limg;
    self.navigationItem.rightBarButtonItem.title=rightText;
    self.navigationItem.rightBarButtonItem.image=rimg;
}



///导航栏左边按钮点击事件
-(void)leftBarClick
{
    if (self.selectedIndex==0) {
     
//        UIBarButtonItem *t=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"User.png"] style:UIBarButtonItemStylePlain target:(NavigationController *)self.navigationController action:@selector(showMenu)];
//        
//        self.navigationItem.leftBarButtonItem=t;
        
    }
}

///导航栏右边按钮点击事件
-(void)rightBarClick
{
    if (self.selectedIndex==0) {
//        [self.homePageController goPublish];
    }
    if (self.selectedIndex==1) {
//        [self.chatController showMenu];
    }
    if (self.selectedIndex==2) {
//        [self.wineCabinetController rightBarClick];
    }
    
}

//--------------------------------------------delegate----------------------------------------------//
#pragma mark -UITabBarDelegate
///选中某个vc
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    [self changeNavigationBar:item.title];
}


@end
