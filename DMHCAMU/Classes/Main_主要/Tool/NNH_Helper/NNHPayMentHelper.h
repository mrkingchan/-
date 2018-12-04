//
//  NNHPayMentHelper.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/21.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>

@interface NNHPayMentHelper : NSObject

/** 是否支付成功 **/
@property (nonatomic, assign) BOOL isPaySucess;

/** 成功支付的回调 */
@property (nonatomic, copy) void(^paySuccessBlock)(void);
/** 成功支付的回调 */
@property (nonatomic, copy) void(^payFailedBlock)(void);
/** 成功支付的回调 */
@property (nonatomic, copy) void(^payCancleBlock)(void);
/** 支付忘记密码的回调 */
@property (nonatomic, copy) void(^payMissCodeBlock)(NSString *errorCode);

/** 用支付宝支付的回调 */
@property (nonatomic, copy) void(^payWithAliBlock)(void);

+ (instancetype)shareInstance;

///** 开始调起支付方式 */
//- (void)startPayMentWithType:(NNHOrderPayType)payMentType andorderNum:(NSString *)orderNum payCode:(NSString *)paycode payType:(NNHPaymentContentType)paytContentType;

/** 处理支付宝支付回调 */
- (void)handleAliPayWithUrl:(NSURL *)url;

/** 处理银联支付回调 */
//- (void)handleUPayMentWithOrderUrl:(NSURL *)orderUrl;
@end
