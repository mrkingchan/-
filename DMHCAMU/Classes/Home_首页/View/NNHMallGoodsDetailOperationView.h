//
//  NNHMallGoodsDetailOperationView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMallGoodsDetailModel;

typedef NS_ENUM(NSInteger ,NNHMallGoodsDetailBottomOperationType) {
    NNHMallGoodsDetailBottomOperationType_collection = 0,   // 关注
    NNHMallGoodsDetailBottomOperationType_message = 1,      // 咨询
    NNHMallGoodsDetailBottomOperationType_addCart = 2,      // 预定
};


NS_ASSUME_NONNULL_BEGIN

@interface NNHMallGoodsDetailOperationView : UIView

/** 商品数据 */
@property (nonatomic, strong) NNHMallGoodsDetailModel *goodsModel;

@property (nonatomic, copy) void (^operationViewJumpBlock)(NNHMallGoodsDetailBottomOperationType type);

@end

NS_ASSUME_NONNULL_END
