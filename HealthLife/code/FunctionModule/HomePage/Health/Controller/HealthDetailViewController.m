//
//  HealthDetailViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "HealthDetailViewController.h"

@interface HealthDetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation HealthDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"dayinxia:ID：%@",self.id);
    self.title=@"详细资讯";
    [self pressLoadDetail];
}

//----------------------------------------method---------------------------------------
//加载新的数据刷新显示的视图
-(void) pressLoadDetail{
    [self loadDataDetail];
}


//下载数据
-(void)loadDataDetail{
    //获取AFHTTPSession对象，下载网络数据
    AFHTTPSessionManager *session=[AFHTTPSessionManager manager];
    NSString *path=[NSString stringWithFormat:@"http://japi.juhe.cn/health_knowledge/infoDetail?id=%@&key=%@",self.Did,KEY_HEALTH];
    
    //下载网络数据
    [session GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * task, id responseObject) {
        //        NSLog(@"下载成功！");
        [self parseDataDetail:responseObject];
        //        NSLog(@"字典源：%@",responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError * error) {
        NSLog(@"下载失败！");
    }];
    
}
//解析数据
-(void)parseDataDetail:(NSDictionary *)dic{
    //    NSString *dtitle=[dic objectForKey:@"title"];
    //    NSLog(@"标题是：%@",dtitle);
    NSDictionary *result=[dic objectForKey:@"result"];
    
    NSString *message=[result objectForKey:@"message"];
    //    NSLog(@"message:%@",message);
    //    NSString *strHTML = message;
    
    
    NSString *htmls=[NSString stringWithFormat:@"<html> \n"
                     "<head> \n"
                     "<style type=\"text/css\"> \n"
                     "body {font-size:15px;}\n"
                     "</style> \n"
                     "</head> \n"
                     "<body>"
                     "<script type='text/javascript'>"
                     "window.onload = function(){\n"
                     "var $img = document.getElementsByTagName('img');\n"
                     "for(var p in  $img){\n"
                     " $img[p].style.width = '100%%';\n"
                     "$img[p].style.height ='auto'\n"
                     "}\n"
                     "}"
                     "</script>%@"
                     "</body>"
                     "</html>",message];
    
    NSString *sun=[NSString stringWithFormat:@"%@\n大家好才是真的好广州好迪！！！",htmls];
    
    [self.webview  loadHTMLString:sun baseURL:nil];
    
}

@end
