//
//  NNHShareHelper.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHShareHelper.h"
#import "NNHShareView.h"
#import "NNHApiLoginTool.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

@interface NNHShareHelper () <NNHShareViewDelegate>

@property (nonatomic, strong) NNHShareView *shareView;
@property (nonatomic, strong) NSMutableDictionary *shareParams;

@end

@implementation NNHShareHelper
NNHSingletonM

- (void)regisiterAllPlatform
{
    [ShareSDK registerActivePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSMS)
                            ]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:NNH_ShareSDK_WEIXIN_APPID_INDEX
                                       appSecret:NNH_ShareSDK_WEIXIN_SECRET_INDEX];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:NNH_ShareSDK_QQ_AppID
                                      appKey:NNH_ShareSDK_QQ_AppKey
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
}

/**
 *  分享内容
 *
 *  @param content        分享内容
 *  @param title          分享标题
 *  @param imageurl       分享图片
 *  @param url            分享URL
 */
- (void)shareContent:(NSString *)content
            andTitle:(NSString *)title
            andImage:(NSString *)imageurl
              andURL:(NSString *)url
{
    //创建分享参数
    if (title == nil || [title isEqualToString:@""]) title = @"中天寰宇";
    
    if (imageurl.length) {
        [self.shareParams SSDKSetupShareParamsByText:content
                                              images:@[imageurl] //传入要分享的图片
                                                 url:[NSURL URLWithString:url]
                                               title:title
                                                type:SSDKContentTypeAuto];
    }else{
        [self.shareParams SSDKSetupShareParamsByText:content
                                              images:@[[UIImage imageNamed:@"image_pacehold"]] //传入默认的图片
                                                 url:[NSURL URLWithString:url]
                                               title:title
                                                type:SSDKContentTypeAuto];
    }
    
//    // 使用客户端分享
//    [self.shareParams SSDKEnableUseClientShare];
    
    // 显示分享view
    [self.shareView show];
}

- (void)shareImage:(UIImage *)shareImage shareImageUrl:(NSString *)imageUrl isLocalImage:(BOOL)localImage
{
    //创建分享参数
    [self.shareParams removeAllObjects];
    
    [self.shareParams SSDKSetupShareParamsByText:nil
                                          images:@[localImage ? shareImage : imageUrl] //传入要分享的图片
                                             url:nil
                                           title:@"中天寰宇"
                                            type:SSDKContentTypeAuto];
    
    // 显示分享view
    [self.shareView show];
}

- (void)shareView:(NNHShareView *)shareView didSelectedShareType:(NNHShareType)type
{
    SSDKPlatformType platformType;
    switch (type) {
        case NNHShareSMS:
            platformType = SSDKPlatformTypeSMS;
            break;
        case NNHShareQQ:
            platformType = SSDKPlatformSubTypeQQFriend;
            break;
        case NNHShareQQSpace:
            platformType = SSDKPlatformSubTypeQZone;
            break;
        case NNHShareWeiXin:
            platformType = SSDKPlatformSubTypeWechatSession;
            break;
        case NNHShareWeiXinFriend:
            platformType = SSDKPlatformSubTypeWechatTimeline;
            break;
    }
    
    // 如果是短信分享 需要将文本与URL拼接
    if (platformType == SSDKPlatformTypeSMS) {
        NSString *text = [NSString stringWithFormat:@"%@%@%@",self.shareParams[@"title"],self.shareParams[@"text"],self.shareParams[@"url"]];
        [self.shareParams setObject:text forKey:@"text"];
        
        // 短信分享不要图片
        [self.shareParams removeObjectForKey:@"images"];
    }
    
    [ShareSDK share:platformType //传入分享的平台类型
         parameters:self.shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) { // 回调处理....
         if (state == SSDKResponseStateSuccess) {
             [SVProgressHUD showMessage:@"分享成功"];
         }else{
             [SVProgressHUD showMessage:@"分享失败"];
         }
     }];
}

- (void)shareLogingWithType:(NNHLogingType)type completion:(void(^)(NSDictionary *responseDic, NSString *openid, SSDKUser *user))completionBlock
{
    SSDKPlatformType logingType = 0;
    NSString *typeStr = @"";
    switch (type) {
        case NNHLogingTypeWeChat:
            logingType = SSDKPlatformTypeWechat;
            typeStr = @"weixin";
            break;
        default:
            logingType = SSDKPlatformTypeAliSocial;
            typeStr = @"weixin";
            break;
    }
    
    [ShareSDK getUserInfo:logingType
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess){             
//             NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initWithLoginType:typeStr openid:user.uid nickname:user.nickname sex:[NSString stringWithFormat:@"%@",user.rawData[@"sex"]] province:user.rawData[@"province"] city:user.rawData[@"city"] country:user.rawData[@"country"] headimgurl:user.icon unionid:user.rawData[@"unionid"] privilege:@""];
//             [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//                 completionBlock(responseDic,user.uid,user);
//             } failBlock:^(NNHRequestError *error) {
//                 
//             } isCached:NO];
         }
     }];
}

- (NSMutableDictionary *)shareParams
{
    if (_shareParams == nil) {
        _shareParams = [NSMutableDictionary dictionary];
    }
    return _shareParams;
}

- (NNHShareView *)shareView
{
    if (_shareView == nil) {
        _shareView = [NNHShareView shareView];
        _shareView.delegate = self;
    }
    return _shareView;
}

// 判断是否安装分享载体
- (BOOL)isInstalledWeChat
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]];
}

- (BOOL)isInstalledQQ
{
    return [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]];
}

@end
