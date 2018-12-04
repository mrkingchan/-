//
//  NNHMallGoodsDetailServiceView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsDetailServiceView.h"

@interface NNHMallGoodsDetailServiceView ()


@end

@implementation NNHMallGoodsDetailServiceView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupChildView];
        
    }
    return self;
}

- (void)setupChildView
{
    UIButton *leftButton = [self creaetServiceButtonWithTitle:@"  平台保值托管"];
    UIButton *middleButton = [self creaetServiceButtonWithTitle:@"  购满一年公司回购"];
    UIButton *rightButton = [self creaetServiceButtonWithTitle:@"  线下验货"];
    
    [self addSubview:leftButton];
    [self addSubview:middleButton];
    [self addSubview:rightButton];
    
    UIView *view0 = [[UIView alloc] init];
    [self addSubview:view0];
    
    UIView *view1 = [[UIView alloc] init];
    [self addSubview:view1];
    
    UIView *view2 = [[UIView alloc] init];
    [self addSubview:view2];
    
    UIView *view3 = [[UIView alloc] init];
    [self addSubview:view3];

    [view0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.height.equalTo(@(NNHNormalViewH));
        make.left.equalTo(self);
    }];
    
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view0.mas_right);
        make.centerY.equalTo(self);
    }];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view0);
        make.left.equalTo(leftButton.mas_right);
    }];
    
    [middleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_right);
        make.centerY.equalTo(self);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view0);
        make.left.equalTo(middleButton.mas_right);
    }];
    
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_right);
        make.centerY.equalTo(self);
    }];
    
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(view0);
        make.left.equalTo(rightButton.mas_right);
        make.right.equalTo(self);
    }];
}

- (UIButton *)creaetServiceButtonWithTitle:(NSString *)title
{
    UIButton *button = [UIButton NNHBtnTitle:title titileFont:[UIFont systemFontOfSize:11] backGround:[UIConfigManager colorThemeWhite] titleColor:[UIConfigManager colorThemeBlack]];
    button.adjustsImageWhenHighlighted = NO;
    [button setImage:[UIImage imageNamed:@"tag_service"] forState:UIControlStateNormal];
//    [button sizeToFit];
    return button;
}

@end
