//
//  NNHWalletTitleView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           个人中心 钱包 顶部 信息view
 
 @Remarks          cell
 
 *****************************************************/

#import <UIKit/UIKit.h>

/** 我的钱包流水类型 */
typedef NS_ENUM(NSUInteger, NNHWalletOperationType) {
    NNHWalletOperationType_recharge = 0,      // 充值
    NNHWalletOperationType_withdraw = 1,      // 体现
};


NS_ASSUME_NONNULL_BEGIN

@interface NNHWalletTitleView : UIView

/** 钱包操作 */
@property (nonatomic, copy) void (^walletOperationBlock)(NNHWalletOperationType operationType);


@end

NS_ASSUME_NONNULL_END
