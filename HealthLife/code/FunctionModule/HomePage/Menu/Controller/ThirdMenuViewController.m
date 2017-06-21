//
//  ThirdMenuViewController.m
//  轮播图+滑块+tableview
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "ThirdMenuViewController.h"

#import "AFNetworking.h"
#import "UIImageView+WebCache.h"

#import "ThirdTableViewCell.h"
#import "MenuStep.h"

@interface ThirdMenuViewController ()

@property (weak, nonatomic) IBOutlet UILabel *menuTitle;
//原料
@property (weak, nonatomic) IBOutlet UILabel *menuIngredients;
//佐料
@property (weak, nonatomic) IBOutlet UILabel *menuBurden;

@property (weak, nonatomic) IBOutlet UITableView *tb_menu;

@end

@implementation ThirdMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"详细";
    
    self.menuTitle.text=self.detailMenu.mMenuName;
    self.menuIngredients.text=self.detailMenu.mIngredients;
    self.menuBurden.text=self.detailMenu.mBurden;
    //去掉cell的分割线
    self.tb_menu.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.tb_menu.opaque = NO;//背景图片也能显示
    self.tb_menu.backgroundColor = [UIColor clearColor];
    
    UIImageView*newimg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 250.0f)];
    [newimg setImage:[UIImage imageNamed:@"tableBg.jpg"]];
    self.tb_menu.backgroundView=newimg;
    
    //必须初始化
    _arrayData=[[NSMutableArray alloc] init];
    //存数据
    for (NSDictionary *dic in self.detailMenu.mSteps) {
        NSString *strStep=[dic objectForKey:@"step"];
        NSString *strImg=[dic objectForKey:@"img"];
        //        NSLog(@"步骤：%@",strStep);
        //        NSLog(@"步骤图片：%@",strImg);
        MenuStep *s=[[MenuStep alloc]init];
        s.mStep=strStep;
        s.mPicStr=strImg;
        [_arrayData addObject:s];
    }

}

//----------------------------------------method---------------------------------------


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
    ThirdTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil) {
        [tableView registerNib:[UINib nibWithNibName:@"ThirdTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    
    MenuStep *s=[_arrayData objectAtIndex:indexPath.row];
    
    [cell.stepImg sd_setImageWithURL:[NSURL URLWithString:s.mPicStr]];
    cell.Step.text=s.mStep;
    cell.backgroundColor=[UIColor clearColor];
    return cell ;
}
//设置单元格高度
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

//处理点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
