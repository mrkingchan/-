//
//  NNHOrderOperationButton.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyOrderOperationStatusModel;

@interface NNHOrderOperationButton : UIButton

@property (nonatomic, strong) NNHMyOrderOperationStatusModel *orderOperationStatus;

@end
