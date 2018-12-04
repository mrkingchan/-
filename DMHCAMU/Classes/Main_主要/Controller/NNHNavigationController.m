//
//  NNHNavigationController.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/18.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHNavigationController.h"
#import "YTKNetworkAgent.h"

@interface NNHNavigationController () <UINavigationControllerDelegate>

/** 记录当前的interactivePopGestureRecognizer.delegate */
@property (nonatomic, strong) id popDelegate;

@end

@implementation NNHNavigationController

/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:@{NSFontAttributeName : [UIConfigManager fontNaviTitle],
                       NSForegroundColorAttributeName : [UIConfigManager colorNaviBarTitle]}];
    // 设置item
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // UIControlStateNormal
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = [UIConfigManager colorNaviBarTitle];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    
    // UIControlStateDisabled
    NSMutableDictionary *itemDisabledAttrs = [NSMutableDictionary dictionary];
    itemDisabledAttrs[NSForegroundColorAttributeName] = [UIConfigManager colorNaviBarTitle];
    [item setTitleTextAttributes:itemDisabledAttrs forState:UIControlStateDisabled];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NNHWeakSelf(self)
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.delegate =  weakself;
    }
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginShowPayView) name:NNH_NotificationPayView_dispalyPayView object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endDispalyPayView) name:NNH_NotificationPayView_hiddenPayView object:nil];
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        
        UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
        
        // 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
    
    // iphonex push tabbar上移问题
    if (self.tabBarController && isiPhoneX) {
        CGRect frame = self.tabBarController.tabBar.frame;
        frame.origin.y = SCREEN_HEIGHT - frame.size.height;
        self.tabBarController.tabBar.frame = frame;
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1) {
        navigationController.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}

- (void)back
{
    // 取消所有未完成的请求
    [[YTKNetworkAgent sharedAgent] cancelAllRequests];
    [SVProgressHUD dismiss];
    [self popViewControllerAnimated:YES];
}

- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.visibleViewController;
}

//支付控件显示时禁用右滑手势
- (void)beginShowPayView
{
    self.interactivePopGestureRecognizer.enabled = NO;
}

//支付控件隐藏时启用右滑手势
- (void)endDispalyPayView
{
    self.interactivePopGestureRecognizer.enabled = YES;
}

@end
