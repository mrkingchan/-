//
//  NNHTopView.m
//  ElegantLife
//
//  Created by 牛牛 on 16/7/29.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import "NNHTopView.h"

@interface NNHTopView ()

/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 分享按钮 */
@property (nonatomic, strong) UIButton *shoppingCarButton;
/** 底部横线 */
@property (nonatomic, weak) UIView *bottomLine;

@end

@implementation NNHTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHNavBarViewHeight)]) {
        
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.0];
        
        UIView *bottomLine = [UIView lineView];
        bottomLine.hidden = YES;
        
        [self addSubview:self.backButton];
        [self addSubview:self.shoppingCarButton];
        [self addSubview:bottomLine];
        self.bottomLine = bottomLine;
        
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(NNHMargin_10);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        [self.shoppingCarButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backButton);
            make.right.equalTo(self).offset(-NNHMargin_5);
            make.size.equalTo(self.backButton);
        }];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.width.equalTo(@(self.nnh_width));
            make.height.equalTo(@(NNHLineH * 2));
            make.baseline.equalTo(self);
        }];
    }
    return self;
}

- (void)backAction
{
    if (self.backBlock) self.backBlock();
}

- (void)shoppingCarAction
{
    if (![[NNHProjectControlCenter sharedControlCenter] loginStatus:YES]) return;
    if (self.shoppingCarBlock) self.shoppingCarBlock();
}

- (void)setCurrentAlpha:(CGFloat)currentAlpha
{
    _currentAlpha = currentAlpha;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:currentAlpha];
    self.bottomLine.hidden = currentAlpha < 1.0;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [self buttonWithImage:@"ic_nav_bg_back"];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (UIButton *)shoppingCarButton
{
    if (_shoppingCarButton == nil) {
        _shoppingCarButton = [self buttonWithImage:@"ic_nav_bg_car"];
        [_shoppingCarButton addTarget:self action:@selector(shoppingCarAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shoppingCarButton;
}

- (UIButton *)buttonWithImage:(NSString *)image
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:ImageName(image) forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    return button;
}

@end
