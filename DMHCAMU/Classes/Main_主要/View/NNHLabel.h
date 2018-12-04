//
//  NNHLabel.h
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/26.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHLabel : UILabel

/** 控制字体与控件边界的间隙 */
@property (nonatomic, assign) UIEdgeInsets textInsets;

+ (NNHLabel *)NNHWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font;

@end
