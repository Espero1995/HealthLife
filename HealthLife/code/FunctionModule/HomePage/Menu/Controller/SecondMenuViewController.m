//
//  SecondMenuViewController.m
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//



#import "SecondMenuViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "MenuDetail.h"

#import "ThirdMenuViewController.h"

#import "SecondMenuTableViewCell.h"

@interface SecondMenuViewController ()

@end

@implementation SecondMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"菜谱资讯";
    //创建数据视图
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    //设置数据视图的代理
    _tableView.dataSource=self;
    _tableView.delegate=self;
    //设置自动调整视图的大小
    _tableView.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    
    _arrayData=[[NSMutableArray alloc] init];
    [self pressLoad];
  }
//----------------------------------------method---------------------------------------

//加载新的数据刷新显示的视图
-(void) pressLoad{
    [self loadData];
}

//下载数据
-(void)loadData{
    //获取AFHTTPSession对象，下载网络数据
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"http://apis.juhe.cn/cook/index?key=%@&cid=%@",MENU,self.id];
    
    //下载网络数据
    [session GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSLog(@"下载成功！");
        [self parseData:responseObject];
        //        NSLog(@"字典源：%@",responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"下载失败！");
    }];
    
}
//解析数据
-(void)parseData:(NSDictionary *)dic{
    NSDictionary *resultDic=[dic objectForKey:@"result"];
    NSArray *dataArr=[resultDic objectForKey:@"data"];
    //        NSLog(@"打印看看结果:%@",dataArr);
    
    for (NSDictionary *detailDic in dataArr) {
        MenuDetail *book=[[MenuDetail alloc]init];
        //菜名
        book.mMenuName=[detailDic objectForKey:@"title"];
        //菜名标签
        book.mTag=[detailDic objectForKey:@"tags"];
        //图片
        NSArray *picArr=[detailDic objectForKey:@"albums"];
        NSString *picUrl=picArr[0];
        book.mMenuPic=picUrl;
        //食材佐料
        book.mBurden=[detailDic objectForKey:@"burden"];
        //食材原料
        book.mIngredients=[detailDic objectForKey:@"ingredients"];
        
        book.mSteps=[detailDic objectForKey:@"steps"];
        
        [_arrayData addObject:book];
    }
    
    [_tableView reloadData];
}
//----------------------------------------delegate---------------------------------------
//组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//数据的个数
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _arrayData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *CellIdentifier=@"CellIdentifier";
    SecondMenuTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        [tableView registerNib:[UINib nibWithNibName:@"SecondMenuTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    MenuDetail *b=[_arrayData objectAtIndex:indexPath.row];
    
    [cell.lv_image sd_setImageWithURL:[NSURL URLWithString:b.mMenuPic]];
    cell.lab_title.text=b.mMenuName;
    cell.lab_keywords.text=b.mTag;
    return cell ;
    
}

//设置单元格高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
//处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MenuDetail *book=[_arrayData objectAtIndex:indexPath.row];
    
    //进入第二层页面的内容
    ThirdMenuViewController *detail=[[ThirdMenuViewController alloc]init];
    
    detail.detailMenu=book;
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
