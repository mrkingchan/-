//
//  NNHMallGoodsDetailHeaderView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页 商品详情页 头部info
 
 @Remarks          cell
 
 *****************************************************/

#import <UIKit/UIKit.h>
@class NNHMallGoodsDetailModel;

NS_ASSUME_NONNULL_BEGIN

@interface NNHMallGoodsDetailHeaderView : UIView

/** 商品数据 */
@property (nonatomic, strong) NNHMallGoodsDetailModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
