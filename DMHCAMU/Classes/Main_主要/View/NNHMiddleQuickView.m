//
//  NNHMiddleQuickView.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#define bl [[UIScreen mainScreen]bounds].size.width/375

#import "NNHMiddleQuickView.h"
#import "UIButton+NNImagePosition.h"

@interface NNHMiddleQuickView ()

@property (nonatomic, weak) UIButton *closeBtn;

@end

@implementation NNHMiddleQuickView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self closeAction];
}

- (instancetype)init
{
    if (self = [super init]) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    // 创建遮罩
    UIView *backBgView = [[UIView alloc] init];
    backBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    [self addSubview:backBgView];
    [backBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    // 创建关闭按钮
    UIButton *closeBtn = [UIButton NNHBtnImage:@"ic_home_close" target:self action:@selector(closeAction)];
    [self addSubview:closeBtn];
    self.closeBtn = closeBtn;
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-(NNHBottomSafeHeight) - (isiPhoneX ? 0.0 : 5.0));
        make.centerX.equalTo(self);
    }];
    
    // 创建牛豆按钮
//    UIButton *ndBtn = [self buttonWithTitle:@"牛豆专区" image:@"ic_division_dou" action:@selector(clickNDAction)];
//    [self addSubview:ndBtn];
//    [ndBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(closeBtn.mas_top).offset(-20);
//        make.centerX.equalTo(self);
//        make.height.equalTo(@120);
//    }];
    
    // 创建现金按钮
    UIButton *moneyBtn = [self buttonWithTitle:@"现金专区" image:@"ic_division_cash" action:@selector(clickMoneyAction)];
    [self addSubview:moneyBtn];
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(closeBtn.mas_top).offset(-20);
        make.right.equalTo(self.mas_centerX).offset(-35);
        make.height.equalTo(@120);
    }];
    
    // 创建现金➕牛豆按钮
    UIButton *hybridBtn = [self buttonWithTitle:@"现金+牛豆" image:@"ic_division_cash_dou" action:@selector(clickHybridAction)];
    [self addSubview:hybridBtn];
    [hybridBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyBtn);
        make.left.equalTo(self.mas_centerX).offset(35);
        make.height.equalTo(moneyBtn);
    }];
    
    
    // 创建扫一扫按钮
    UIButton *scanBtn = [self buttonWithTitle:@"扫一扫" image:@"ic_scan" action:@selector(clickScanAction)];
    [self addSubview:scanBtn];
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(moneyBtn.mas_top).offset(-20);
        make.centerX.equalTo(moneyBtn);
        make.height.equalTo(@100);
    }];
    
    // 创建收付款按钮
    UIButton *payBtn = [self buttonWithTitle:@"商家收款" image:@"ic_collect_money" action:@selector(clickPayAction)];
    [self addSubview:payBtn];
    [payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(scanBtn);
        make.centerX.equalTo(hybridBtn);
        make.height.equalTo(scanBtn);
    }];
    
    // 创建分割线
    UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageName(@"ic_home_line")];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(scanBtn).offset(-15);
    }];
}

- (void)show
{
    // 获取最上面的窗口
    [[UIView currentWindow] addSubview:self];
    
    self.frame = [UIScreen mainScreen].bounds;
}

- (void)closeAction
{
    [self removeFromSuperview];
}

- (void)clickNDAction
{
    [self removeFromSuperview];
    if (self.didSelectedButtonBlock) self.didSelectedButtonBlock(NNHButtonJumpType_ndQuick);
}

- (void)clickMoneyAction
{
    [self removeFromSuperview];
    if (self.didSelectedButtonBlock) self.didSelectedButtonBlock(NNHButtonJumpType_moneyQuick);
}

- (void)clickHybridAction
{
    [self removeFromSuperview];
    if (self.didSelectedButtonBlock) self.didSelectedButtonBlock(NNHButtonJumpType_hybridQuick);
}

- (void)clickScanAction
{
    [self removeFromSuperview];
    if (self.didSelectedButtonBlock) self.didSelectedButtonBlock(NNHButtonJumpType_scan);
}

- (void)clickPayAction
{
    [self removeFromSuperview];
    if (self.didSelectedButtonBlock) self.didSelectedButtonBlock(NNHButtonJumpType_pay);
}

- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:ImageName(image) forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIConfigManager fontThemeTextTip]];
    [btn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [btn nn_setImagePosition:NNImagePositionTop spacing:10.0];
    return btn;
}

@end
