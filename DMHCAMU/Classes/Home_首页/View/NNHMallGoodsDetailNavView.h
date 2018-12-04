//
//  NNHMallGoodsDetailNavView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didClickedBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface NNHMallGoodsDetailNavView : UIView

/* 拖动后当前透明度 */
@property (nonatomic, assign) CGFloat currentAlpha;
/* 点击返回 */
@property (nonatomic, copy) didClickedBlock backBlock;
/* 点击购物车 */
@property (nonatomic, copy) didClickedBlock shoppingCarBlock;

@end

NS_ASSUME_NONNULL_END
