//
//  NNHTabBarController.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/18.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHTabBarController.h"
#import "NNHomeViewController.h"
#import "NNHMallCategoryViewController.h"
#import "NNMessageViewController.h"
#import "NNMyViewController.h"
#import "NNHNavigationController.h"

//#import "NNHVerifyMobileController.h"
//#import "NNSetupPayPasswordViewController.h"
//#import "NNHMyBalanceViewController.h"
//#import "NNHPrefectureController.h"
#import "UITabBar+NNHExtension.h"
#import "NNHAlertTool.h"

@interface NNHTabBarController () <UITabBarControllerDelegate>

@end

@implementation NNHTabBarController

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBar属性
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
    [UITabBar appearance].translucent = NO;
    
    // 去掉横线
//    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIConfigManager fontThemeTextMinTip];
    attrs[NSForegroundColorAttributeName] = [UIConfigManager colorTabBarTitleDefault];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIConfigManager colorTabBarTitleHeight];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.delegate = self;

    // 添加子控制器
    [self setupChildVc:[[NNHomeViewController alloc] init] title:@"首页" image:@"ic_commodity" selectedImage:@"ic_commodity_pressed"];
    [self setupChildVc:[[NNHMallCategoryViewController alloc] init] title:@"分类" image:@"ic_category" selectedImage:@"ic_category_pressed"];
    [self setupChildVc:[[NNMessageViewController alloc] init] title:@"消息" image:@"ic_message" selectedImage:@"ic_message_pressed"];
    [self setupChildVc:[[NNMyViewController alloc] init] title:@"我的" image:@"ic_mine" selectedImage:@"ic_mine_pressed"];
    [self addPayNotification];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 包装一个导航控制器, 添加导航控制器为tabbarcontroller的子控制器
    NNHNavigationController *nav = [[NNHNavigationController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NNHNavigationController *nav = (NNHNavigationController *)viewController;
    if ([nav.topViewController isKindOfClass:[NNMyViewController class]] || [nav.topViewController isKindOfClass:[NNMessageViewController class]]) {
        NNHWeakSelf(self)
        if ([[NNHProjectControlCenter sharedControlCenter] loginStatus:YES complete:^{
            [weakself setSelectedViewController:viewController];
        }]) { // 登录中
            return YES;
        }else{
            return NO;
        }
    }
    return YES;
}

- (void)addPayNotification
{
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePayRechargeBlock:) name:NNH_NotificationPayTool_toAccountRecharge object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePaySetCodeBlock:) name:NNH_NotificationPayTool_setupPayCode object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handlePayUpdateCodeBlock:) name:NNH_NotificationPayTool_updatePayCode object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:NNH_NotificationMessage_messageCenterGetNewMessage object:nil];
}

- (void)receiveMessage:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tabBar showBadge];
    });
}

//- (void)handlePayRechargeBlock:(NSNotification *)notication
//{
//    NNHMyBalanceViewController *mobileVc = [[NNHMyBalanceViewController alloc] init];
//    [self.selectedViewController pushViewController:mobileVc animated:YES];
//}
//
//- (void)handlePaySetCodeBlock:(NSNotification *)notication
//{
//    NNSetupPayPasswordViewController *paycodeVc = [[NNSetupPayPasswordViewController alloc] initWithFromType:NNHChangePayCodeFromType_FistChange];
//    [self.selectedViewController pushViewController:paycodeVc animated:YES
//     ];
//}
//
//- (void)handlePayUpdateCodeBlock:(NSNotification *)notication
//{
//    NNHVerifyMobileController *mobileVc = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_changePayPassword];
//    [self.selectedViewController pushViewController:mobileVc animated:YES];
//}
@end
