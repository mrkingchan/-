//
//  NNHNotificationName.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHNotificationName.h"

@implementation NNHNotificationName

#pragma mark -------  商品详情
/** 选中规格筛选出对应的SKU */
NSString * const NNH_NotificationClosePopView = @"NNH_NotificationClosePopView";
/** 返回升级专区 */
NSString * const NNH_NotificationJumpUpgradesZone = @"NNH_NotificationJumpUpgradesZone";

#pragma mark -
#pragma mark ---------购物车
/** 购物车选中商品变动价格 **/
NSString * const NNH_NotificationCart_GoodsChangeSelected = @"WL_NotifiecationPriceChange";


#pragma mark -
#pragma mark ---------支付
/** 支付去加油 **/
NSString * const NNH_NotificationPayTool_toAccountRecharge = @"NNH_NotificationPayTool_toAccountRecharge";
/** 支付去设置密码 **/
NSString * const NNH_NotificationPayTool_setupPayCode = @"NNH_NotificationPayTool_setupPayCode";
/** 支付去设置密码 **/
NSString * const NNH_NotificationPayTool_updatePayCode = @"NNH_NotificationPayTool_updatePayCode";

#pragma mark -
#pragma mark ---------消息
/** 消息中心获取到新消息 **/
NSString * const NNH_NotificationMessage_messageCenterGetNewMessage = @"NNH_NotificationMessage_messageCenterGetNewMessage";
/** 不同用户登录，发出通知删除界面消息内容 **/
NSString * const NNH_NotificationMessage_messageChangeCurrentLoginUser = @"NNH_NotificationMessage_messageChangeCurrentLoginUser";

#pragma mark -
#pragma mark ---------其他
/** 支付控件出现和消失时改变导航栏右滑返回手势 **/
NSString * const NNH_NotificationPayView_dispalyPayView = @"NNH_NotificationPayView_dispalyPayView";
NSString * const NNH_NotificationPayView_hiddenPayView = @"NNH_NotificationPayView_hiddenPayView";

#pragma mark -
#pragma mark ---------地图
/** 修改定位权限的通知 */
NSString * const NNH_NotificationLocation_ChangeAuthorizationStatus = @"NNH_NotificationLocation_ChangeAuthorizationStatus";
/** 获取到地理位置的通知 */
NSString * const NNH_NotificationLocation_UserLocation = @"NNH_NotificationLocation_UserLocation";

#pragma mark -------  支付宝授权回调
/** 支付宝授权回调 */
NSString * const NNH_NotificationLocation_alipayAuthCallback = @"NNH_NotificationLocation_alipayAuthCallback";
@end
