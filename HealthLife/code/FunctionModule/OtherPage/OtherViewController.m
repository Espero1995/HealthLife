//
//  OtherViewController.m
//  HealthLife
//
//  Created by Espero on 2017/6/11.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "OtherViewController.h"
#import "AboutusViewController.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self haha];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (IBAction)setting:(id)sender {
    AboutusViewController *us=[[AboutusViewController alloc]init];
//    [self.navigationController pushViewController:us animated:YES];
    [self presentViewController:us animated:YES completion:nil];
}

-(void)haha{
    NSLog(@"我是第三个页面");
}
@end
