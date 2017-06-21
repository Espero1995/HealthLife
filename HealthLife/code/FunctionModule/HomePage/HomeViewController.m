//
//  HomeViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "HomeViewController.h"



@interface HomeViewController (){
    
         NSInteger currentIndex;//当前标签;1->健康咨询;2->视频;3->厨艺
    //    创建数据源对象
    
        //健康资讯数组
        NSMutableArray *publicArr;
        //存放视频的数组
        NSMutableArray *videoModelArray;
        //存放菜谱类型的数组
        NSMutableArray *menuArr;

}


@property (weak, nonatomic) IBOutlet UITableView *homeTable;
//轮播图
@property (strong, nonatomic) IBOutlet SDCycleScrollView *v_head;
//滑动块
@property (strong, nonatomic) IBOutlet UIView *v_tabbar;
//健康咨询
@property (weak, nonatomic) IBOutlet UIView *v_public;
@property (weak, nonatomic) IBOutlet UILabel *lab_public;
//视频
@property (weak, nonatomic) IBOutlet UIView *video;
@property (weak, nonatomic) IBOutlet UILabel *lab_video;

//视频播放要的组件
@property (strong, nonatomic) NSMutableDictionary *heights;//cell的高度
@property (nonatomic, strong)  WMPlayer *wmPlayer;//一个封装好的类
@property (nonatomic, assign)  NSIndexPath *currentIndexPath;//当前行
@property (nonatomic,retain) VideoCellTableViewCell *currentCell;//当前的cell

//厨艺
@property (weak, nonatomic) IBOutlet UIView *cook;
@property (weak, nonatomic) IBOutlet UILabel *lab_cook;


@property ( nonatomic) UIView *v_indicator;//底部游标

@end

@implementation HomeViewController
//------------------------------------system------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //必须初始化
    publicArr=[[NSMutableArray alloc] initWithCapacity:0];
//    [self pressLoad];
    
    //必须初始化
//    videoModelArray=[[NSMutableArray alloc] initWithCapacity:0];
    //必须初始化
    menuArr=[[NSMutableArray alloc] initWithCapacity:0];
    [self pressLoadMenu];
    
    
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoDidFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    //注册播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fullScreenBtnClick:) name:@"fullScreenBtnClickNotice" object:nil];
    //关闭通知
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(closeTheVideo:)
                                                 name:@"closeTheVideo"
                                               object:nil
     ];
    
    
    
    //游标
    currentIndex=1;
    //将表示图的headview作为轮播图
    self.homeTable.tableHeaderView=self.v_head;
    
    
    //给三个滑块添加动作
    [self.v_public addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabbar_click:)]];
    [self.video addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabbar_click:)]];
    [self.cook addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabbar_click:)]];
    
    self.v_indicator=[[UIView alloc] initWithFrame:CGRectMake(0, 42, S_WIDTH/3, 2)];
    self.v_indicator.backgroundColor=MAIN_TONE_COLOR;
    [self.v_tabbar addSubview:self.v_indicator];

    
    NSArray *titles = @[@"新建交流QQ群：185534916 ",
                        @"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com"
                        ];
    NSArray *imageNames = @[@"h1.jpg",
                            @"h2.jpg",
                            @"h3.jpg",// 本地图片请填写全名
                            ];
    /** 分页控件位置 */
    self.v_head.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.v_head.delegate = self;//轮播图协议
    self.v_head.currentPageDotColor = MAIN_TONE_COLOR;//自定义分页控件小圆标颜色
    self.v_head.titlesGroup=titles;
    self.v_head.imageURLStringsGroup=imageNames;
    
    
    //下拉刷新
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownMethod)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    self.homeTable.mj_header = header;
    self.homeTable.showsVerticalScrollIndicator=NO;
    
}
//设置页面的导航栏为默认
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setDefaultNavigationBarStyle];
    ((QNavigationController*)self.navigationController).navigationBar.hidden=NO;
}


