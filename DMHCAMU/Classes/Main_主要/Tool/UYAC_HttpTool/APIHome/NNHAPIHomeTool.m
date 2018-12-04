//
//  NNHAPIHomeTool.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAPIHomeTool.h"

@implementation NNHAPIHomeTool

/** 商城首页获取banner图片和快捷方式 */
- (instancetype)initShopPageBannerAndSalewayData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Mall_indexBannerAndSaleway;
        self.reAPIName = @"商城首页获取banner图片和快捷方式";
    }
    return self;
}

/** 商城首页获取公告与活动数据 */
- (instancetype)initShopPageActiveData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Mall_indexAnnounAndActive;
        self.reAPIName = @"商城首页获取公告与活动数据";
    }
    return self;
}

/** 获取首页商品列表数据 */
- (instancetype)initHomeGoodsListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Mall_indexGoodslist;
        self.reAPIName = @"获取首页商品列表";
        self.reParams = @{
                          @"page" : [NSString  stringWithFormat:@"%ld",page],
                          };
    }
    return self;
}

/** 商城搜索商品 */
- (instancetype)initMallGoodsListWithKeywords:(NSString *)keywords
                                          cid:(NSString *)cid
                                         page:(NSInteger)page
                                    priceSort:(NSString *)price_sort
                                    followNum:(NSString *)follow_num
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Product_Search;
        self.reAPIName = @"商城搜索商品";
        NSMutableDictionary *parames = [NSMutableDictionary dictionary];
        
        if (keywords.length) {
            parames[@"keywords"] = keywords;
        }
        
        if (cid.length) {
            parames[@"cid"] = cid;
        }
        
        if (price_sort.length) {
            parames[@"price_sort"] = price_sort;
        }
        
        if (follow_num.length) {
            parames[@"follow_num"] = follow_num;
        }
        
        parames[@"page"] = [NSString stringWithFormat:@"%ld",page];
        
        
        self.reParams = [parames copy];
    }
    return self;
}

/**
 获取搜索商品分类
 */
- (instancetype)initAllGodsCategoryDataWithPage:(NSInteger)page businessID:(NSString *)businessID showAll:(BOOL)showAll
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Mall_indexCategory;
        self.reAPIName = @"获取商品所有分类";
        
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (businessID) {
            params[@"businessid"] = businessID;
        }
        if (showAll) {
            params[@"showall"] = @"1";
        }else {
            params[@"showall"] = @"0";
        }
        self.reParams = [params copy];
    }
    return self;
}

/** 获取搜索关键字及搜索热词 */
- (instancetype)initSearchKeyWordData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"mall.index.mallKeywords";
        self.reAPIName = @"搜索页面获取关键字";
        
        self.reParams = @{
                          @"type" : @"2",
                          };
    }
    return self;
}

- (instancetype)initAdvert
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"Sys.SysAdvert.startupBanner";
        self.reAPIName = @"启动后的商品推广";
    }
    return self;
}

/** 获取新首页商品列表数据 */
- (instancetype)initNewMallGoodsListDataWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"Mall.Mallindex.index";
        self.reAPIName = @"商城首页数据";
        self.reParams = @{
                          @"page" : [NSString  stringWithFormat:@"%ld",page],
                          };
    }
    return self;
}

- (instancetype)initSearchBusinessListDataWithKeyword:(NSString *)keyword page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"business.index.index";
        self.reAPIName = @"店铺列表";
        self.reParams = @{
                          @"businessname" : keyword,
                          @"page"         : [NSString stringWithFormat:@"%zd",page],
                          };
    }
    return self;
}

@end
