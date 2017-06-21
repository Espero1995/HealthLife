//
//  GuideViewCell.m
//  GuideView
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "GuideViewCell.h"
#import "GuideView.h"

@interface GuideViewCell()

@end

@implementation GuideViewCell


//-------------------------------------------method-------------------------------------------
-(instancetype)init{
    if (self=[super init]) {
        [self initView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initView];
    }
    return self;
}
//初始化视图
-(void)initView{
    self.layer.masksToBounds=YES;
    self.imageView=[[UIImageView alloc]initWithFrame:kHcdGuideViewBounds];
    self.imageView.center=CGPointMake(kHcdGuideViewBounds.size.width/2, kHcdGuideViewBounds.size.height/2);
    //设置按钮样式
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.hidden=YES;
    [button setFrame:CGRectMake(0, 0, 200, 44)];
    [button setTitle:@"" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.layer setCornerRadius:5];
    [button.layer setBorderColor:[UIColor grayColor].CGColor];
    [button.layer setBorderWidth:1.0f];
    [button setBackgroundColor:[UIColor whiteColor]];
    self.button=button;
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.button];
    [self.button setCenter:CGPointMake(kHcdGuideViewBounds.size.width / 2, kHcdGuideViewBounds.size.height - 100)];
}
@end
