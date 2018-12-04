//
//  NNHShopIndexCategoryCollectionCell.h
//  ZTHYMall
//
//  Created by 来旭磊 on 17/4/5.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           商城首页点击分类页面cell 
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
@class NNHAllGoodsCategoryModel;


@interface NNHShopIndexCategoryCollectionCell : UICollectionViewCell

/** 首页商品类别模型 */
@property (nonatomic, strong) NNHAllGoodsCategoryModel *goodsCateModel;

@end
