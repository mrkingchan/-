//
//  NNHConst.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/19.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHConst.h"

@implementation NNHConst

#pragma mark -----
#pragma mark ----- 公用
/** 公用-间距-5 操作按钮左右间距 */
CGFloat const NNHMargin_5 = 5;
/** 公用-间距-10 */
CGFloat const NNHMargin_10 = 10;
/** 公用-间距-15 */
CGFloat const NNHMargin_15 = 15;
/** 公用-间距-20 */
CGFloat const NNHMargin_20 = 20;
/** 公用-间距-25 */
CGFloat const NNHMargin_25 = 25;
/** 公用-操作按钮高度（登录、确认等）- 44 */
CGFloat const NNHOperationButtonH = 44;
/** 公用-操作按钮圆角半径 */
CGFloat const NNHOperationButtonRadiu = 22;
/** 公用-所有头部、尾部View、单个Cell（详情等）- 44 */
CGFloat const NNHNormalViewH = 44;
/** 公用-所有分割线高度 - 0.5 */
CGFloat const NNHLineH = 0.5;
/** 雅活-顶部toolbar的高度 */
CGFloat const NNHTopToolbarH = 40;
/** 公用-键盘／选择器高度 */
CGFloat const NNHKeyboardHeight = 216;
/** 公用-按钮重复点击间隔 */
CGFloat const NNHAcceptEventInterval = 3;
/** 最大手机位数 */
CGFloat const NNHMaxPhoneLength = 12;
/** 最小手机位数 */
CGFloat const NNHMinPhoneLength = 6;
/** 牛牛汇版本接口 */
NSString *const NNHPort = @"I1.0.3";

#pragma mark -----
#pragma mark ----- 所用图比例
/** 广告（除商品详情） 16:9*/
CGFloat const NNHIMAGEWHSCALE_169 = 0.56;
/** 首页 动态图片比例）5:2 */
CGFloat const NNHImageScale_Banner = 0.73;
/** 激励收益 12：5 */
CGFloat const NNHIMAGEWHSCALE_125 = 0.42;
/** 商品管理图片比例 2:3 */
CGFloat const NNH_StoreRecommendGoodsImage = 0.67;
/** 首页 banner图片比例）5:2 */
CGFloat const NNHImageScale_Banner_05 = 0.5;

#pragma mark -----
#pragma mark ----- 我的
/** 身份证宽高比 */
CGFloat const NNHCardScale = 0.63;
/** 雅商客服电话 */
NSString *const NNHServicePhone = @"4000-757-999";
/** 雅商客服微信 */
NSString *const NNHServiceWeChat = @"18022579893";
/** 我的分享/我的余额／单个角色topview高度 */
CGFloat const NNHMyRoleFenRunTopViewHeight = 425 *0.5;
/** 我的余额特殊角色高度比例 */
CGFloat const NNHMyRoleFenRunTopViewLongerHeight = 480 *0.5;

// 会员中心首页文字
/** 我的余额 */
NSString *const NNHMineBalanceText = @"我的余额";
/** 我的角色 */
NSString *const NNHMineRoleText = @"我要管理";


#pragma mark -----
#pragma mark ----- 全部评论
/** 评论 - 头像的最大Y值 */
CGFloat const NNHCommentsIconMaxY = 45;
/** 评论 - 图片间距 */
CGFloat const NNHCommentsimageMargin = 2;
/** 评论 - 最大图片数 */
CGFloat const NNHCommentsimagesCount = 5;


#pragma mark -----
#pragma mark ----- 订单详情
/** 订单详情状态提示viewH */
CGFloat const NNHOrderDetailPromptViewH = 90.00;
/** 订单详情操作viewH */
CGFloat const NNHOrderDetailOperationViewH = 54.00;
/** 订单详情信息viewH */
CGFloat const NNHOrderDetailInformationViewH = 102.00;


