//
//  UIWindow+NNHExtension.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/25.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "UIWindow+NNHExtension.h"
#import "NNHTabBarController.h"
#import "NNHNavigationController.h"
#import "NNHGuideViewController.h"
#import "NNHAPIHomeTool.h"
#import "NNHBannerModel.h"
#import "NNHAdView.h"
#import "NNHJumpHelper.h"
#import "NSDate+NNHExtension.h"

@implementation UIWindow (NNHExtension)

static NSString *const versionKey = @"CFBundleVersion";
static NSString *const adShowTypeKey = @"adShowTypeKey"; // 广告展示方式
- (void)changeWindowRootViewController
{
//    // 从沙盒读取上次的存储的版本号
//    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
//    
//    // 从plist文件中读取当前版本号
//    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
//    
//    if ([currentVersion isEqualToString:lastVersion]) {
    
        self.rootViewController = [[NNHTabBarController alloc] init];
        
        // 获取广告数据
        [self requestAdvertData];
        
        
//    }else{
//        
//        self.rootViewController = [[NNHGuideViewController alloc] init];
//        
//        // 将当前版本号存储到沙盒
//        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    
}

- (void)requestAdvertData
{
    // 1、 获取广告数据
    NNHWeakSelf(self)
    NNHAPIHomeTool *adTool = [[NNHAPIHomeTool alloc] initAdvert];
    [adTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        NNHBannerModel *adModel = [NNHBannerModel mj_objectWithKeyValues:responseDic[@"data"]];
        
        // 配置广告
        if (adModel && ![NSString isEmptyString:adModel.bannerThumb]) {
            [weakself setupAdvertWith:adModel];
        }
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
    
    
}

- (void)setupAdvertWith:(NNHBannerModel *)adModel
{
    // 根据图片url判断广告是否需要更新
    // 检测一张图片是否已被缓存.
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    
    // 首先检测内存缓存是否存在这张图片,如果已有,直接返回yes. 如果内存缓存里没有这张图片,那么调用diskImageExistsWithKey这个方法去硬盘缓存里找
    NNHWeakSelf(self)
    [manager cachedImageExistsForURL:[NSURL URLWithString:adModel.bannerThumb] completion:^(BOOL isInCache) {
        
        // 获取ad展示方式 (每次都展示/每天只展示一次)
        NSString *adShowTime = [[NSUserDefaults standardUserDefaults] objectForKey:adShowTypeKey];
        
        if (isInCache) {
            if ([adModel.banner_type integerValue] == 1) { // 有缓存展示广告 且 每次都启动
                
                [weakself setupAdViewWithAdModel:adModel];
                
            }else{
                
                if (![adShowTime isEqualToString:[[NSDate date] stringWithFormat:@"yyyy-MM-dd"]]) {
                    
                    // 标记展示方式
                    adShowTime = [[NSDate date] stringWithFormat:@"yyyy-MM-dd"];
                    
                    // 有缓存展示广告 且 每天只启动一次
                    [weakself setupAdViewWithAdModel:adModel];
                }
            }
        }else{
            // 标记展示方式
            adShowTime = @"";
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [manager loadImageWithURL:[NSURL URLWithString:adModel.bannerThumb]
                                  options:SDWebImageRefreshCached
                                 progress:nil
                                completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
                                    
                                }];
                
            });
        }
        
        // 存储当前展示方式
        [[NSUserDefaults standardUserDefaults] setObject:adShowTime forKey:adShowTypeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }];
}

- (void)setupAdViewWithAdModel:(NNHBannerModel *)adModel
{
    NNHAdView *adView = [[NNHAdView alloc] init];
    adView.filePath = adModel.bannerThumb;
    if ([adModel.time integerValue] > 0) adView.timeout = [adModel.time integerValue];
    adView.adJumpBlock = ^{
        NNHTabBarController *tabBarC = (NNHTabBarController *)self.rootViewController;
        NNHNavigationController *navC = tabBarC.selectedViewController;
        [[NNHJumpHelper sharedInstance] jumpToDifferenceViewControllerWithBannerModel:adModel viewController:navC.topViewController];
    };
    [adView show];
}

@end
