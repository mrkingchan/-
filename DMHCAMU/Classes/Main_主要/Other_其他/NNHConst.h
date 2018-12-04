//
//  NNHConst.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/19.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 我的钱包流水类型 */
typedef NS_ENUM(NSUInteger, NNHWalletTransferRecordType) {
    NNHWalletTransferRecordType_income = 0,                  // 投资收益
    NNHWalletTransferRecordType_rechargeOrWithdraw = 1,      // 充值体现
    NNHWalletTransferRecordType_consume = 2,                 // 艺术品消费
};

/** 首页 cell 标识符类型 */
typedef NS_ENUM(NSUInteger, NNHHomePageModelCellIdentifier) {
    NNHHomePageModelCellIdentifier_Default,
    NNHHomePageModelCellIdentifier_Banner,          // 单独的banner
    NNHHomePageModelCellIdentifier_Entrance,        // 入口
    NNHHomePageModelCellIdentifier_NormalGoods,     // 普通商品
    
};

/** 发送验证码type  */
typedef NS_ENUM(NSInteger, NNHSendVerificationCodeType){
    NNHSendVerificationCodeType_userRegister = 0,               // 注册发送验证码
    NNHSendVerificationCodeType_userForgetpwd = 1,              // 忘记密码
    NNHSendVerificationCodeType_changeLoginPassword = 2,        // 修改登录密码，发送验证码
    NNHSendVerificationCodeType_changePayPassword = 3,          // 修改资金密码，发送验证码
    NNHSendVerificationCodeType_updatePhone = 5                // 更新手机号码
};

typedef NS_ENUM(NSInteger, NNHOrderPayType) {
    NNHOrderPayTypeBalancePay = 0,      //账户余额
    NNHOrderPayTypeAliPay     = 1,      //支付宝
    NNHOrderPayTypeWeChatPay  = 2,      //微信支付
    NNHOrderPayTypeSpeedyPay  = 3,      //快捷支付
    NNHOrderPayTypeyopURL     = 4,      //易宝H5支付
};

/** 消息类型类型 */
typedef NS_ENUM(NSInteger , NNHMessageCenterType){
    NNHMessageCenterType_System = 0,               /*系统消息*/
    NNHMessageCenterType_OrderHandle = 1,          /*订单处理消息*/
    NNHMessageCenterType_Income = 2,               /*分润收益消息*/
    NNHMessageCenterType_RechargeWidth = 3,        /*加油提现搜索*/
};


typedef NS_ENUM(NSInteger, NNHRoleQuickJump){
    NNHRoleQuickJump_ndOrder = 1,  // 实体店订单
    NNHRoleQuickJump_npOrder = 2,    // 商城订单
    NNHRoleQuickJump_shoppingCar = 3,   // 购物车
    NNHRoleQuickJump_myEvaluate = 4,  // 我的评价
    NNHRoleQuickJump_myCollection = 5,    // 我的收藏
    NNHRoleQuickJump_mddressManage = 6,   // 地址管理
    NNHRoleQuickJump_nsOrder = 7,  // 商家订单管理
    NNHRoleQuickJump_nsSale = 8,    // 商家售后管理
    NNHRoleQuickJump_nsEvaluate = 9,   // 商家评价管理
    NNHRoleQuickJump_nzgQrCode = 10,  // 实体店收款二维码
    NNHRoleQuickJump_nzgCRM = 11,    // 实体店CRM
    NNHRoleQuickJump_nzgOrder = 12,   // 实体店订单管理
    NNHRoleQuickJump_nzgStoreData = 13,  // 实体店实体店资料
    NNHRoleQuickJump_nzgGoodsManage = 14,  // 实体店商品管理
    NNHRoleQuickJump_nzgClassManage = 15,   // 实体店分类管理
    NNHRoleQuickJump_nzgMemberManage = 16,   // 实体店员工管理
    NNHRoleQuickJump_outreachNZG = 17,   // 店掌柜
    NNHRoleQuickJump_outreachNS = 18,   // 商家
    NNHRoleQuickJump_balance = 19,   // 余额
    NNHRoleQuickJump_nd = 20,   // 牛豆
    NNHRoleQuickJump_deduction = 21,   // 抵扣金
    NNHRoleQuickJump_nzgShareDetail = 22,   // 实体店消费明细
    NNHRoleQuickJump_nzgTurnover = 23,   // 实体店营业总额明细
    NNHRoleQuickJump_qrCode = 24,   // 推广二维码
    NNHRoleQuickJump_increase = 25,   // 未到账奖励（待增）
    NNHRoleQuickJump_communitySubs = 26,   // 社群明细
    NNHRoleQuickJump_nsReceived = 27,   // 商家已收货款
    NNHRoleQuickJump_nsNoReceived = 28,   // 商家未收货款
    NNHRoleQuickJump_joinPartner = 29,   // 加入合伙人
    NNHRoleQuickJump_nzgStoreManage = 30,   // 实体店店铺管理
    NNHRoleQuickJump_nb = 31   // NB
};

