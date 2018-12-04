//
//  NNHApplicationHelper.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/31.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHApplicationHelper.h"
//#import "NNHRealNameViewController.h"
#import "UIViewController+NNHExtension.h"
#import <WebKit/WebKit.h>
#import "NNHAlertTool.h"
#import "NNHMessageManager.h"

@interface NNHApplicationHelper () <UIActionSheetDelegate, WKNavigationDelegate>

@end

@implementation NNHApplicationHelper
NNHSingletonM

/** 打开系统设置 */
- (void)openApplcationSetting
{
    NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark --
#pragma mark -- 打电话
- (void)openPhoneNum:(NSString *)phoneNum InView:(UIView *)view
{
    NSString *phone = [NSString stringWithFormat:@"tel:%@",phoneNum];
    WKWebView *phoneCallWebView = [[WKWebView alloc] init];
    phoneCallWebView.navigationDelegate = self;
    [phoneCallWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:phone]]];
    [view addSubview:phoneCallWebView];
}

- (void)openQQWithQQNumber:(NSString *)qqNum
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://wpa.b.qq.com/cgi/wpa.php?ln=2&uin=%@",qqNum]]];
}

//判断实名认证
- (BOOL)isRealName
{
    if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth isEqualToString:@"1"]) {
        return YES;
    }else if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth isEqualToString:@"2"]) {
        [SVProgressHUD showMessage:@"实名认证审核中"];
        return NO;
    }else {
        UIViewController *currentVC = [UIViewController currentViewController];
        [[NNHAlertTool shareAlertTool] showAlertView:currentVC title:@"您还未实名认证，请完善实名认证！" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"去认证" confirm:^{
//            NNHRealNameViewController *vc = [[NNHRealNameViewController alloc] init];
//            [currentVC.navigationController pushViewController:vc animated:YES];
        } cancle:^{
            
        }];
        return NO;
    }
}

- (void)logingOut
{
    // 清除用户相关模型
    [[NNHProjectControlCenter sharedControlCenter] userControl_removeCurrentLoginUserFile];
    [[NNHProjectControlCenter sharedControlCenter] userControl_currentUserModel].mtoken = @"";
    
    // 断开融云
    [[NNHMessageManager shareManager] disconnent];
}

#pragma mark --
#pragma mark -- 更新支付密码
- (void)updatePayPassword
{
//    UIViewController *currentController = [UIViewController currentViewController];
//    NNHUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
//    if (![userModel.payDec isEqualToString:@"1"]) {
//        NNHChangePayCodeController *paycodeVc = [[NNHChangePayCodeController alloc] initWithFromType:NNHChangePayCodeFromType_FistChange];
//        [currentController.navigationController pushViewController:paycodeVc animated:YES
//         ];
//    }else {
//        NNHVerifyMobileController *mobileVc = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_changePayPassword];
//        [currentController.navigationController pushViewController:mobileVc animated:YES];
//    }
}

@end
