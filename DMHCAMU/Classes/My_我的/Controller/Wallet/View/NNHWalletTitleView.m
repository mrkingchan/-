//
//  NNHWalletTitleView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHWalletTitleView.h"

@interface NNHWalletTitleView ()

/** 图片view */
@property (nonatomic, strong) UIImageView *titleImageView;
/** 账户余额 */
@property (nonatomic, strong) UILabel *amountlabel;
@end

@implementation NNHWalletTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    CGFloat imageWidth = SCREEN_WIDTH - 30;
    CGFloat imageHeight = imageWidth * 345 / 690;
    
    [self addSubview:self.titleImageView];
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.top.equalTo(self).offset(NNHMargin_20);
        make.size.mas_equalTo(CGSizeMake(imageWidth, imageHeight));
        make.bottom.equalTo(self).offset(-NNHMargin_20);
    }];
    
    
    UIButton *rechargeButton = [self createButtonWithTitle:@"充值" tag:NNHWalletOperationType_recharge];
    UIButton *withdrawButton = [self createButtonWithTitle:@"体现" tag:NNHWalletOperationType_withdraw];
    
    CGFloat padding = (SCREEN_WIDTH - 190) * 0.25;
    
    [self addSubview:rechargeButton];
    [self addSubview:withdrawButton];
    [rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.bottom.equalTo(self.titleImageView).offset(-NNHMargin_20);
        make.left.equalTo(self.titleImageView).offset(padding);
    }];
    
    [withdrawButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.bottom.equalTo(self.titleImageView).offset(-NNHMargin_20);
        make.right.equalTo(self.titleImageView).offset(-padding);
    }];
    
    UIView *lineView = [UIView lineView];
    [self.titleImageView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(withdrawButton);
        make.height.equalTo(withdrawButton);
        make.centerX.equalTo(self.titleImageView);
        make.width.equalTo(@(NNHLineH));
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"账户余额（元）" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    [self.titleImageView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleImageView).offset(30);
        make.top.equalTo(self.titleImageView).offset(30);
    }];
    
    [self.titleImageView addSubview:self.amountlabel];
    [self.amountlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(NNHMargin_10);
    }];
}

- (void)operationButtonAction:(UIButton *)button
{
    if (self.walletOperationBlock) {
        self.walletOperationBlock(button.tag);
    }
}

- (UIImageView *)titleImageView
{
    if (_titleImageView == nil) {
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.image = [UIImage imageNamed:@"wallet_bg"];
        _titleImageView.layer.cornerRadius = NNHMargin_10;
        _titleImageView.layer.masksToBounds = YES;
    }
    return _titleImageView;
}

- (UILabel *)amountlabel
{
    if (_amountlabel == nil) {
        _amountlabel = [UILabel NNHWithTitle:@"0.00" titleColor:[UIConfigManager colorThemeBlack] font:[UIFont boldSystemFontOfSize:30]];
    }
    return _amountlabel;
}

- (UIButton *)createButtonWithTitle:(NSString *)title tag:(NNHWalletOperationType)tag
{
    UIButton *button = [UIButton NNHBtnTitle:title titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIConfigManager colorThemeColorForVCBackground] titleColor:[UIConfigManager colorThemeBlack]];
    button.tag = tag;
    [button addTarget:self action:@selector(operationButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius = NNHMargin_15;
    button.layer.masksToBounds = YES;
    button.layer.borderWidth = NNHLineH;
    button.layer.borderColor = [UIColor akext_colorWithHex:@"#cccccc"].CGColor;
    return button;
}


@end