typedef NS_ENUM(NSInteger, NNHOrderOperationStatus){
    NNHOrderOperationStatus_pay = 1,  // 付款
    NNHOrderOperationStatus_cancelOrder = 2,  // 取消订单
    NNHOrderOperationStatus_notSend = 3,    // 提醒发货
    NNHOrderOperationStatus_refundApply = 4,   // 申请退款
    NNHOrderOperationStatus_cancelRefund = 5,    // 取消退款
    NNHOrderOperationStatus_extendReceiving = 6,  // 延长收货
    NNHOrderOperationStatus_logistics = 7,  // 查看物流
    NNHOrderOperationStatus_sureReceiving = 8,    // 确认收货
    NNHOrderOperationStatus_comments = 9,   // 评价
    NNHOrderOperationStatus_afterSales = 10,    // 售后
    NNHOrderOperationStatus_deleteOrder = 11,    // 删除订单
    NNHOrderOperationStatus_refund_cancel = 12,    // 退款详情-取消退款
    NNHOrderOperationStatus_refund_changeApply = 13,    // 退款详情-修改申请
    NNHOrderOperationStatus_refund_cancelApply = 14,    // 退款详情-撤销申请
    NNHOrderOperationStatus_refunding = 15,    // 订单详情-退款中
    NNHOrderOperationStatus_refundSuccess = 16,    // 订单详情-已退款
    NNHOrderOperationStatus_refundListFillLogistics = 17,   // 退单列表-填写物流单号
    NNHOrderOperationStatus_refundDetailSubmitLogistics = 19,   // 退款详情-提交物流
};

typedef NS_ENUM(NSInteger, NNHOrderToobarStatus){ // 我的订单
    NNHOrderToobarStatus_all = 1,  // 全部
    NNHOrderToobarStatus_notPaying = 2,  // 未付款
    NNHOrderToobarStatus_notSend = 3,    // 待发货
    NNHOrderToobarStatus_notReceiving = 4,   // 未收货
    NNHOrderToobarStatus_notEvaluation = 5,    // 未评价
    NNHOrderToobarStatus_sale = 11    // 退货／售后
};

typedef NS_ENUM(NSInteger, NNHOrderStatus){
    NNHOrderStatus_notPaying = 0,  // 未付款
    NNHOrderStatus_notSend = 1,    // 待发货
    NNHOrderStatus_notReceiving = 2,   // 未收货
    NNHOrderStatus_sureReceiving = 3,    // 已确认收货
    NNHOrderStatus_completion = 4,    // 订单完结
    NNHOrderStatus_cancel = 5,    // 订单关闭
    NNHOrderStatus_refundInAudit = 7,    // 退款审核中
    NNHOrderStatus_refundIn = 8,    // 退款中
    NNHOrderStatus_refundAuditFailure = 9,    // 退款审核失败
    NNHOrderStatus_refundSuccess = 10,    // 退款成功
    NNHOrderStatus_returnOfAudit = 11,    // 退货/退款审核中
    NNHOrderStatus_returnOfGoods = 12,    // 退货/退款中
    NNHOrderStatus_returnAuditFailure = 13,    // 退货/退款审核失败
    NNHOrderStatus_returnSuccess = 14,    // 退货/退款成功
    NNHOrderStatus_cancelRefund = 14     // 用户取消退货/退款
};

