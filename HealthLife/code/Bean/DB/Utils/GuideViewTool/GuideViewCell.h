//
//  GuideViewCell.h
//  GuideView
//
//  Created by Espero on 2017/5/24.
//  Copyright © 2017年 Espero. All rights reserved.
//
#define kHcdGuideViewBounds [UIScreen mainScreen].bounds
#import <UIKit/UIKit.h>

static NSString *kCellIdentifier_GuideViewCell=@"GuideViewCell";

@interface GuideViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *button;
@end
