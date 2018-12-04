//
//  NNHLocationHelper.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;

@interface NNHLocationHelper : NSObject

/** 初始化方法只有一次 **/
+ (instancetype)sharedInstance;

/** 开始定位,初始化会调用一次定位，但是如果后面还需要调用定位则需调用这个方法**/
- (void)reGeocodeAction;

/** 定位回调 **/
@property (nonatomic,copy) void (^getLocationWithTitleBlock)(CLLocation *location, NSString *cityName, NSString *cityCode, NSString *districtName, NSError *error);

/** 经纬度 **/
@property (nonatomic, strong) CLLocation *location;

/** 是否打开了定位 **/
@property (nonatomic,assign)BOOL isOpenLocationService;

/** 获取到位置信息 */
@property (nonatomic, assign) BOOL getLocationFlag;

@end
