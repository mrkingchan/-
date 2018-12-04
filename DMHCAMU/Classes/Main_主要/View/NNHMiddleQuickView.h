//
//  NNHMiddleQuickView.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

typedef NS_ENUM(NSInteger, NNHButtonJumpType) {
    NNHButtonJumpType_moneyQuick = 1,  // 现金专区
    NNHButtonJumpType_hybridQuick = 2,  // 现金+牛豆专区
    NNHButtonJumpType_ndQuick = 3,  // 牛豆专区
    NNHButtonJumpType_scan = 4,  // 扫一扫
    NNHButtonJumpType_pay = 5,  // 收付款
};

#import <UIKit/UIKit.h>

@interface NNHMiddleQuickView : UIView

@property (nonatomic, copy) void (^didSelectedButtonBlock)(NNHButtonJumpType type);

- (void)show;

@end
