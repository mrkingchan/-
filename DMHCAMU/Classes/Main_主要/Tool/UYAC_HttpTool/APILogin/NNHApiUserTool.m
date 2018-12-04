//
//  NNHApiUserTool.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHApiUserTool.h"

@implementation NNHApiUserTool

- (instancetype)initMemberDataSource
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Index;
        self.reAPIName = @"会员中心";
    }
    return self;
}

- (instancetype)initUserDataSource
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_MyInfo;
        self.reAPIName = @"我的资料";
    }
    return self;
}

- (instancetype)initOpenCredit
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.credit.opencredit";
        self.reAPIName = @"开通我的信用";
    }
    return self;
}

- (instancetype)initMyCredit
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.credit.index";
        self.reAPIName = @"我的信用";
    }
    return self;
}

- (instancetype)initMyQrCode
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.index.push";
        self.reAPIName = @"我的二维码";
    }
    return self;
}

/** 更改用户资料信息 */
- (instancetype)initChangeUserDataSourceWithNickName:(NSString *)name
                                                 sex:(NSString *)sex
                                           headerpic:(NSString *)pic
                                            borndate:(NSString *)borndate
                                                area:(NSString *)area
                                            areaCode:(NSString *)areaCode
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_UpdateInfo;
        self.reAPIName = @"修改我的资料";
        
        if (![NSString isEmptyString:name]) {
            self.reParams = @{@"nickname" : name};
        }
        
        if (![NSString isEmptyString:sex]) {
            self.reParams = @{@"sex" : sex};
        }
        
        if (![NSString isEmptyString:pic]) {
            self.reParams = @{@"headerpic" : pic};
        }
        
        if (![NSString isEmptyString:borndate]) {
            self.reParams = @{@"borndate" : borndate};
        }
        
        if (![NSString isEmptyString:areaCode]) {
            self.reParams = @{@"area" : area, @"area_code" :areaCode};
        }
    }
    
    return self;
}

- (instancetype)initWithMobile:(NSString *)mobile
                verifyCodeType:(NNHSendVerificationCodeType)type
{
    self = [super init];
    if (self) {
        
        if (type == NNHSendVerificationCodeType_userRegister) {
            self.requestReServiceType = @"user.login.send";
        }else if (type == NNHSendVerificationCodeType_changePayPassword) {
            self.requestReServiceType = @"user.user.sendPay";
        }else if (type == NNHSendVerificationCodeType_updatePhone){
            self.requestReServiceType = @"user.user.send";
        }else{
            self.requestReServiceType = @"user.user.sendlogin";
        }
        
        NSString *username = @"";
        if (type != NNHSendVerificationCodeType_userRegister) {
            username = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.username;
        }
        
        self.reAPIName = @"发送短信验证码";
        self.reParams = @{
                          @"mobile"         : mobile,
                          @"username"       : username,
                          @"devicenumber"  :[[NNHProjectControlCenter sharedControlCenter].proConfig getUUId],
                          @"privatekey"     : [self md5WithCode:mobile]
                          };
    }
    return self;
}

- (instancetype)initWithMobile:(NSString *)mobile
                      username:(NSString *)username
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.sendlogin";
        self.reAPIName = @"发送短信验证码";
        self.reParams = @{
                          @"mobile"         : mobile,
                          @"username"       : username,
                          @"devicenumber"   :[[NNHProjectControlCenter sharedControlCenter].proConfig getUUId],
                          @"privatekey"     : [self md5WithCode:mobile],
                          @"sendType"       : @"update_loginpwd_"
                          };
    }
    return self;
}

- (instancetype)initResetPasswordValidationWithMobile:(NSString *)mobile
                                                 code:(NSString *)code
                                             username:(NSString *)username
                                             codeType:(NNHSendVerificationCodeType)codeType
{
    self = [super init];
    if (self) {
        
        if (codeType == NNHSendVerificationCodeType_changePayPassword) {
            self.requestReServiceType = @"user.user.validPhonePay";
            self.reAPIName = @"校验修改支付密码验证码";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"mobile"  : mobile
                              };
        }else if (codeType == NNHSendVerificationCodeType_updatePhone) {
            self.requestReServiceType = @"user.user.validupdatephone";
            self.reAPIName = @"校验修改手机号码校验操作";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"mobile"  : mobile
                              };
        }else {
            self.requestReServiceType = @"user.user.validloginpwd";
            self.reAPIName = @"找回登录密码/修改登录密码 短信验证";
            self.reParams = @{
                              @"valicode"   : [self md5WithCode:code],
                              @"username"   : username,
                              @"mobile"     : mobile
                              };
        }
    }
    return self;
}

/** 修改资金密码 */
- (instancetype)initWithSetupPaycode:(NSString *)paypwd isFirst:(BOOL)isFirst
{
    self = [super init];
    if (self) {
        
        if (isFirst) {
            self.requestReServiceType = @"user.user.setPay";
            self.reAPIName = @"设置支付密码";
        }else{
            self.requestReServiceType = @"user.user.updatePayPwd";
            self.reAPIName = @"修改支付密码";
        }
        
        self.reParams = @{@"paypwd" : [paypwd md5String]};
    }
    return self;
}

- (instancetype)initSetUpPasswordWithPassword:(NSString *)password
                                   confirmpwd:(NSString *)confirmpwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.setloginpwd";
        self.reAPIName = @"设置登录密码";
        
        self.reParams = @{
                          @"loginpwd" : [password md5String],
                          @"confirmpwd" : [confirmpwd md5String]
                          };
    }
    return self;
}

- (instancetype)initUpdatePwdWithMobile:(NSString *)mobile
                               username:(NSString *)username
                                encrypt:(NSString *)encrypt
                                    pwd:(NSString *)pwd
                             confirmpwd:(NSString *)confirmpwd
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.updateloginpwd";
        self.reAPIName = @"找回登录密码/修改登录密码操作";
        
        self.reParams = @{
                          @"mobile" : mobile,
                          @"username" : username,
                          @"encrypt" : encrypt,
                          @"loginpwd" : [pwd md5String],
                          @"confirmpwd" : [confirmpwd md5String]
                          };
    }
    return self;
}

- (instancetype)initUpdatePhoneWithMobile:(NSString *)mobile
                                 valicode:(NSString *)valicode
{
    if (self = [super init]) {
        self.requestReServiceType = @"user.user.updatePhone";
        self.reAPIName = @"修改用户手机号码操作";
        self.reParams = @{
                          @"valicode"   : [self md5WithCode:valicode],
                          @"mobile"  : mobile
                          };
    }
    return self;
}

- (instancetype)initWithRealName:(NSString *)name
                        idnumber:(NSString *)idnumber
                       idcardimg:(NSString *)idcardimg
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.auth";
        self.reAPIName = @"实名认证";
        self.reParams = @{@"realname"   : name,
                          @"idnumber"   : idnumber,
                          @"idcardimg"  : idcardimg
                          };
    }
    return self;
}

- (instancetype)initAuthInfo
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.authinfo";
        self.reAPIName = @"实名认证信息";
        
    }
    return self;
}

- (NSString *)md5WithCode:(NSString *)code
{
    NSString *string = [NSString stringWithFormat:@"%@%@",code,NNHAPI_PRIVATEKEY_IOS];
    return [string md5String];
}

@end
