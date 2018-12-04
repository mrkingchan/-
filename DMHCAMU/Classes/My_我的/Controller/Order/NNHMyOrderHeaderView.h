//
//  NNHMyOrderHeaderView.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyOrder;

@interface NNHMyOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) NNHMyOrder *myOrder;
/** 是否显示右边状态 默认显示YES */
@property (nonatomic, assign, getter=isShowArrowOrderStatusLabel) BOOL showArrowOrderStatusLabel;
/** 跳转到商家实体店 */
@property (nonatomic, copy) void(^jumpMerchantShopBlock)(NSString *ID);

@end