//------------------------------------method------------------------------------
///导航栏点击事件
-(void)tabbar_click:(UITapGestureRecognizer*)g
{
    
    [self.homeTable.mj_footer resetNoMoreData];
    
    UIView *view=g.view;
    
    currentIndex=view.tag;
    
//    NSLog(@"打印下当前的tag值：%ld",(long)view.tag);
    
    UIColor *color1=[UIColor lightGrayColor];
    UIColor *color2=[UIColor lightGrayColor];
    UIColor *color3=[UIColor lightGrayColor];
    
    if (view.tag==1) {
        if (publicArr.count==0) {
            [self.homeTable.mj_header beginRefreshing];
        }
        color1=MAIN_TONE_COLOR;
    }else if (view.tag==2) {
        if (videoModelArray.count==0) {
            [self.homeTable.mj_header beginRefreshing];
        }
        color2=MAIN_TONE_COLOR;
    }else if (view.tag==3) {
        if (menuArr.count==0) {
            [self.homeTable.mj_header beginRefreshing];
        }
        color3=MAIN_TONE_COLOR;
    }
    
    self.lab_public.textColor=color1;
    self.lab_video.textColor=color2;
    self.lab_cook.textColor=color3;
    
    CGRect frame=CGRectMake(S_WIDTH/3*(view.tag-1), 42, S_WIDTH/3, 2);
    [UIView animateWithDuration:0.2 animations:^{
        self.v_indicator.frame=frame;
    }];
    
    [self.homeTable reloadData];
}

//下拉刷新
- (void)pullDownMethod{
    if (currentIndex==1) {
//        [self pressLoad];
    }else if (currentIndex==2){
        [self loadDatas];
    }else if(currentIndex==3){
        [self pressLoadMenu];
    }
}


//健康咨询method============================================
-(void) pressLoad{
    [self loadData];
}

//下载数据
-(void)loadData{
    //获取AFHTTPSession对象，下载网络数据
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"http://japi.juhe.cn/health_knowledge/infoList?key=%@",KEY_HEALTH];
    
    //下载网络数据
    [session GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSLog(@"下载成功321！");
        [self parseData:responseObject];
        //        NSLog(@"字典源：%@",responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"下载失败！");
    }];
    
}

//解析数据
-(void)parseData:(NSDictionary *)dic{
    
    NSDictionary *result=[dic objectForKey:@"result"];
    //    NSLog(@"打印看看结果:%@",result);
    
    NSArray *arrData=[result objectForKey:@"data"];
    //    NSLog(@"再剥了一层看看：%@",arrData);
    
    
    for (NSDictionary *dicList in arrData) {
        
        HealthInfo *h=[[HealthInfo alloc]init];
        
        NSString *strTitle=[dicList objectForKey:@"title"];
        //        NSLog(@"biaoti:%@",strTitle);
        //        NSString *img=[dicList objectForKey:@"img"];
        //        NSString *imgURL=[NSString stringWithFormat:@"%@%@",URL,img];
        NSString *imgURL=[dicList objectForKey:@"img"];
        //        NSLog(@"图片的URL地址：%@",imgURL);
        //传id
        NSNumber *nid1=[dicList objectForKey:@"id"];
        //        NSLog(@"打印下id：%@",nid1);
        NSString *Stringid = [NSString stringWithFormat:@"%@",nid1];
        
        NSString *keyWords=[dicList objectForKey:@"keywords"];
        //        NSLog(@"关键字：%@",keyWords);
        //拿时间
        double timestampval =  [[dicList objectForKey:@"time"] doubleValue]/1000;
        NSTimeInterval timestamp = (NSTimeInterval)timestampval;
        NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970:timestamp];
        
        //        NSLog(@"打印下发布时间;%@",updatetimestamp);
        //赋值
        h.nTitle=strTitle;
        h.nImageURL=imgURL;
        h.nID=Stringid;
        h.nKeyWords=keyWords;
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];
        formater.timeZone = [NSTimeZone systemTimeZone];//无效
        [formater setDateFormat:@"MM-dd hh:mm:ss"];
        NSString *timestr = [formater stringFromDate:updatetimestamp];
        
        h.nTime=timestr;
        [publicArr addObject:h];
        
    }
    [self.homeTable reloadData];
}


//健康咨询method============================================



//视频播放method============================================
- (NSMutableArray *)videoModelArray
{
    if (!videoModelArray) {
        videoModelArray = [NSMutableArray array];
    }
    return videoModelArray;
}

- (NSMutableDictionary *)heights
{
    if (!_heights) {
        _heights = [NSMutableDictionary dictionary];
    }
    return _heights;
}

#pragma mark - 加载数据，从json里获取
- (void)loadDatas
{
    //异步刷新数据，
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shipin" ofType:@"json"];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //                NSLog(@"json = %@",json);
        
        NSDictionary *datas = json[@"datas"];
        
        NSArray *listArray = datas[@"article_list"];
        //如果数据已经加载了那就停止刷新就好了
        if ([self.homeTable.mj_header isRefreshing]) {
            [self.homeTable.mj_header endRefreshing];
        }
        
        //遍历listArray，将获取的数据给videoModelArray数组，从json中获取的视频个数
        for (NSDictionary *dict in listArray) {
            VideoModel *model = [VideoModel initWithDic:dict];
            [self.videoModelArray addObject:model];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeTable reloadData];//table加载数据显示出来
        });
    });
    
    
}


