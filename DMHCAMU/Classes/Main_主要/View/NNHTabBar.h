//
//  NNHTabBar.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/5.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHTabBar : UITabBar

@property (nonatomic, copy) void (^clickMiddleButtonBlock)(UIButton *btn);

@end
