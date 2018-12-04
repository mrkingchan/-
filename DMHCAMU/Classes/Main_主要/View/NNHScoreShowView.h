//
//  NNHScoreShowView.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//  评分显示

#import <UIKit/UIKit.h>

@interface NNHScoreShowView : UIView

/** starsW星星的宽度 */
- (instancetype)initWithStarsW:(CGFloat)starsW;

@property (nonatomic, assign) CGFloat score;

@end