//视频播放method============================================



//菜谱method============================================
//加载新的数据刷新显示的视图
-(void) pressLoadMenu{
    [self loadDataMenu];
}

//下载数据
-(void)loadDataMenu{
    //获取AFHTTPSession对象，下载网络数据
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"http://apis.juhe.cn/cook/category?key=%@",MENU];
    
    //下载网络数据
    [session GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        NSLog(@"下载成功123！");
        [self parseDataMenu:responseObject];
        //        NSLog(@"字典源：%@",responseObject);
        //如果数据已经加载了那就停止刷新就好了
        if ([self.homeTable.mj_header isRefreshing]) {
            [self.homeTable.mj_header endRefreshing];
        }
        
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"下载失败！");
    }];
    
}

//解析数据
-(void)parseDataMenu:(NSDictionary *)dic{
    NSArray *result=[dic objectForKey:@"result"];
    //    NSLog(@"打印看看结果:%@",result);
    
    
    for (NSDictionary *list in result) {
        //        NSLog(@"字典内容是：%@",list);
        
        NSArray *listArr=[list objectForKey:@"list"];
        for (NSDictionary *detail in listArr) {
            //                            NSLog(@"字典内容是：%@",detail);
            
            //                 news *n=[[news alloc] init];
            MenuList *list=[[MenuList alloc]init];
            
            list.mName=[detail objectForKey:@"name"];
            list.mID=[detail objectForKey:@"id"];
            [menuArr addObject:list];
            
        }
    }
    [self.homeTable reloadData];
}

//菜谱method============================================

//------------------------------------delegate------------------------------------
#pragma mark UITableView Delegate

////返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if (currentIndex==1) {
        return publicArr.count;
    }else if(currentIndex==2){
        return self.videoModelArray.count;
    }else{
        return menuArr.count;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.v_tabbar;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(currentIndex==1){
        return 150;
    }else if(currentIndex==2){
        return [self.heights[@(indexPath.row)] doubleValue];
    }else{
        return 44;
    }
}


