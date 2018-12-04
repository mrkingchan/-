//
//  NNHBannerModel.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/10.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBannerModel.h"

@implementation NNHBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bannerID"      : @"id",
             @"bannerName"    : @"bname",
             @"bannerThumb"    : @"thumb",
             @"bannerUrltype"    : @"urltype",
             @"bannerUrl"    : @"url",
             @"bannerAddtime"    : @"addtime",
             @"bannerSort"    : @"sort",
             };
}

@end
