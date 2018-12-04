//
//  NNHAPIRongCloudTool.m
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAPIRongCloudTool.h"

@implementation NNHAPIRongCloudTool

/** 根据用户token 获取融云登录token */
- (instancetype)initTokenWithUserToken:(NSString *)token
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"msg.index.gettoken";
        self.reAPIName = @"融云获取用户token";
        self.reParams = @{
                          @"mtoken" : token,
                          };
    }
    return self;
}

/** 根据商铺id 获取融云客服userid */
- (instancetype)initCustomerServicesIDWithBusinessID:(NSString *)businessID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"msg.index.getbusinesstoken";
        self.reAPIName = @"根据商铺id 获取融云客服userid";
        self.reParams = @{
                          @"businessid" : businessID,
                          };
    }
    return self;
}

/** 根据用户id获取用户信息 */
- (instancetype)initUserListWithUserID:(NSString *)userID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"msg.index.getuserinfo";
        self.reAPIName = @"根据userid 获取user信息";
        self.reParams = @{
                          @"userid" : userID,
                          };
    }
    return self;
}

@end
