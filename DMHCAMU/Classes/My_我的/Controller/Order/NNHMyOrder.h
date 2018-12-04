//
//  NNHMyOrder.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NNHMyOrderItem, NNHMyOrderOperationStatusModel;

#pragma mark - 订单状态
@interface NNHMyOrderStatusModel : NSObject

/** 订单状态 */
@property (nonatomic, copy) NSString *statusstr;
/** 订单详细（时间等） */
@property (nonatomic, copy) NSString *statusinfo;

@end

#pragma mark - 收货地址
@interface NNHMyOrderAdressModel : NSObject

/** 收货人 */
@property (nonatomic, copy) NSString *receive_user;
/** 收货电话 */
@property (nonatomic, copy) NSString *receive_mobile;
/** 城市 */
@property (nonatomic, copy) NSString *city;
/** 详细地址 */
@property (nonatomic, copy) NSString *address;
/** 拼接地址 */
@property (nonatomic, copy) NSString *receive_address;
/** 物流公司名 */
@property (nonatomic, copy) NSString *express_name;
/** 物流单号 */
@property (nonatomic, copy) NSString *express_no;
/** 收货人身份证号码 */
@property (nonatomic, copy) NSString *idnumber;

@end


@interface NNHMyOrder : NSObject

/** 订单ID */
@property (nonatomic, copy) NSString *orderID;
/** 订单编号 */
@property (nonatomic, copy) NSString *orderno;
/** 用户id */
@property (nonatomic, copy) NSString *customerid;
/** 商家ID */
@property (nonatomic, copy) NSString *businessid;
/** 商家名 */
@property (nonatomic, copy) NSString *businessname;
/** 订单状态 */
@property (nonatomic, copy) NSString *orderStatus;
/** 订单列表订单状态文字，辅助属性 */
@property (nonatomic, copy) NSString *orderStatusText;
/** 订单操作按钮 */
@property (nonatomic, strong) NSArray <NNHMyOrderOperationStatusModel *> *orderOperationButtons;
/** 商品总数量 */
@property (nonatomic, copy) NSString *productcount;
/** 商品总金额 */
@property (nonatomic, copy) NSString *productamount;
/** 商品总牛币数 */
@property (nonatomic, copy) NSString *bullamount;
/** 订单总金额=实际运费+商品总金额 */
@property (nonatomic, copy) NSString *totalamount;
/** 实际运费 */
@property (nonatomic, copy) NSString *actualfreight;
/** 订单商品 */
@property (nonatomic, strong) NSArray <NNHMyOrderItem *> *orderGoods;


#pragma mark - 订单详情
/** 商家电话 */
@property (nonatomic, strong) NSArray *businessServices;
/** 订单状态 */
@property (nonatomic, strong) NNHMyOrderStatusModel *orderStatusModel;
/** 收货地址 */
@property (nonatomic, strong) NNHMyOrderAdressModel *adressModel;
/** 退款状态状态 */
@property (nonatomic, copy) NSString *return_status;
/** 订单时间 */
@property (nonatomic, copy) NSString *orderTime;
/** 付款时间 */
@property (nonatomic, copy) NSString *paytime;
/** 订单完结时间 */
@property (nonatomic, copy) NSString *overtime;
/** 发货时间 */
@property (nonatomic, copy) NSString *delivertime;
/** 成交时间 */
@property (nonatomic, copy) NSString *confirm_time;
/** 旅游商品赠送nbtc的uid */
@property (nonatomic, copy) NSString *nbtcuid;
/** 是否是旅游商品 */
@property (nonatomic, copy) NSString *isnbtc;
/** 显示标题 */
@property (nonatomic, copy) NSString *nbtctitle;

/** 积分抵扣 */
@property (nonatomic, copy) NSString *isdeductemall;
@property (nonatomic, copy) NSString *deductemall;

#pragma mark --
#pragma mark -- 辅助属性
/** 详情头部view的高度（提示view + 物流view + 收货地址view） */
@property (nonatomic, assign, readonly) CGFloat headerViewHeight;
/** 详情头部view  收货地址的高度 */
@property (nonatomic, assign, readonly) CGFloat receivingInformationViewH;
/** 详情尾部view的高度（订单价格信息view + 付款view + 服务view） */
@property (nonatomic, assign, readonly) CGFloat sectionFooterViewHeight;

@end
