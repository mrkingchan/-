//
//  NNHUserCollectionModel.m
//  ZTHYMall
//
//  Created by 牛牛汇 on 2017/5/20.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyCollectionModel.h"

@implementation NNHMyCollectionModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"collectionID" : @"id",
             };
}

@end
