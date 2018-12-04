//
//  NNHShareHelper.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

typedef NS_ENUM(NSInteger , NNHLogingType)
{
    NNHLogingTypeWeChat = 0,
    NNHLogingTypeAlipay = 1,
};

#import <Foundation/Foundation.h>
#import "NNHSingleton.h"

@interface NNHShareHelper : NSObject
NNHSingletonH

/**
 *  注册所有平台
 *
 */
- (void)regisiterAllPlatform;

/**
 *  常用分享
 *
 *  @param content        分享内容
 *  @param title          分享标题
 *  @param imageurl       分享图片
 *  @param url            分享URL
 */
- (void)shareContent:(NSString *)content
            andTitle:(NSString *)title
            andImage:(NSString *)imageurl
              andURL:(NSString *)url;

/**
 *  分享图片
 *  @param shareImage     分享本地图片 / 网络图片
 */
- (void)shareImage:(UIImage *)shareImage shareImageUrl:(NSString *)imageUrl isLocalImage:(BOOL)localImage;


/**
 *  第三方登录
 *
 *  @param type  登录方式
 */
- (void)shareLogingWithType:(NNHLogingType)type completion:(void(^)(NSDictionary *responseDic, NSString *openid, SSDKUser *user))completionBlock;


/**
 *  是否安装微信
 *
 */
- (BOOL)isInstalledWeChat;

/**
 *  是否安装微信
 *
 */
- (BOOL)isInstalledQQ;

@end
