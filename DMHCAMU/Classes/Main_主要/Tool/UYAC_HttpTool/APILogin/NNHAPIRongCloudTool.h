//
//  NNHAPIRongCloudTool.h
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHAPIRongCloudTool : NNHBaseRequest

/** 根据用户token 获取融云登录token */
- (instancetype)initTokenWithUserToken:(NSString *)token;

/** 根据商铺id 获取融云客服userid */
- (instancetype)initCustomerServicesIDWithBusinessID:(NSString *)businessID;

/** 根据用户id获取用户信息 */
- (instancetype)initUserListWithUserID:(NSString *)userID;

@end
