//
//  NNHHomePageGoodsDetailModel.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NNHHomePageGoodsDetailModel : NSObject


/** 商品id*/
@property (nonatomic, copy) NSString *productid;
/** 商品id*/
@property (nonatomic, copy) NSString *goodsID;
/** 商品名称 */
@property (nonatomic, copy) NSString *productname;
/** 商品缩略图 */
@property (nonatomic, copy) NSString *thumb;
/** 商品价格 */
@property (nonatomic, copy) NSString *prouctprice;
/** 商品牛贝 */
@property (nonatomic, copy) NSString *bullamount;
/** 市场价 */
@property (nonatomic, copy) NSString *marketprice;
/** 赠送奖励金 */
@property (nonatomic, copy) NSString *give_profitamount;
/** 赠送奖励金豆 */
@property (nonatomic, copy) NSString *give_bullamount;
/** 销量 */
@property (nonatomic, copy) NSString *salecount;
/** cell标识 A是大图Cell C是两行Cell */
@property (nonatomic, copy) NSString *liststyle;
/** 赠送佣金 */
@property (nonatomic, copy) NSString *brokpricestr;
/** 积分 */
@property (nonatomic, copy) NSString *tcostr;


@end

