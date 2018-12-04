//
//  NNHHomePageModuleModel.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/22.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageModuleModel.h"
#import "NNHBannerModel.h"

@implementation NNHHomePageModuleModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"moduleID"    : @"id",
             @"bannerArray" :  @"banner",
             
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"bannerArray" : @"NNHBannerModel",
             };
}

- (NNHHomePageModelCellIdentifier)cellIdentifier
{
    if ([self.modulecode isEqualToString:@"threeethum"]) {
        return NNHHomePageModelCellIdentifier_Entrance;
    }else {
        return NNHHomePageModelCellIdentifier_Default;
    }
}

@end
