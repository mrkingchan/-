//
//  NNHHomePageBannerModel.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageBannerModel.h"
#import "NNHBannerModel.h"

@implementation NNHHomePageBannerModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"bannerArray"         : @"banner",
             @"entranceArray"       : @"saleWay",
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bannerArray"         : @"NNHBannerModel",
             @"entranceArray"       : @"NNHBannerModel",
             };
}


- (NNHHomePageModelCellIdentifier)cellIdentifier
{
    return NNHHomePageModelCellIdentifier_Banner;
}

@end
