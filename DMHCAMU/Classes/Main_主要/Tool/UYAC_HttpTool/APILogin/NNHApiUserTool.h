//
//  NNHApiUserTool.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHApiUserTool : NNHBaseRequest

/** 获取个人中心数据 */
- (instancetype)initMemberDataSource;

/** 获取用户资料信息 */
- (instancetype)initUserDataSource;

/** 开通信用分 */
- (instancetype)initOpenCredit;

/** 我的信用分 */
- (instancetype)initMyCredit;

/** 我的二维码 */
- (instancetype)initMyQrCode;

/** 更改用户资料信息 */
- (instancetype)initChangeUserDataSourceWithNickName:(NSString *)name
                                                 sex:(NSString *)sex
                                           headerpic:(NSString *)pic
                                            borndate:(NSString *)borndate
                                                area:(NSString *)area
                                            areaCode:(NSString *)areaCode;

#pragma mark --
#pragma mark -- 账户安全相关
/**
 发送验证码
 
 @param mobile 手机号码
 @param type 验证码类型
 @return 实例对象
 */
- (instancetype)initWithMobile:(NSString *)mobile
                verifyCodeType:(NNHSendVerificationCodeType)type;

/**
 发送验证码 （适用于忘记密码）
 
 @param mobile 手机号码
 @param username 用户名
 @return 实例对象
 */
- (instancetype)initWithMobile:(NSString *)mobile
                      username:(NSString *)username;


/**
 重置密码短信验证
 
 @param mobile 手机号码
 @param code 验证码
 @return 实例对象
 */
- (instancetype)initResetPasswordValidationWithMobile:(NSString *)mobile
                                                 code:(NSString *)code
                                             username:(NSString *)username
                                             codeType:(NNHSendVerificationCodeType)codeType;

/**
 设置资金密码
 
 @param code 资金密码
 @param isFirst 是不是第一次设置
 @return 实例对象
 */
- (instancetype)initWithSetupPaycode:(NSString *)code
                             isFirst:(BOOL)isFirst;



/**
 设置登录密码
 
 @return 实例对象
 */
- (instancetype)initSetUpPasswordWithPassword:(NSString *)password
                                   confirmpwd:(NSString *)confirmpwd;


/**
 修改登录密码
 
 @return 实例对象
 */
- (instancetype)initUpdatePwdWithMobile:(NSString *)mobile
                               username:(NSString *)username
                                encrypt:(NSString *)encrypt
                                    pwd:(NSString *)pwd
                             confirmpwd:(NSString *)confirmpwd;

/**
 修改手机号码
 
 @return 实例对象
 */
- (instancetype)initUpdatePhoneWithMobile:(NSString *)mobile
                                 valicode:(NSString *)valicode;



#pragma mark --
#pragma mark -- 实名
/**
 身份认证
 @param name 真实姓名
 @param idnumber 身份证号
 @param idcardimg 身份证照片拼接url
 @return api
 */
- (instancetype)initWithRealName:(NSString *)name
                        idnumber:(NSString *)idnumber
                       idcardimg:(NSString *)idcardimg;


/**
 请求实名认证信息
 
 @return api
 */
- (instancetype)initAuthInfo;

@end
