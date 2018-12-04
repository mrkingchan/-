//
//  NNHGoodsModel.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHShareModel.h"

@implementation NNHShareModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"share_title" : @"title",
             @"share_content" : @"description",
             @"share_image" : @"image",
             @"share_url" : @"url"
             };
}

@end
