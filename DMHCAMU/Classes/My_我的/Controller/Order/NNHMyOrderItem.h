//
//  NNHMyOrderItem.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/7.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NNHMyOrderOperationStatusModel;

@interface NNHMyOrderItem : NSObject

/** 商品id */
@property (nonatomic, copy) NSString *orderItemID;
/** 商品规格id */
@property (nonatomic, copy) NSString *orderItemSpecID;
/** 商品名 */
@property (nonatomic, copy) NSString *orderItemName;
/** 商品头像 */
@property (nonatomic, copy) NSString *orderItemIcon;
/** 订单交易价格 */
@property (nonatomic, copy) NSString *orderItemPrice;
/** 订单交易牛币数 */
@property (nonatomic, copy) NSString *orderItemBullamount;
/** 商品数量 */
@property (nonatomic, assign) NSInteger orderItemCount;
/** 商品规格 */
@property (nonatomic, copy) NSString *orderItemSpec;
/** 商品操作按钮(售后／退款等) */
@property (nonatomic, strong) NSArray <NNHMyOrderOperationStatusModel *> *operatingButtons;

// 退款列表需要的
/** 商品退款价格 */
@property (nonatomic, copy) NSString *returnamount;
/** 商品退款牛贝 */
@property (nonatomic, copy) NSString *returnbull;
/** 商品单价钱数 */
@property (nonatomic, copy) NSString *productamount;
/** 商品单价牛币 */
@property (nonatomic, copy) NSString *productbull ;

@end
