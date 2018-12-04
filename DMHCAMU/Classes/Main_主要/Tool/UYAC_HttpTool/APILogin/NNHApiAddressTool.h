//
//  NNHApiAddressTool.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           用户收货地址相关接口
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import "NNHBaseRequest.h"

@interface NNHApiAddressTool : NNHBaseRequest


/**
 获取收货地址列表

 @return <#return value description#>
 */
- (instancetype)initWithUserAddressList;


/**
 新增收货地址

 @param mobile 电话号码
 @param realname 收货人姓名
 @param city_id 城市编号
 @param cityName 城市名称
 @param address 详细地址
 @param isdefault 是否默认
 @return <#return value description#>
 */
- (instancetype)initNewAddressWithMobile:(NSString *)mobile
                                realname:(NSString *)realname
                                 city_id:(NSString *)city_id
                                cityName:(NSString *)cityName
                                 address:(NSString *)address
                               isdefault:(NSString *)isdefault;


/**
 设置为默认地址

 @param addressId 地址编号
 @return <#return value description#>
 */
- (instancetype)initDefaultWithAddressId:(NSString *)addressId;


/**
 <#Description#>

 @param logisticid 收货地址编号
 @param mobile 电话号码
 @param realname 收货人姓名
 @param city_id 城市编号
 @param cityName 城市名称
 @param address 详细地址
 @param isdefault 是否默认
 */
- (instancetype)initUpdateAddressWithID:(NSString *)logisticid
                                 mobile:(NSString *)mobile
                               realname:(NSString *)realname
                                city_id:(NSString *)city_id
                               cityName:(NSString *)cityName
                                address:(NSString *)address
                              isdefault:(NSString *)isdefault;

/** 删除收货地址 */
- (instancetype)initDeleteAddressWithAddressId:(NSString *)logisticid;
@end
