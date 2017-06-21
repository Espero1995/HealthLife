//
//  MenuDetail.h
//  HealthLife
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuDetail : NSObject
//菜单名
@property(retain,nonatomic) NSString *mMenuName;
//图片
@property(retain,nonatomic) NSString *mMenuPic;
//标签
@property(retain,nonatomic) NSString *mTag;
//图片地址
@property(retain,nonatomic) NSString *mImageURL;

//菜单的佐料
@property(retain,nonatomic) NSString *mBurden;
//菜单的原料
@property(retain,nonatomic) NSString *mIngredients;

//烹制的步骤
@property NSArray *mSteps;
@end
