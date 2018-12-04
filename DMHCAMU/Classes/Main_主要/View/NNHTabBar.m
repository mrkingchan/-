//
//  NNHTabBar.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/5.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHTabBar.h"

@interface NNHTabBar ()

@property (nonatomic, strong) UIButton *nnhButton;

@end

@implementation NNHTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.nnhButton];
        
        self.nnhButton.nnh_size = self.nnhButton.currentImage.size;
    }
    return self;
}

/**
 *  加号按钮点击
 */
- (void)middleAction:(UIButton *)btn
{
    if (self.clickMiddleButtonBlock) self.clickMiddleButtonBlock(btn);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    self.nnhButton.nnh_centerX = self.nnh_width * 0.5;

    // 6 圆环的高度 34 底部安全区域的高度
    self.nnhButton.nnh_centerY = self.nnh_height * 0.5 - 6 - (NNHBottomSafeHeight) *0.5;
    
    // 2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.nnh_width / 5;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            
            // 设置宽度
            child.nnh_width = tabbarButtonW;
            // 设置x
            child.nnh_x = tabbarButtonIndex * tabbarButtonW;
            
            // 增加索引
            tabbarButtonIndex++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
}

- (UIButton *)nnhButton
{
    if (_nnhButton == nil) {
        _nnhButton = [UIButton NNHBtnImage:@"ic_home_logo" target:self action:@selector(middleAction:)];
        _nnhButton.adjustsImageWhenHighlighted = NO;
    }
    return _nnhButton;
}

@end
