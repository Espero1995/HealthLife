//
//  VideoModel.h
//  cell情况下播放视频
//
//  Created by Espero on 2017/6/8.
//  Copyright © 2017年 Espero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic, strong) NSString *article_title;
@property (nonatomic, strong) NSString *article_video;
@property (nonatomic, strong) NSString *article_image;
@property (nonatomic, strong) NSString *article_abstract;
@property (nonatomic, strong) NSString *video_length;

+ (instancetype)initWithDic:(NSDictionary *)dict;
@end
