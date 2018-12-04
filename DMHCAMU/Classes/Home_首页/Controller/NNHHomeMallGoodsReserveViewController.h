//
//  NNHHomeMallGoodsReserveViewController.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           商城 商品预定页面
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class NNHMallGoodsDetailModel;

@interface NNHHomeMallGoodsReserveViewController : UIViewController

/** 数据模型 */
@property (nonatomic, strong) NNHMallGoodsDetailModel *goodsModel;

@end

NS_ASSUME_NONNULL_END
