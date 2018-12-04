//
//  NNHAPIGoodsTool.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function         商品相关 接口 api
 
 @Remarks          controller
 
 *****************************************************/

#import "NNHBaseRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNHAPIGoodsTool : NNHBaseRequest


/**
 获取商品详情

 @param goodsID 商品id
 @return api
 */
- (instancetype)initGoodsDetailDataWithGoodsID:(NSString *)goodsID;

@end

NS_ASSUME_NONNULL_END
