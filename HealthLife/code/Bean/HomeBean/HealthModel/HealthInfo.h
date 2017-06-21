//
//  HealthInfo.h
//  HealthLife
//
//  Created by Espero on 2017/6/20.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HealthInfo : NSObject
//资讯标题
@property(retain,nonatomic) NSString *nTitle;
//图片地址
@property(retain,nonatomic) NSString *nImageURL;
//发布时间
@property(retain,nonatomic)NSString *nTime;
//健康资讯的ID
@property(retain,nonatomic)NSString* nID;
//资讯的关键字
@property(retain,nonatomic)NSString *nKeyWords;
@end
