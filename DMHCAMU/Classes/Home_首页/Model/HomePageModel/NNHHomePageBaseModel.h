//
//  NNHHomePageBaseModel.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NNHHomePageGoodsDetailModel;

@interface NNHHomePageBaseModel : NSObject

/** cell标识符 */
@property (nonatomic, assign) NNHHomePageModelCellIdentifier cellIdentifier;

/** 商品数组 */
@property (nonatomic, strong) NSMutableArray <NNHHomePageGoodsDetailModel *>*goodsArray;

/** banner数组 */
@property (nonatomic, strong) NSMutableArray <NNHBannerModel *>*bannerArray;

/** 模块名称 */
@property (nonatomic, copy) NSString *modulename;

@end


