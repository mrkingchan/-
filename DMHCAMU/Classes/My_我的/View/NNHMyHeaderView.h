//
//  NNHMyHeaderView.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/23.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

typedef NS_ENUM(NSInteger, NNHMyHeaderViewJumpType) {
    NNHMyHeaderViewJumpTypeMyProfile = 0,    // 跳转个人资料
};

#import <UIKit/UIKit.h>
@class NNHMineModel;

@interface NNHMyHeaderView : UIImageView

@property (nonatomic, strong) NNHMineModel *mineModel;
@property (nonatomic, copy) void (^headerViewJumpBlock)(NNHMyHeaderViewJumpType type);

@end
