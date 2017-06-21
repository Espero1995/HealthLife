//
//  MyViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/17.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "MyViewController.h"

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Constant.h"


@interface MyViewController (){
    UITableView *MyTable;
}

@property AppDelegate *_appDelegate;
@property(nonatomic,strong)NSString *loginName;
@end

@implementation MyViewController

//-------------------------------------system---------------------------------------------------//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *nsUD=[NSUserDefaults standardUserDefaults];
    self.loginName= [nsUD objectForKey:@"userName"];
    NSLog(@"登录名:%@",self.loginName);
    __appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [self setUpTableView];
}

//设置导航栏为默认
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setDefaultNavigationBarStyle];
}



//-------------------------------------method---------------------------------------------------//
-(void)setUpTableView{
    MyTable=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, S_WIDTH, S_HEIGHT-90) style:UITableViewStyleGrouped];
    MyTable.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    MyTable.delegate=self;
    MyTable.dataSource=self;
    //cell下面的线的颜色
    MyTable.separatorColor = [UIColor colorWithRed:121/255.0 green:174/255.0 blue:228/255.0 alpha:1.0];
    MyTable.opaque = NO;//背景图片也能显示
    MyTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    MyTable.backgroundColor = [UIColor clearColor];
    
    MyTable.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        view.contentMode=UIViewContentModeScaleAspectFit;
        //给uitableview添加背景图片
        
        UIImageView*newimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        [newimg setImage:[UIImage imageNamed:@"rain.jpg"]];
        MyTable.backgroundView=newimg;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"touxiang.jpg"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 50.0;
        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        label.text =self.loginName;
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor whiteColor];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });

    
    [self.view addSubview:MyTable];
}



//-------------------------------------delegate---------------------------------------------------//
#pragma mark ——delegate
//(1)-----有1个section（段）——默认一段（可以不写）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

//(2)-----获取每组行数——必写协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
    }else if (section==1){
        return 2;
    }else{
        return 1;
    }
}

//(3)-----cell必写协议
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        NSArray *titles = @[@"Home", @"Profile", @"Chats"];
        cell.textLabel.text = titles[indexPath.row];
    } else if(indexPath.section==1){
        NSArray *titles = @[@"John Appleseed", @"关于我们"];
        cell.textLabel.text = titles[indexPath.row];
    }else{
        cell.textLabel.text=@"退出登录";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;//文字居中
    }
    return cell;

}

//(4)-----设置每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 54;
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor cyanColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    [label sizeToFit];

    
    if (sectionIndex == 0)
        return nil;
    if (sectionIndex==1) {
        label.text = @"Friends Online";
    }else{
        label.text=@"";
    }
    
    
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section==2) {
        if (indexPath.row==0) {//退出登录
            NSLog(@"我按的是退出按钮！！");
            [self._appDelegate goOffline];
            
            [Toast showInfo:@"成功登出~"];
            
            LoginViewController *login=[[LoginViewController alloc]init];
            [self.navigationController pushViewController:login animated:YES];
        }
    }
}

@end
