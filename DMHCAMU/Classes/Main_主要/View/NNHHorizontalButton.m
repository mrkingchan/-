//
//  ZPHorizontalButton.m
//  ElegantLife
//
//  Created by 牛牛 on 16/3/21.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import "NNHHorizontalButton.h"

@implementation NNHHorizontalButton

- (instancetype)initWithTitle:(NSString *)title
                        image:(NSString *)image
                    titleFont:(UIFont *)font
                   titleColor:(UIColor *)color
{
    if (self = [super init]) {
        [self setTitle:title forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        [self setTitleColor:color forState:UIControlStateNormal];
        [self.titleLabel setFont:font];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 调整文字
    CGFloat h = self.nnh_height;
    CGFloat imageH = self.imageView.nnh_height;
    
    self.titleLabel.nnh_x = 0;
    self.titleLabel.nnh_y = 0;
    self.titleLabel.nnh_height = h;
    
    // 调整图片
    self.imageView.nnh_x = self.titleLabel.nnh_width + 5;
    self.imageView.nnh_y = h *0.5 - imageH *0.5;
    self.imageView.nnh_height = imageH;
}

@end