typedef NS_ENUM(NSInteger, NNHOrderRefundStatus){
    NNHOrderRefundStatus_no = 0,  // 无退款
    NNHOrderRefundStatus_for = 1,    // 退款中
    NNHOrderRefundStatus_complete = 2,   // 退款完成
};

@interface NNHConst : NSObject

#pragma mark -----
#pragma mark ----- 公用
/** 公用-间距-5 操作按钮左右间距 */
UIKIT_EXTERN CGFloat const NNHMargin_5;
/** 公用-间距-10 */
UIKIT_EXTERN CGFloat const NNHMargin_10;
/** 公用-间距-15 */
UIKIT_EXTERN CGFloat const NNHMargin_15;
/** 公用-间距-20 */
UIKIT_EXTERN CGFloat const NNHMargin_20;
/** 公用-间距-25 */
UIKIT_EXTERN CGFloat const NNHMargin_25;
/** 公用-操作按钮高度（登录、确认等）- 40 */
UIKIT_EXTERN CGFloat const NNHOperationButtonH;
/** 公用-操作按钮圆角半径 */
UIKIT_EXTERN CGFloat const NNHOperationButtonRadiu;
/** 公用-所有头部、尾部View、单个Cell（详情等）- 44 */
UIKIT_EXTERN CGFloat const NNHNormalViewH;
/** 公用-所有分割线高度 - 0.5 */
UIKIT_EXTERN CGFloat const NNHLineH;
/** 公用-顶部toolbar的高度 */
UIKIT_EXTERN CGFloat const NNHTopToolbarH;
/** 公用-顶部toolbar的Y */
UIKIT_EXTERN CGFloat const NNHTopToolbarY;
/** 公用-键盘／选择器高度 */
UIKIT_EXTERN CGFloat const NNHKeyboardHeight;
/** 公用-按钮重复点击间隔 */
UIKIT_EXTERN CGFloat const NNHAcceptEventInterval;
/** 最大手机位数 */
UIKIT_EXTERN CGFloat const NNHMaxPhoneLength;
/** 最小手机位数 */
UIKIT_EXTERN CGFloat const NNHMinPhoneLength;
/** 牛牛汇版本接口 */
UIKIT_EXTERN NSString *const NNHPort;


#pragma mark -----
#pragma mark ----- 所用图比例
/** 广告（除商品详情） 16:9*/
UIKIT_EXTERN CGFloat const NNHIMAGEWHSCALE_169;
/** 首页 banner图宽高比例）0.73 */
UIKIT_EXTERN CGFloat const NNHImageScale_Banner;
/** 激励收益 12：5 */
UIKIT_EXTERN CGFloat const NNHIMAGEWHSCALE_125;
/** 商品管理图片比例 2:3 */
UIKIT_EXTERN CGFloat const NNH_StoreRecommendGoodsImage;
/** 首页 banner图片比例）5:2 */
UIKIT_EXTERN CGFloat const NNHImageScale_Banner_05;


#pragma mark -----
#pragma mark ----- 会员中心
/** 身份证宽高比 */
UIKIT_EXTERN CGFloat const NNHCardScale;
/** 客服电话 */
UIKIT_EXTERN NSString *const NNHServicePhone;
/** 客服微信 */
UIKIT_EXTERN NSString *const NNHServiceWeChat;
/** 我的分享/我的余额／单个角色topview高度 */
UIKIT_EXTERN CGFloat const NNHMyRoleFenRunTopViewHeight;
/** 我的余额特殊角色高度比例 */
UIKIT_EXTERN CGFloat const NNHMyRoleFenRunTopViewLongerHeight;

// 会员中心首页文字
/** 我的余额 */
UIKIT_EXTERN NSString *const NNHMineBalanceText;
/** 我的角色 */
UIKIT_EXTERN NSString *const NNHMineRoleText;


