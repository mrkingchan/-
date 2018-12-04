//
//  NNHApiAddressTool.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHApiAddressTool.h"

@implementation NNHApiAddressTool

- (instancetype)initWithUserAddressList
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_LogisticsList;
        self.reAPIName = @"获取收货地址列表";
    }
    return self;
}

/** 新增收货地址 */
- (instancetype)initNewAddressWithMobile:(NSString *)mobile
                                realname:(NSString *)realname
                                 city_id:(NSString *)city_id
                                cityName:(NSString *)cityName
                                 address:(NSString *)address
                               isdefault:(NSString *)isdefault
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_AddCustomerLogistic;
        self.reAPIName = @"添加收货地址";
        
        self.reParams = @{
                            @"mobile"       : mobile,
                            @"realname"     : realname,
                            @"city_id"      : city_id,
                            @"city"         : cityName,
                            @"address"      : address,
                            @"isdefault"    : isdefault,
                          };
    }
    return self;
}

/** 设置默认收货地址 */
- (instancetype)initDefaultWithAddressId:(NSString *)addressId
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_SetDefaultlogistic;
        self.reAPIName = @"设置默认收货地址";

        self.reParams = @{
                          @"logisticid"     : addressId,
                          };
    }
    return self;
}

/** 编辑收货地址 */
- (instancetype)initUpdateAddressWithID:(NSString *)logisticid
                                 mobile:(NSString *)mobile
                               realname:(NSString *)realname
                                city_id:(NSString *)city_id
                               cityName:(NSString *)cityName
                                address:(NSString *)address
                              isdefault:(NSString *)isdefault
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_UpdateCustomerLogistic;
        self.reAPIName = @"编辑收货地址";
        
        self.reParams = @{
                          @"logisticid"   : logisticid,
                          @"mobile"       : mobile,
                          @"realname"     : realname,
                          @"city_id"      : city_id,
                          @"city"         : cityName,
                          @"address"      : address,
                          @"isdefault"    : isdefault,
                          };
    }
    return self;
}

/** 删除收货地址 */
- (instancetype)initDeleteAddressWithAddressId:(NSString *)logisticid
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_DelCustomerLogistic;
        self.reAPIName = @"删除收货地址";
        
        self.reParams = @{
                          @"logisticid"     : logisticid,
                          };
    }
    return self;
}

@end