#pragma mark -----
#pragma mark ----- ShareSDK其他接口的appkey
/** ShareSDK-Appkey */
NSString *const NNH_ShareSDK_Appkey = @"275e00c1e74a2";
/** ShareSDK-AppSecret */
NSString *const NNH_ShareSDK_AppSecret = @"869f2aab452055138efb5daa3c247d18";
/** 微信、朋友圈AppID */
NSString *const NNH_ShareSDK_WEIXIN_APPID_INDEX = @"wxd82f70300bc83fa9";
/** 微信、朋友圈SECRET */
NSString *const NNH_ShareSDK_WEIXIN_SECRET_INDEX = @"9eb41835dd2797b8f2516436ce20e643";
/** QQ-AppID */
NSString *const NNH_ShareSDK_QQ_AppID = @"1107606307";
/** QQ-AppKey */
NSString *const NNH_ShareSDK_QQ_AppKey = @"aNuZ49ztIIq6koQa";

/** 融云-AppKey开发环境 */
NSString *const NNH_RongCloud_Appkey_Develop = @"pkfcgjstpom28";
/** 融云-AppKey正式环境 */
NSString *const NNH_RongCloud_Appkey = @"c9kqb3rdco7mj";
/** 融云-单聊消息 订单处理消息 */
NSString *const NNH_RongCloud_Message_OrderHandle = @"6bb61e3b7bce0931da574d19d1d82c88";
/** 融云-单聊消息 分润收益消息 */
NSString *const NNH_RongCloud_Message_Income = @"5d7b9adcbe1c629ec722529dd12e5129";
/** 融云-单聊消息 加油提现消息 */
NSString *const NNH_RongCloud_Message_RechargeOrWidth = @"b3149ecea4628efd23d2f86e5a723472";
/** 融云-单聊消息 系统消息 */
NSString *const NNH_RongCloud_Message_System = @"0267aaf632e87a63288a08331f22c7c3";
///** 融云-单聊消息 */
//NSString *const NNH_RongCloud_Appkey = @"3argexb6342be";

#pragma mark -----
#pragma mark ----- 货币
/** 牛牛汇货币 */
NSString *const NNHCurrency = @"积分";

#pragma mark -----
#pragma mark ----- 高德地图
/** 高德地图 */
NSString *const NNH_MAMapSDKAppKey = @"2a837eb914f79bd9e538100a372c4984";
/** 友盟统计 */
NSString *const NNH_UMengAppKey = @"5b6c131da40fa3380f00002d";

#pragma mark -----
#pragma mark ----- 项目安全相关
/** 私钥 */
NSString *const NNHAPI_PRIVATEKEY_IOS = @"14d62d8380f484503c53c95d17adf4d8";


#pragma mark -----
#pragma mark ----- 其他
/** 用户位置 属性列表保存字段  上次保存的城市名 */
NSString *const NNH_User_Location_lastSaveCityName = @"NNH_User_Location_lastSaveCityName";
NSString *const NNH_User_CurrentLocation_cityName = @"NNH_User_CurrentLocation_cityName";
/** 用户位置 属性列表保存字段  经度 */
NSString *const NNH_User_CurrentLocation_longitude = @"NNH_User_CurrentLocation_longitude";
/** 用户位置 属性列表保存字段  纬度 */
NSString *const NNH_User_CurrentLocation_latitude = @"NNH_User_CurrentLocation_latitude";
/** 保存用户当前城市id */
NSString *const NNH_User_CurrentLocation_cityID = @"NNH_User_CurrentLocation_cityID";
/** 保存推送的token */
NSString *const NNH_User_Device_push_token = @"NNH_User_Device_push_token";
#pragma mark -----
#pragma mark ----- 实体店
/** 实体店我要收款页面 属性列表保存实体店平台号 */
NSString *const NNH_Store_storePayCollection_businessCode = @"NNH_Store_storePayCollection_businessCode";

/** 实体店外卖保存 当前下单商品的数据库名称 */
NSString *const NNH_Store_storeTakeoutSave_sqliteName = @"NNH_Save_Takeout.sqlite";

@end
