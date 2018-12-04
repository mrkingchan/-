//
//  NNHCountDownButton.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHCountDownButton : UIButton

@property (nonatomic, strong) UIColor *bgNormalColor;
@property (nonatomic, strong) UIColor *bgCountingColor;


@property (nonatomic, strong) UIColor *lbNormalColor;
@property (nonatomic, strong) UIColor *lbCountingColor;

/** 当前数值 **/
@property (nonatomic, assign) NSUInteger curSec;

/** 计时长度**/
@property (nonatomic, assign) NSUInteger totalSec;

- (instancetype)initWithTotalTime:(NSUInteger)totalTime titleBefre:(NSString *)titleBefore titleConting:(NSString *)titleCounting titleAfterCounting:(NSString *)titleAfter clickAction:(void(^)(NNHCountDownButton *countBtn))clickAction;

- (void)startCounting;
- (void)resetButton;

@end
