//
//  NNHTopView.h
//  ElegantLife
//
//  Created by 牛牛 on 16/7/29.
//  Copyright © 2016年 NNH. All rights reserved.
//

typedef void(^didClickedBlock)(void);

#import <UIKit/UIKit.h>

@interface NNHTopView : UIView

/* 拖动后当前透明度 */
@property (nonatomic, assign) CGFloat currentAlpha;
/* 点击返回 */
@property (nonatomic, copy) didClickedBlock backBlock;
/* 点击购物车 */
@property (nonatomic, copy) didClickedBlock shoppingCarBlock;

@end
