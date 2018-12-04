//
//  NNHMyOrderItem.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/7.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderItem.h"

@implementation NNHMyOrderItem

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"orderItemID" : @"productid",
             @"orderItemSpecID" : @"skuid",
             @"orderItemIcon" : @"thumb",
             @"orderItemSpec" : @"skudetail",
             @"orderItemName" : @"productname",
             @"orderItemPrice" : @"prouctprice",
             @"orderItemBullamount" : @"bullamount",
             @"orderItemCount" : @"productnum",
             @"operatingButtons" : @"orderact"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"operatingButtons" : @"NNHMyOrderOperationStatusModel"};
}

@end
