//
//  NNHMallGoodsDetailModel.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/23.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           商城 商品详情页 商品模型
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNHMallGoodsDetailModel : NSObject

/** 商品id */
@property (nonatomic, copy) NSString *goodsID;

/** 分类id */
@property (nonatomic, copy) NSString *categoryid;

/** 商品名称 */
@property (nonatomic, copy) NSString *productname;

/** 商品价格 */
@property (nonatomic, copy) NSString *prouctprice;

/** 关注人数 */
@property (nonatomic, copy) NSString *follow_num;

/** 商品缩略图 */
@property (nonatomic, copy) NSString *thumb;

/** 图文详情链接 */
@property (nonatomic, copy) NSString *detailInfo;

/** 轮播图数组 */
@property (nonatomic, copy) NSArray *bannerimg;

/** 轮播图数组 */
@property (nonatomic, copy) NSString *iscollect;

/** 是否被购买 0否1是 */
@property (nonatomic, copy) NSString *is_cat;

/** 咨询电话 */
@property (nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
