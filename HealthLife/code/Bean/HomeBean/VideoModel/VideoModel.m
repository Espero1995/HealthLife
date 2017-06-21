//
//  VideoModel.m
//  cell情况下播放视频
//
//  Created by Espero on 2017/6/8.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel
+ (instancetype)initWithDic:(NSDictionary *)dict
{
    VideoModel *model = [[self alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
