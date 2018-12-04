//
//  NNHHomePageGoodsCell.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页 商品cell
 
 @Remarks          cell
 
 *****************************************************/


#import "NNHHomePageBaseCell.h"
@class  NNHHomePageGoodsDetailModel;

@interface NNHHomePageGoodsCell : NNHHomePageBaseCell

/** 商品数据模型 */
@property (nonatomic, strong) NNHHomePageGoodsDetailModel *goodsModel;

@end


