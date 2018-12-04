//
//  NNHAllGoodsCategoryModel.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAllGoodsCategoryModel.h"

@implementation NNHAllGoodsCategoryModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"sonCateArray" : @"NNHAllGoodsCategoryModel",
             };
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"categoryID"      : @"id",
             @"sonCateArray"    : @"sonCate",
             };
}

@end
