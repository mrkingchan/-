//
//  NNHApplicationHelper.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/31.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNHSingleton.h"
#import  <CoreLocation/CoreLocation.h>

@interface NNHApplicationHelper : NSObject
NNHSingletonH

#pragma mark --
#pragma mark -- 系统设置
- (void)openApplcationSetting;

#pragma mark --
#pragma mark -- QQ
- (void)openQQWithQQNumber:(NSString *)qqNum;

#pragma mark --
#pragma mark -- 打电话
- (void)openPhoneNum:(NSString *)phoneNum InView:(UIView *)view;

#pragma mark --
#pragma mark -- 身份认证
- (BOOL)isRealName;

#pragma mark --
#pragma mark -- 退出登录
- (void)logingOut;


#pragma mark --
#pragma mark -- 更新支付密码
- (void)updatePayPassword;

@end
