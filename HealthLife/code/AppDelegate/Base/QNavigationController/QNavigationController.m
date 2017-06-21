//
//  QNavigationController.m
//  App
//
//  Created by Yu on 16/2/27.
//  Copyright © 2016年 HangZhou ShuoChuang Technology Co.,Ltd. All rights reserved.
//

#import "QNavigationController.h"
#import "Constant.h"
////显示menu
//#import "MenuTableViewController.h"
//#import "UIViewController+REFrostedViewController.h"

#define AnimationDuration 0.2////动画持续时间

@interface QNavigationController ()
{
    BOOL isAlphaAnimating;
    BOOL isBgColorAnimating;
}

@property(nonatomic, retain)UIView *alphaView;

//@property (strong, readwrite, nonatomic) MenuTableViewController *menuViewController;
@end

@implementation QNavigationController

//--------------------------------------------System----------------------------------------------//

-(id)initWithRootViewController:(UIViewController *)rootViewController
{
    self=[super initWithRootViewController:rootViewController];
    if (self) {
        CGRect frame = self.navigationBar.frame;
        self.alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height+20)];
        self.alphaView.backgroundColor = BAR_TINT_COLOR;
        [self.view insertSubview:self.alphaView belowSubview:self.navigationBar];
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//--------------------------------------------method----------------------------------------------//

-(void)setLineHidden:(BOOL)on
{
    if (on) {
        self.navigationBar.layer.masksToBounds=YES;
    }else{
        self.navigationBar.layer.masksToBounds=NO;
    }
}

-(void)setAlpha:(CGFloat)alpha
{
    if (alpha>=0&&alpha<=1) {
        self.alphaView.alpha = alpha;
    }
}

-(void)setAlpha:(CGFloat)alpha Animation:(BOOL)on Duration:(CGFloat)time
{
    if (!isAlphaAnimating) {
        if (on) {
            isAlphaAnimating = YES;
            [UIView animateWithDuration:time animations:^{
                self.alphaView.alpha = alpha;
            } completion:^(BOOL finished) {
                isAlphaAnimating = NO;
            }];
        }else{
            self.alphaView.alpha=alpha;
        }
    }
}

-(void)setBgColor:(UIColor*)color
{
    if (color) {
        self.alphaView.backgroundColor=color;
    }
}

-(void)setBgColor:(UIColor*)color Animation:(BOOL)on Duration:(CGFloat)time
{
    if (color) {
        if (!isBgColorAnimating) {
            if (on) {
                isBgColorAnimating = YES;
                [UIView animateWithDuration:time animations:^{
                    self.alphaView.backgroundColor=color;
                } completion:^(BOOL finished) {
                    isBgColorAnimating = NO;
                }];
            }else{
                self.alphaView.backgroundColor=color;
            }
        }
    }
}



@end
