//
//  AppDelegate.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/2/27.
//  Copyright © 2017年 牛牛. All rights reserved.
//

#import "NNHAppDelegate.h"
#import "YTKNetworkConfig.h"
#import "NNHShareHelper.h"
#import "NNHPayMentHelper.h"
#import "NNHMessageManager.h"
#import "AFNetworkReachabilityManager.h"
#import "UIWindow+NNHExtension.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "NNHLocationHelper.h"

@interface NNHAppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation NNHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // 网络监测上传当前环境
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // 配置服务器地址
    [self netWorkConfig];
    
    //注册通知
    [self configPushDataWithApplication:application];
    
    // 配置第三方
    [[NNHProjectControlCenter sharedControlCenter].proConfig startGetLocation];
    [[NNHProjectControlCenter sharedControlCenter].proConfig setupIQKeyboardManager];
    [[NNHProjectControlCenter sharedControlCenter].proConfig startUMeng];
    
    // 切换根控制器
    [self.window changeWindowRootViewController];
    
    //登录融云
    [[NNHMessageManager shareManager] configRongCloud];
    
    //注册微信支付
    [WXApi registerApp:NNH_ShareSDK_WEIXIN_APPID_INDEX];
    
    // 注册分享
    [[NNHShareHelper sharedInstance] regisiterAllPlatform];
    
    // webView内存优化
    [self webviewOP];

    //处理iOS 10以上后台通知
    [self handlePushDataWithOptions:launchOptions];
    
    [NSThread sleepForTimeInterval:1.5f];

    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)handlePushDataWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *notificationDict = [launchOptions valueForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    BOOL notice = notificationDict ? YES : NO;
    if(notice && !UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")){ // 10.0以上会自动处理推送消息 其他需手动处理
        [self changeCurrentDispalyController];
    }
}

/** 注册推送 */
- (void)configPushDataWithApplication:(UIApplication *)application
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) { // 点击允许
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                }];
            } else { // 点击不允许
                
            }
        }];
    }else{
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
        
    }
    // 注册获得device Token
    [[UIApplication sharedApplication] registerForRemoteNotifications];
}

#pragma mark ---------NetWorkConfig
- (void)netWorkConfig
{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    // 环境 http://www.niuniuhuiapp.net:82/   http://192.168.1.16:82/
    config.baseUrl = [[NNHProjectControlCenter sharedControlCenter] Config_isTestMode] ? @"http://www.niuniuhuiapp.net:30989/" :  @"http://wfccmallapi.zthycbec.com/";
    config.cdnUrl = [[NNHProjectControlCenter sharedControlCenter] Config_isTestMode] ? @"http://www.niuniuhuiapp.net:30994/" : @"http://wfccmallm.zthycbec.com/";
}

#pragma mark -
#pragma mark ---------webView内存优化
- (void)webviewOP
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        int cacheSizeMemory = 4*1024*1024; // 4MB
        int cacheSizeDisk = 32*1024*1024; // 32MB
        NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
        [NSURLCache setSharedURLCache:sharedCache];
    });
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    application.applicationIconBadgeNumber = 0;
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
/** 是否有这个字段 **/
- (BOOL)thisStr:(NSString *)thisStr andisHaveStr:(NSString *)str
{
    //在str1这个字符串中搜索\n，判断有没有
    if ([thisStr rangeOfString:str].location != NSNotFound) {
        return YES;
    }
    return NO;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSString * urlSbsouluteStr = [url absoluteString];
    if ([self thisStr:urlSbsouluteStr andisHaveStr:@"uppayresult"]) { // 银联回调
        //        [self handlUpPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"safepay"]) { // 支付宝授权回调
        [self handleAliPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"wx"]&&![self thisStr:urlSbsouluteStr andisHaveStr:@"oauth"]){ // 微信支付回调
        [self handleWeiXinWithUrl:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary*)options
{
    NSString * urlSbsouluteStr = [url absoluteString];
    if ([self thisStr:urlSbsouluteStr andisHaveStr:@"uppayresult"]) { // 银联回调
        //        [self handlUpPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"safepay"]) { // 支付宝授权回调
        [self handleAliPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"wx"]&&![self thisStr:urlSbsouluteStr andisHaveStr:@"oauth"]){ // 微信支付回调
        [self handleWeiXinWithUrl:url];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSString * urlSbsouluteStr = [url absoluteString];
    if ([self thisStr:urlSbsouluteStr andisHaveStr:@"uppayresult"]) { // 银联回调
        //        [self handlUpPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"safepay"]) { // 支付宝授权回调
        [self handleAliPayWithUrl:url];
    }else if ([self thisStr:urlSbsouluteStr andisHaveStr:@"wx"]&&![self thisStr:urlSbsouluteStr andisHaveStr:@"oauth"]){ // 微信支付回调
        [self handleWeiXinWithUrl:url];
    }
    return YES;
}

#pragma mark-------支付回调
/** 微信支付回调 **/
- (void)handleWeiXinWithUrl:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:(id)[NNHPayMentHelper shareInstance]];
}

- (void)handleAliPayWithUrl:(NSURL *)url
{
    //支付回调
    [[NNHPayMentHelper shareInstance] handleAliPayWithUrl:url];
    
    // 授权跳转支付宝钱包进行支付，处理支付结果
    [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {

        [[NSNotificationCenter defaultCenter] postNotificationName:NNH_NotificationLocation_alipayAuthCallback object:resultDic];
    }];
}

#pragma mark-------推送
//注册用户通知设置
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}

/**
 * 推送处理3
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    NNHLog(@"pushtoken = %@",token);
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:token forKey:NNH_User_Device_push_token];
    [userDefaults synchronize];
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler
{
    completionHandler(UIBackgroundFetchResultNewData);
}


#pragma mark - UNUserNotificationCenterDelegate
//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受

    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler{
//    NSDictionary * userInfo = response.notification.request.content.userInfo;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) { //应用处于后台时的远程推送接受
        NNHLog(@"远程推送");
    }else{ //应用处于后台时的本地推送接受
        NNHLog(@"本地推送");
    }
    [self changeCurrentDispalyController];
    completionHandler();
}

//进入到消息界面
- (void)changeCurrentDispalyController
{
    // 获取导航控制器
    UIViewController *currntVc = (UITabBarController *)self.window.rootViewController;
    if (![currntVc isKindOfClass:[UITabBarController class]]) return;
    
    UITabBarController *tabVC = (UITabBarController *)currntVc;
    UINavigationController *pushClassStance = tabVC.selectedViewController;
    
    // 跳转到对应的控制器
    [pushClassStance popToRootViewControllerAnimated:NO];
    
    [tabVC setSelectedIndex:2];
}

@end
