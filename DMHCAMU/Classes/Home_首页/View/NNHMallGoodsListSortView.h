//
//  NNHMallGoodsListSortView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/23.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NNHMallGoodsListSortView : UIView


/**
 点击筛选按钮回调
 */
@property (nonatomic, copy) void (^didSelectedSortButtonBlock)(NSString *sortString, NSInteger index);

@end

NS_ASSUME_NONNULL_END
