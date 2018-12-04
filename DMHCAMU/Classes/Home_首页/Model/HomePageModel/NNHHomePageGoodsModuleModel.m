//
//  NNHHomePageGoodsModuleModel.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageGoodsModuleModel.h"

@implementation NNHHomePageGoodsModuleModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"goodsArray" : @"NNHHomePageGoodsDetailModel",
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"goodsArray" : @"list",
             };
}

- (NNHHomePageModelCellIdentifier)cellIdentifier
{
    return NNHHomePageModelCellIdentifier_NormalGoods;
}

@end