#pragma mark -
#pragma mark UITableView Datasource
//创建并设置每行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (currentIndex==1) {
        static NSString *CellIdentifier=@"CellIdentifier";
        rootTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell==nil) {
            [tableView registerNib:[UINib nibWithNibName:@"rootTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
            cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        }
        HealthInfo *h=[publicArr objectAtIndex:indexPath.row];
        [cell.lv_image sd_setImageWithURL:[NSURL URLWithString:h.nImageURL]];
        cell.lab_title.text=h.nTitle;
        cell.lab_time.text=h.nTime;
        cell.lab_keywords.text=h.nKeyWords;
        
        return cell ;

    }
    if (currentIndex==2) {
        VideoCellTableViewCell *cell = [VideoCellTableViewCell cellWithTableView:tableView];
        cell.model = self.videoModelArray[indexPath.row];
        //定义cell高度
        CGFloat tmpHeight = [cell cellHeight];
        [self.heights setObject:@(tmpHeight) forKey:@(indexPath.row)];
        //为cell里的播放按钮设置动作消息
        [cell.playBtn addTarget:self action:@selector(startPlayVideo:) forControlEvents:UIControlEventTouchUpInside];
        //设置标志位，确定所按的是哪个按钮，传值
        cell.playBtn.tag = indexPath.row;
        
        if (self.wmPlayer&&self.wmPlayer.superview) {
            if (indexPath.row==_currentIndexPath.row) {
                [cell.playBtn.superview sendSubviewToBack:cell.playBtn];
            }else{
                [cell.playBtn.superview bringSubviewToFront:cell.playBtn];
            }
            NSArray *indexpaths = [tableView indexPathsForVisibleRows];
            if (![indexpaths containsObject:_currentIndexPath]) {//复用
                
                if ([[UIApplication sharedApplication].keyWindow.subviews containsObject:self.wmPlayer]) {
                    self.wmPlayer.hidden = NO;
                    
                }else{
                    self.wmPlayer.hidden = YES;
                }
            }else{
                if ([cell.subviews containsObject:self.wmPlayer]) {
                    [cell addSubview:self.wmPlayer];
                    
                    [self.wmPlayer play];
                    self.wmPlayer.hidden = NO;
                }
                
            }
        }
        return cell;
    }else{
        MenuList *n=menuArr[indexPath.row];
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=n.mName;
        return cell ;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (currentIndex==1) {
        HealthInfo *h=publicArr[indexPath.row];
        //进入具体的内容
        HealthDetailViewController *detail=[[HealthDetailViewController alloc]init];
        detail.Did=h.nID;
        [self.navigationController pushViewController:detail animated:YES];
    }else if(currentIndex==2){
        NSLog(@"点击按钮了");
    }else{
        MenuList *n=menuArr[indexPath.row];
        SecondMenuViewController *second=[[SecondMenuViewController alloc]init];
        second.id=n.mID;
        [self.navigationController pushViewController:second animated:YES];
    }
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    if(index==0){
        NSLog(@"进入第一个页面内容");
    }else if(index==1){
        NSLog(@"进入第二个页面内容");
    }else{
        NSLog(@"进入第三个页面内容");
    }
    
}


#pragma mark - 通知
//播放完成通知
- (void)videoDidFinished:(NSNotification *)notice{
    VideoCellTableViewCell *currentCell = (VideoCellTableViewCell *)[self.homeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [_wmPlayer removeFromSuperview];
}

//播放完成通知
- (void)fullScreenBtnClick:(NSNotification *)notice{
    
}


//关闭通知
-(void)closeTheVideo:(NSNotification *)obj{
    VideoCellTableViewCell *currentCell = (VideoCellTableViewCell *)[self.homeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
    [currentCell.playBtn.superview bringSubviewToFront:currentCell.playBtn];
    [self releaseWMPlayer];
    //    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:YES];
    [self prefersStatusBarHidden];//隐藏状态栏
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}






#pragma mark - 内部方法
-(void)releaseWMPlayer{
    [self.wmPlayer pause];//暂停功能
    
    
    [self.wmPlayer removeFromSuperview];
    [self.wmPlayer.playerLayer removeFromSuperlayer];//创建播放器层
    [self.wmPlayer.player replaceCurrentItemWithPlayerItem:nil];
    self.wmPlayer.player = nil;
    self.wmPlayer.currentItem = nil;
    //释放定时器，否侧不会调用self.wmPlayer中的dealloc方法
    [self.wmPlayer.autoDismissTimer invalidate];
    self.wmPlayer.autoDismissTimer = nil;
    
    self.wmPlayer.playOrPauseBtn = nil;
    self.wmPlayer.playerLayer = nil;
    self.wmPlayer = nil;
}

//点击播放
-(void)startPlayVideo:(UIButton *)sender{
    _currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    if ([UIDevice currentDevice].systemVersion.floatValue>=8||[UIDevice currentDevice].systemVersion.floatValue<7) {
        //        self.currentCell = (VideoCell *)sender.superview.superview.superview;
        self.currentCell = (VideoCellTableViewCell *)[self.homeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_currentIndexPath.row inSection:0]];
        
    }else{//ios7系统 UITableViewCell上多了一个层级UITableViewCellScrollView
        self.currentCell = (VideoCellTableViewCell *)sender.superview.superview.subviews;
    }
    VideoModel *model = [videoModelArray objectAtIndex:sender.tag];
    
    if (self.wmPlayer) {
        [self releaseWMPlayer];
        self.wmPlayer = [[WMPlayer alloc]init];
        self.wmPlayer.delegate = self;
        self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.wmPlayer.URLString = model.article_video;
        self.wmPlayer.titleLabel.text = model.article_title;
    }else{
        self.wmPlayer = [[WMPlayer alloc]init];
        self.wmPlayer.delegate =self;
        self.wmPlayer.closeBtnStyle = CloseBtnStyleClose;
        self.wmPlayer.URLString = model.article_video;
        self.wmPlayer.titleLabel.text = model.article_title;
    }
    //    self.wmPlayer.frame = CGRectMake(0, 200, ScreenWidth, 200);
    //    [self.view addSubview:self.wmPlayer];
    
//    NSLog(@"----%@",NSStringFromCGRect(self.currentCell.frame));
    //    self.wmPlayer.frame = self.currentCell.coverView.frame;
    [self.currentCell addSubview:self.wmPlayer];
    [self.currentCell bringSubviewToFront:self.wmPlayer];
    [self.currentCell.playBtn.superview sendSubviewToBack:self.currentCell.playBtn];
    [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.currentCell).with.offset(0);
        make.left.equalTo(self.currentCell).with.offset(0);
        make.right.equalTo(self.currentCell).with.offset(0);
        make.height.equalTo(@(self.currentCell.coverView.frame.size.height));
    }];
//    NSLog(@"----%@",NSStringFromCGRect(self.wmPlayer.frame));
    [self.wmPlayer play];
    //    [self.tableView reloadData];
    
}


-(void)dealloc{
//    NSLog(@"%@ dealloc",[self class]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releaseWMPlayer];
}

@end
