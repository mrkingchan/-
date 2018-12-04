//
//  NNHStoreCategoryModel.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHStoreCategoryModel.h"

@implementation NNHStoreSonCateModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sonCateID" : @"id",
             };
}

@end


@implementation NNHStoreCategoryModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"sonCateArray" : @"NNHStoreSonCateModel",
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
