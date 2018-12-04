//
//  NNHUserModel.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHUserModel : NSObject <NSCoding>

/** 手机令牌 */
@property (nonatomic, copy) NSString *mtoken;
/** 账户 */
@property (nonatomic, copy) NSString *username;
/** 平台号 */
@property (nonatomic, copy) NSString *customer_code;
/** 用户名 */
@property (nonatomic, copy) NSString *nickname;
/** 真实姓名 */
@property (nonatomic, copy) NSString *realname;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 生日 */
@property (nonatomic, copy) NSString *borndate;
/** 地区 */
@property (nonatomic, copy) NSString *area;
/** 地区编码 */
@property (nonatomic, copy) NSString *area_code;
/** 用户头像 */
@property (nonatomic, copy) NSString *headerpic;
/** 是否实名认证 */
@property (nonatomic, copy) NSString *isnameauth;
/** 身份证号码 */
@property (nonatomic, copy) NSString *idnumber;
/** 是否设置收货地址 */
@property (nonatomic, copy) NSString *logisticsDec;
/** 用户手机 */
@property (nonatomic, copy) NSString *mobile;
/** 完整手机号 */
@property (nonatomic, copy) NSString *completemobile;
/** 是否设置支付密码 */
@property (nonatomic, copy) NSString *payDec;
/** 是否设置登录密码(1是 0否) */
@property (nonatomic, copy) NSString *isloginpwd;
/** 当前用户角色 */
@property (nonatomic, copy) NSString *role;
/** 银行卡数量 */
@property (nonatomic, copy) NSString *banknumber;
/** vip */
@property (nonatomic, copy) NSString *companyphone;

#pragma  mark -- 辅助属性
/** 性别 */
@property (nonatomic, copy) NSString *uesrSex;

@end
