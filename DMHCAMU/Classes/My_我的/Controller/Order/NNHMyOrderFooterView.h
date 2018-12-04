//
//  NNHMyOrderFooterView.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyOrder, NNHMyOrderOperationStatusModel;

@interface NNHMyOrderFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NNHMyOrder *myOrder;
/** 刷新数据 */
@property (nonatomic, copy) void (^reloadOrderDataSourceBlock)(NNHMyOrderOperationStatusModel *order);

@end
