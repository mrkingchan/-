//
//  NNHAPIHomeTool.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHAPIHomeTool : NNHBaseRequest

/** 商城首页获取banner图片和快捷方式 */
- (instancetype)initShopPageBannerAndSalewayData;

/** 商城首页获取公告与活动数据 */
- (instancetype)initShopPageActiveData;

/** 获取首页商品列表数据 */
- (instancetype)initHomeGoodsListDataWithPage:(NSInteger)page;

/** 商城搜索商品 */
- (instancetype)initMallGoodsListWithKeywords:(NSString *)keywords
                                          cid:(NSString *)cid
                                         page:(NSInteger)page
                                   priceSort:(NSString *)price_sort
                                   followNum:(NSString *)follow_num;

/**
 获取搜索商品分类
 */
- (instancetype)initAllGodsCategoryDataWithPage:(NSInteger)page businessID:(NSString *)businessID showAll:(BOOL)showAll;

/** 获取搜索关键字及搜索热词 */
- (instancetype)initSearchKeyWordData;


/** 获取广告 */
- (instancetype)initAdvert;


/** 获取新首页商品列表数据 */
- (instancetype)initNewMallGoodsListDataWithPage:(NSInteger)page;


/**
 关键字搜索店铺

 @param keyword 关键字
 @return api
 */
- (instancetype)initSearchBusinessListDataWithKeyword:(NSString *)keyword page:(NSInteger)page;


@end
