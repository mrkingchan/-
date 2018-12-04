//
//  UIViewController+NNHUMExtension.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/1/5.
//  Copyright © 2018年 牛牛汇. All rights reserved.
//

#import "UIViewController+NNHUMExtension.h"
#import <UMMobClick/MobClick.h>
#import "NNHNavigationController.h"
#import "NNHTabBarController.h"

@implementation UIViewController (NNHUMExtension)

+ (void)load
{
    Method m1;
    Method m2;
    
    // 创建新的viewWillAppear方法
    m1 = class_getInstanceMethod(self, @selector(nn_viewWillAppear:));
    m2 = class_getInstanceMethod(self, @selector(viewWillAppear:));
    
    method_exchangeImplementations(m1, m2);
    
    // 创建新的viewWillDisappear方法
    m1 = class_getInstanceMethod(self, @selector(nn_viewWillDisappear:));
    m2 = class_getInstanceMethod(self, @selector(viewWillDisappear:));
    
    method_exchangeImplementations(m1, m2);
}

// 新的viewWillAppear方法
- (void)nn_viewWillAppear:(BOOL)animated
{
    [self nn_viewWillAppear:animated];
    
    if ([self isKindOfClass:[NNHNavigationController class]] || [self isKindOfClass:[NNHTabBarController class]]) return;
    
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

// 新的viewWillDisappear方法
- (void)nn_viewWillDisappear:(BOOL)animated
{
    [self nn_viewWillDisappear:animated];
    
    NSString *className = NSStringFromClass([self class]);
    if (![className hasPrefix:@"NNH"]) return;    
    if ([self isKindOfClass:[NNHNavigationController class]] || [self isKindOfClass:[NNHTabBarController class]]) return;
    
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

@end
