//
//  NNHApiLoginTool.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHApiLoginTool : NNHBaseRequest

/**
 注册国家手机号编码 
 @return api
 */
- (instancetype)initCountryCodeData;

/** 获取登录验证码 */
- (instancetype)initWithMobile:(NSString *)mobile;

/**
 @param username 用户名 （必填）
 @param password 密码 （必填）
 @return 登录
 */
- (instancetype)initLoginWithUserName:(NSString *)username
                             password:(NSString *)password;


/**
 注册
 
 @param mobile 手机号 （必填）
 @param registertype 1为注册 2为忘记密码
 @param valicode 验证码 （必填）
 @param loginpwd 登录密码
 @param confirmpwd 确认密码
 @param parentid 引荐人id
 @param countryCode 国家编号
 @return 登录注册
 */
- (instancetype)initWithMobile:(NSString *)mobile
                  registertype:(NSString *)registertype
                      valicode:(NSString *)valicode
                      loginpwd:(NSString *)loginpwd
                    confirmpwd:(NSString *)confirmpwd
                      parentid:(NSString *)parentid
                   countryCode:(NSString *)countryCode;


/**
 退出登录
 */
- (instancetype)initWithLogout;


@end
