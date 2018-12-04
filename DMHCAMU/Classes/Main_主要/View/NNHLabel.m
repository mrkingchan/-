//
//  NNHLabel.m
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/26.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHLabel.h"

@implementation NNHLabel

/** 自定义Label **/
+ (NNHLabel *)NNHWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font
{
    NNHLabel *label = [[NNHLabel alloc] init];
    label.text = title;
    label.textColor = titleColor;
    label.font = font;
    return label;    
}

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
