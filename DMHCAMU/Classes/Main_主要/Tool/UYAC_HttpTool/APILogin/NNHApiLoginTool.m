//
//  NNHApiLoginTool.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHApiLoginTool.h"

@implementation NNHApiLoginTool

/** 根据手机号获取登录验证码 */
- (instancetype)initWithMobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_Login_GetLoginCode;
        self.reAPIName = @"根据手机号获取登录验证码";
        
        self.reParams = @{
                            @"mobile"       : mobile,
                            @"devicenumber" : [[NNHProjectControlCenter sharedControlCenter].proConfig getUUId],
                            @"privatekey"   : [self md5WithCode:mobile],
                        };
    }
    return self;
}

- (instancetype)initLoginWithUserName:(NSString *)username
                             password:(NSString *)password
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_NormalLogin;
        self.reAPIName = @"用户登录";
        
        self.reParams = @{
                              @"mobile" : username,
                              @"loginpwd" : [password md5String],
                              @"devtype"  : @"I"
                          };
    }
    return self;
}

- (instancetype)initWithMobile:(NSString *)mobile
                  registertype:(NSString *)registertype
                      valicode:(NSString *)valicode
                      loginpwd:(NSString *)loginpwd
                    confirmpwd:(NSString *)confirmpwd
                      parentid:(NSString *)parentid
                   countryCode:(NSString *)countryCode
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.register.register";
        self.reAPIName = @"用户注册";
        
        if (!parentid) {
            parentid = @"";
        }
        
        self.reParams = @{
                          @"devtype"        : @"I",
                          @"typeregister"   : registertype,
                          @"mobile"         : mobile,
                          @"loginpwd"       : [loginpwd md5String],
                          @"confirmpwd"     : [confirmpwd md5String],
                          @"valicode"       : [self md5WithCode:valicode],
                          @"parentname"     : parentid,
                          @"countrycode"    : countryCode,
                          };
    }
    return self;
}

- (instancetype)initCountryCodeData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.public.getcountrycode";
        self.reAPIName = @"获取国家代码";
    }
    return self;
}

- (instancetype)initWithLogout
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_NormalLogout;
        self.reAPIName = @"退出登录";
    }
    return self;
}

- (NSString *)md5WithCode:(NSString *)code
{
    NSString *string = [NSString stringWithFormat:@"%@%@",code,NNHAPI_PRIVATEKEY_IOS];
    return [string md5String];
}

@end
