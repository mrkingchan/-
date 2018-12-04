//
//  NNHAPIGoodsTool.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHAPIGoodsTool.h"

@implementation NNHAPIGoodsTool

- (instancetype)initGoodsDetailDataWithGoodsID:(NSString *)goodsID
{
    if (self = [super init]) {
        
        self.reAPIName = @"商品详情";
        self.requestReServiceType = @"product.index.goodsDetail";
        
        if (!goodsID) {
            goodsID = @"";
        }
        
        self.reParams = @{@"goodsid":goodsID};
        
    }
    return self;
}

@end
