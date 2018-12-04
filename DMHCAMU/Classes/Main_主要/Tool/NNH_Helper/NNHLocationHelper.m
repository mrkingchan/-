//
//  NNHLocationHelper.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/4.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#define LocationTimeout 3  //   定位超时时间，可修改，最小2s
#define ReGeocodeTimeout 3 //   逆地理请求超时时间，可修改，最小2s

#import "NNHLocationHelper.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface   NNHLocationHelper()<AMapLocationManagerDelegate>

/** 获取地理位置的manger，但是这里是初始化，我个人认为，我封成单例会比较好，因为该项目我觉得一般来讲只用于打开一瞬间瞬间定位一次 **/
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end


static NNHLocationHelper *handle;

@implementation NNHLocationHelper

+(instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[NNHLocationHelper alloc] init];
    });
    
    return handle;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        [[AMapServices sharedServices] setEnableHTTPS:NO];
        [AMapServices sharedServices].apiKey = NNH_MAMapSDKAppKey;
    }
    return self;
}

- (void)cleanUpAction
{
    [self.locationManager stopUpdatingLocation];

    [self.locationManager setDelegate:nil];
    self.locationManager = nil;
}

//持续定位 有反编码
- (void)reGeocodeAction
{
    [self.locationManager startUpdatingLocation];
}

- (BOOL)isOpenLocationService
{
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
            return YES;
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        return  NO;
    }
    return NO;
}

#pragma mark -
#pragma mark ---------AMapLocationManagerDelegate
/** 定位成功 */
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    self.location = location;

    CLLocationCoordinate2D coordinate = location.coordinate;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSString stringWithFormat:@"%f",coordinate.latitude] forKey:NNH_User_CurrentLocation_latitude];
    [userDefaults setObject:[NSString stringWithFormat:@"%f",coordinate.longitude] forKey:NNH_User_CurrentLocation_longitude];
    [userDefaults setObject:reGeocode.city forKey:NNH_User_CurrentLocation_cityName];
    [userDefaults synchronize];
    self.getLocationFlag = YES;
    if (reGeocode.city) {
        NSMutableDictionary *locationDict = [NSMutableDictionary dictionary];
        locationDict[@"cityName"] = reGeocode.city;
        locationDict[@"isLocation"] = @"1";   //是否是已成功定位
        [[NSNotificationCenter defaultCenter] postNotificationName:NNH_NotificationLocation_UserLocation object:nil userInfo:locationDict];
    }
}

/** 定位失败 */
- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
//    NSMutableDictionary *locationDict = [NSMutableDictionary dictionary];
//    locationDict[@"cityName"] = [self getTempLocationCity];
//    locationDict[@"isLocation"] = @"0";   //是否是已成功定位
//    [[NSNotificationCenter defaultCenter] postNotificationName:NNH_NotificationLocation_UserLocation object:nil userInfo:locationDict];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways
        || status == kCLAuthorizationStatusNotDetermined||status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
    }else {

    }
}

//持续定位
- (AMapLocationManager *)locationManager
{
    if (_locationManager == nil) {
        _locationManager = [[AMapLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 200;
        _locationManager.locatingWithReGeocode = YES;
        [_locationManager setPausesLocationUpdatesAutomatically:NO];
    }
    return _locationManager;
}

/** 没有定位到的时候，获取定位城市 */
- (NSString *)getTempLocationCity  
{
    NSString *userLocationCity;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *currentCity = [userDefaults objectForKey:NNH_User_CurrentLocation_cityName];
    NSString *lastCityName = [userDefaults objectForKey:NNH_User_Location_lastSaveCityName];
    
    if (currentCity) {

        userLocationCity = currentCity;
    }else {
        if (lastCityName) {
            userLocationCity = lastCityName;
        }else {
            userLocationCity = @"深圳市";
        }
    }
    return userLocationCity;
}

@end

