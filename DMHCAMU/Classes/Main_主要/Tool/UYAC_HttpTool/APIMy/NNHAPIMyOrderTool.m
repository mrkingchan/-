//
//  NNHAPIMyOrderTool.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/18.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNHAPIMyOrderTool.h"

@implementation NNHAPIMyOrderTool

- (instancetype)initWithOrderToolbarType:(NSInteger)type page:(NSInteger)page
{
    if (self = [super init]) {
        
        self.reAPIName = @"我的订单列表";
        self.requestReServiceType = NNH_API_Order_List;
        
        if (!type) {
            type = 1;
        }
        
        self.reParams = @{
                          @"orderlisttype":[NSString stringWithFormat:@"%zd",type],
                          @"page":[NSString stringWithFormat:@"%zd",page]
                          };
        
    }
    return self;
}


- (instancetype)initWithOrderNumber:(NSString *)number
{
    if (self = [super init]) {
        
        self.reAPIName = @"订单详情";
        self.requestReServiceType = NNH_API_Order_orderDetail;
        
        if (!number) {
            number = @"";
        }
        
        self.reParams = @{ @"orderno":number };
        
    }
    return self;
}

@end