#pragma mark -----
#pragma mark ----- 全部评论
/** 评论 - 头像的最大Y值 */
UIKIT_EXTERN CGFloat const NNHCommentsIconMaxY;
/** 评论 - 图片间距 */
UIKIT_EXTERN CGFloat const NNHCommentsimageMargin;
/** 评论 - 最大图片数 */
UIKIT_EXTERN CGFloat const NNHCommentsimagesCount;


#pragma mark -----
#pragma mark ----- 订单详情
/** 订单详情状态提示viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailPromptViewH;
/** 订单详情操作viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailOperationViewH;
/** 订单详情信息viewH */
UIKIT_EXTERN CGFloat const NNHOrderDetailInformationViewH;


#pragma mark -----
#pragma mark ----- ShareSDK其他接口的appkey
/** ShareSDK-Appkey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_Appkey;
/** ShareSDK-AppSecret */
UIKIT_EXTERN NSString *const NNH_ShareSDK_AppSecret;
/** 微信、朋友圈AppID */
UIKIT_EXTERN NSString *const NNH_ShareSDK_WEIXIN_APPID_INDEX;
/** 微信、朋友圈SECRET */
UIKIT_EXTERN NSString *const NNH_ShareSDK_WEIXIN_SECRET_INDEX;
/** 新浪微博-Appkey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_SinaWeiBo_AppKey;
/** 新浪微博-AppSecret */
UIKIT_EXTERN NSString *const NNH_ShareSDK_SinaWeiBo_AppSecret;
/** QQ-AppID */
UIKIT_EXTERN NSString *const NNH_ShareSDK_QQ_AppID;
/** QQ-AppKey */
UIKIT_EXTERN NSString *const NNH_ShareSDK_QQ_AppKey;

/** 融云-AppKey开发环境 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Appkey_Develop;
/** 融云-AppKey */
UIKIT_EXTERN NSString *const NNH_RongCloud_Appkey;
/** 融云-单聊消息 订单处理消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_OrderHandle;
/** 融云-单聊消息 分润收益消息 */
 UIKIT_EXTERN NSString *const NNH_RongCloud_Message_Income;
/** 融云-单聊消息 加油提现消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_RechargeOrWidth;
/** 融云-单聊消息 系统消息 */
UIKIT_EXTERN NSString *const NNH_RongCloud_Message_System;
#pragma mark -----
#pragma mark ----- 货币
/** 牛牛汇货币 */
UIKIT_EXTERN NSString *const NNHCurrency;

#pragma mark -----
#pragma mark ----- 高德地图
/** 牛牛汇货币 */
UIKIT_EXTERN NSString *const NNH_MAMapSDKAppKey;
UIKIT_EXTERN NSString *const NNH_UMengAppKey;

#pragma mark -----
#pragma mark ----- 项目安全相关
/** 私钥 */
UIKIT_EXTERN NSString *const NNHAPI_PRIVATEKEY_IOS;

#pragma mark -----
#pragma mark ----- 其他
/** 用户位置 属性列表保存字段  上次保存的城市名 */
UIKIT_EXTERN NSString *const NNH_User_Location_lastSaveCityName;
/** 用户位置 属性列表保存字段  当前城市 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_cityName;
/** 用户位置 属性列表保存字段  经度 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_longitude;
/** 用户位置 属性列表保存字段  纬度 */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_latitude;
/** 保存用户当前城市id */
UIKIT_EXTERN NSString *const NNH_User_CurrentLocation_cityID;
/** 保存推送的token */
UIKIT_EXTERN NSString *const NNH_User_Device_push_token;

#pragma mark -----
#pragma mark ----- 实体店
/** 实体店我要收款页面 属性列表保存实体店平台号 */
UIKIT_EXTERN NSString *const NNH_Store_storePayCollection_businessCode;


/** 实体店外卖保存 当前下单商品的数据库名称 */
UIKIT_EXTERN NSString *const NNH_Store_storeTakeoutSave_sqliteName;


@end
