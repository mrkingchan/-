//
//  NNHAPIMyOrderTool.h
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/18.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHAPIMyOrderTool : NNHBaseRequest

// 订单列表
- (instancetype)initWithOrderToolbarType:(NSInteger)type page:(NSInteger)page;

// 订单详情
- (instancetype)initWithOrderNumber:(NSString *)number;

@end
