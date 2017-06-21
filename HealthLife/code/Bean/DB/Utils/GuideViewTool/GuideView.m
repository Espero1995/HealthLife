//
//  GuideView.m
//  GuideView
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "GuideView.h"
#import "GuideViewCell.h"
@interface GuideView()<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong)UICollectionView *view;//引导页面
@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)UIPageControl *pageControl;//引导图下的小圆点
@property(nonatomic,strong)UIColor *buttonBgColor;//按钮背景颜色
@property(nonatomic,strong)UIColor *buttonBorderColor;//边框颜色
@property(nonatomic,strong)UIColor *titleColor;//字体颜色
@property(nonatomic,copy)NSString *buttonTitle;//引用的是用一个按钮文本
@end

@implementation GuideView
//创建单例模式
+(instancetype)sharedInstance{
    static GuideView *instance=nil;
    //利用dispatch_once创建单例
    /**
     *函数void dispatch_once( dispatch_once_t *predicate, dispatch_block_t block);其中第一个参数predicate，该参数是检查后面第二个参数所代表的代码块是否被调用的谓词，第二个参数则是在整个应用程序中只会被调用一次的代码块。dispach_once函数中的代码块只会被执行一次，而且还是线程安全的。
     */
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        instance=[GuideView new];
    });
    return instance;
}

/**
 *  引导页界面
 *  对页面的约束
 *  @return 引导页界面
 */
-(UICollectionView *)view{
    if (!_view) {
        //创建自动网格布局
        UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
        layout.minimumLineSpacing=0;//设置最小行间距
        layout.minimumInteritemSpacing=0;//设置同一列中间隔的cell最小间距
        layout.itemSize=kHcdGuideViewBounds.size;//设置固定大小
        layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;//设置滚动方向
        //初始化view
        _view=[[UICollectionView alloc]initWithFrame:kHcdGuideViewBounds collectionViewLayout:layout];
        _view.bounces=NO;//一个布尔值控制滚动视图是否能越过边缘的内容和回来。
        _view.backgroundColor=[UIColor whiteColor];
        _view.showsHorizontalScrollIndicator=NO;//滚动条消失
        _view.showsVerticalScrollIndicator=NO;
        _view.pagingEnabled=YES;//是否启动分页滚动视图
        _view.dataSource=self;//协议
        _view.delegate=self;
        //从一个nib里面注册
        [_view registerClass:[GuideViewCell class] forCellWithReuseIdentifier:kCellIdentifier_GuideViewCell];
    }
      return _view;
}
/**
 *  初始化pageControl
 *  小圆点
 *  @return pageControl
 */
-(UIPageControl *)pageControl{
    if (_pageControl==nil) {
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.frame=CGRectMake(0, 0, kHcdGuideViewBounds.size.width, 44.0f);
        _pageControl.center=CGPointMake(kHcdGuideViewBounds.size.width/2, kHcdGuideViewBounds.size.height-60);
    }
    return _pageControl;
}

-(void)showGuideViewWithImages:(NSArray *)images
                andButtonTitle:(NSString *)title
                andButtonTitleColor:(UIColor *)titleColor
                andButtonBGColor:(UIColor *)bgColor
                andButtonBorderColor:(UIColor *)borderColor{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSString *version=[[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleShortVersionString"];
    //根据版本号来判断是否需要显示引导页，一般来说每更新一个版本引导页都会有相应的修改
    BOOL show=[userDefaults boolForKey:[NSString stringWithFormat:@"version_%@",version]];
    if (!show) {
        self.images=images;
        self.buttonBorderColor=borderColor;
        self.buttonBgColor=bgColor;
        self.buttonTitle=title;
        self.titleColor=titleColor;
        self.pageControl.numberOfPages=images.count;
        
        if (nil==self.window) {
            self.window=[UIApplication sharedApplication].keyWindow;
        }
        [self.window addSubview:self.view];
        [self.window addSubview:self.pageControl];
    }
    //存储数据
    [userDefaults setBool:YES forKey:[NSString stringWithFormat:@"version_%@",version]];
    [userDefaults synchronize];
    
}

#pragma mark-UICollectionViewDelegate &UICollectionViewDataSource
//定义展示的section的个数(一组)
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.images count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    GuideViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_GuideViewCell forIndexPath:indexPath];
    UIImage *img=[self.images objectAtIndex:indexPath.row];
    //适应尺寸大小
    CGSize size=[self adapterSizeImageSize:img.size compareSize:kHcdGuideViewBounds.size];
    
    //自适应图片位置，图片可以使任意尺寸，会自动缩放
    cell.imageView.frame=CGRectMake(0, 0, size.width,size.height);
    cell.imageView.image=img;
    cell.imageView.center=CGPointMake(kHcdGuideViewBounds.size.width/2, kHcdGuideViewBounds.size.height/2);
    //判断按钮何时出现
    if(indexPath.row==self.images.count-1){
        [cell.button setHidden:NO];
        [cell.button addTarget:self action:@selector(nextButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [cell.button setBackgroundColor:self.buttonBgColor];
        [cell.button setTitle:self.buttonTitle forState:UIControlStateNormal];
        [cell.button setTitleColor:self.titleColor forState:UIControlStateNormal];
        cell.button.layer.borderColor = [self.buttonBorderColor CGColor];
    }else{
        [cell.button setHidden:YES];
    }
    
    return cell;
}

/**
 *  计算自适应的图片
 *
 *  @param is 需要适应的尺寸
 *  @param cs 适应到的尺寸(即手机尺寸）
 *
 *  @return 适应后的尺寸
 */
- (CGSize)adapterSizeImageSize:(CGSize)is compareSize:(CGSize)cs{
    CGFloat w=cs.width;
    CGFloat h=cs.width/is.width*is.height;
    if(h<cs.height){
        w=cs.height/h*w;
        h=cs.height;
    }
    return CGSizeMake(w, h);
}
//原点随着页面的移动而移动
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = (scrollView.contentOffset.x / kHcdGuideViewBounds.size.width);
}

/**
 *  点击立即体验按钮响应事件
 *
 *  @param sender sender
 */
-(void)nextButtonHandler:(id)sender{
    [self.pageControl removeFromSuperview];
    [self.view removeFromSuperview];
    [self setWindow:nil];
    [self setView:nil];
    [self setPageControl:nil];
}


@end
