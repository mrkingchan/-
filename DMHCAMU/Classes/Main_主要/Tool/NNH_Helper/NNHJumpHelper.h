//
//  NNHJumpHelper.h
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/4/13.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

typedef NS_ENUM(NSInteger, NNHJumpType) {
    NNHJumpType_Banner_GoodsDetail = 1,             //商品详情
    NNHJumpType_Banner_ExternalUrl = 2,             //外部H5连接
    NNHJumpType_Banner_StoreDetail = 3,             //实体店详情
    NNHJumpType_Banner_BusinessDetail = 4,          //实体店详情
    NNHJumpType_Banner_GoodsOrderDeatil = 5,        //订单详情（各种状态订单的详情页）
    NNHJumpType_Banner_GoodsCategory = 6,           //商城分类
    NNHJumpType_Banner_StoreList = 7,               //实体店列表页面
    NNHJumpType_Banner_StorePayment = 8,            //实体店优惠付款
    NNHJumpType_Banner_StoreCategory = 9,           //实体店分类
    NNHJumpType_Banner_UserWithdrawDetail = 10,     //提现详情
    NNHJumpType_Banner_UserLoginRegister = 11,      //登录注册
    NNHJumpType_Banner_GoodsPrefectureMoney = 12,   //商城首页-现金专区
    NNHJumpType_Banner_GoodsPrefectureAll = 13,     //商城首页-现金+牛豆专区
    NNHJumpType_Banner_GoodsPrefectureBull = 14,    //商城首页-牛豆专区
    NNHJumpType_Banner_UserTakeOutOrder = 15,       //外卖订单【用户】 全部列表
    NNHJumpType_Banner_UserTakeOutOrderDetail = 16, //外卖订单详情--用户实体店的各种状态订单的详情页
    NNHJumpType_Banner_NZGTakeOutOrderList = 17,    //实体店待接单列表
    NNHJumpType_Banner_NZGRefundOrderDetail = 18,   //实体店退款订单详情
    NNHJumpType_Banner_NSEvaluateManager = 19,      //商家评价管理列表
    NNHJumpType_Banner_NSWaitSendOrderList = 20,    //商家待发货列表
    NNHJumpType_Banner_NSSaleOrderList = 21,        //商家售后管理列表
    NNHJumpType_Banner_StoreGoodsCategory = 25,     //实体店店铺外卖商品列表
    NNHJumpType_Banner_SecondGoodsCategory = 26,    //商城商品分类二级
    NNHJumpType_Banner_MallGoodsList = 27,          //商城商品列表
};

#import <Foundation/Foundation.h>
#import "NNHSingleton.h"
@class NNHBannerModel;

@interface NNHJumpHelper : NSObject
NNHSingletonH

/**
 轮播图跳转

 @param model NNHBannerModel
 */
- (void)jumpToDifferenceViewControllerWithBannerModel:(NNHBannerModel *)model viewController:(UIViewController *)vc;

@end
