//
//  NNHMyOrderCell.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyOrderItem, NNHMyOrderOperationStatusModel;

@interface NNHMyOrderCell : UITableViewCell

/** 模型数据 */
@property (nonatomic, strong) NNHMyOrderItem *orderItem;

/** 商品状态（退款／退货） */
@property (nonatomic, copy) void(^clickOperatingButtonBlock)(NNHMyOrderOperationStatusModel *operationStatus);

@end
