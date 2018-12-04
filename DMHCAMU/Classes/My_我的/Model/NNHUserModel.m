//
//  NNHUserModel.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHUserModel.h"

NSString *const NNH_mtoken = @"NNH_mtoken";
NSString *const NNH_username = @"NNH_username";
NSString *const NNH_customer_code = @"NNH_customer_code";
NSString *const NNH_nickname = @"NNH_nickname";
NSString *const NNH_realname = @"NNH_realname";
NSString *const NNH_sex = @"NNH_sex";
NSString *const NNH_headerpic = @"NNH_headerpic";
NSString *const NNH_isnameauth = @"NNH_isnameauth";
NSString *const NNH_idnumber = @"NNH_idnumber";
NSString *const NNH_logisticsDec = @"NNH_logisticsDec";
NSString *const NNH_mobile = @"NNH_mobile";
NSString *const NNH_payDec = @"NNH_payDec";
NSString *const NNH_isloginpwd = @"NNH_isloginpwd";
NSString *const NNH_role = @"NNH_role";
NSString *const NNH_banknumber = @"NNH_banknumber";
NSString *const NNH_completemobile = @"NNH_completemobile";
NSString *const NNH_borndate = @"NNH_borndate";
NSString *const NNH_area = @"NNH_area";
NSString *const NNH_area_code = @"NNH_area_code";
NSString *const NNH_companyphone = @"NNH_companyphone";

@implementation NNHUserModel
{
    NSString *_userSex;
}

- (NSString *)uesrSex
{
    if (!_uesrSex) {
        if ([self.sex integerValue] == 1) {
            return @"男";
        }else if ([self.sex integerValue] == 2){
            return @"女";
        }else{
            return @"";
        }
    }
    return _uesrSex;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        NSString * (^decodeStringForKey) (NSString * key) = ^NSString *(NSString *key) {
            return [aDecoder decodeObjectForKey:key] ;
        };
        
        self.mtoken = decodeStringForKey(NNH_mtoken);
        self.username = decodeStringForKey(NNH_username);
        self.customer_code = decodeStringForKey(NNH_customer_code);
        self.nickname = decodeStringForKey(NNH_nickname);
        self.realname = decodeStringForKey(NNH_realname);
        self.sex = decodeStringForKey(NNH_sex);
        self.headerpic = decodeStringForKey(NNH_headerpic);
        self.isnameauth = decodeStringForKey(NNH_isnameauth);
        self.idnumber = decodeStringForKey(NNH_idnumber);
        self.logisticsDec = decodeStringForKey(NNH_logisticsDec);
        self.mobile = decodeStringForKey(NNH_mobile);
        self.payDec = decodeStringForKey(NNH_payDec);
        self.isloginpwd = decodeStringForKey(NNH_isloginpwd);
        self.role = decodeStringForKey(NNH_role);
        self.banknumber = decodeStringForKey(NNH_banknumber);
        self.completemobile = decodeStringForKey(NNH_completemobile);
        self.borndate = decodeStringForKey(NNH_borndate);
        self.area = decodeStringForKey(NNH_area);
        self.area_code = decodeStringForKey(NNH_area_code);
        self.companyphone = decodeStringForKey(NNH_companyphone);

    }
    return self;
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
    void (^encodeStringForKey) (NSString *stringValue, NSString * key) = ^(NSString *stringValue, NSString *key) {
        [aCoder encodeObject:stringValue  forKey:key];
    };
    
    encodeStringForKey(self.mtoken,NNH_mtoken);
    encodeStringForKey(self.username,NNH_username);
    encodeStringForKey(self.customer_code,NNH_customer_code);
    encodeStringForKey(self.nickname,NNH_nickname);
    encodeStringForKey(self.realname,NNH_realname);
    encodeStringForKey(self.sex,NNH_sex);
    encodeStringForKey(self.headerpic,NNH_headerpic);
    encodeStringForKey(self.isnameauth,NNH_isnameauth);
    encodeStringForKey(self.idnumber,NNH_idnumber);
    encodeStringForKey(self.logisticsDec,NNH_logisticsDec);
    encodeStringForKey(self.mobile,NNH_mobile);
    encodeStringForKey(self.payDec,NNH_payDec);
    encodeStringForKey(self.isloginpwd,NNH_isloginpwd);
    encodeStringForKey(self.role,NNH_role);
    encodeStringForKey(self.banknumber,NNH_banknumber);
    encodeStringForKey(self.completemobile,NNH_completemobile);
    encodeStringForKey(self.borndate,NNH_borndate);
    encodeStringForKey(self.area,NNH_area);
    encodeStringForKey(self.area_code,NNH_area_code);
    encodeStringForKey(self.companyphone,NNH_companyphone);
}


@end
