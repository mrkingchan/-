//
//  NNHMyOrderDetailViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/2.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderDetailViewController.h"

@interface NNHMyOrderDetailViewController ()

/** 订单编号 */
@property (nonatomic, strong) UILabel *orderNumberLabel;
/** 订单状态 */
@property (nonatomic, strong) UILabel *orderStatusLabel;
/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 商品内容 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;

@end

@implementation NNHMyOrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"投资详情";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
}

- (void)setupChildView
{
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(- 44 - (NNHBottomSafeHeight));
    }];
    
    // 商品信息
    UIView *goodsContentView = [[UIView alloc] init];
    [contentView addSubview:goodsContentView];
    [goodsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(NNHMargin_15);
        make.left.equalTo(contentView).offset(NNHMargin_15);
        make.right.equalTo(contentView).offset(-NNHMargin_15);
    }];
    
    [goodsContentView addSubview:self.orderStatusLabel];
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsContentView);
        make.right.equalTo(goodsContentView).offset(-NNHMargin_15);
        make.height.equalTo(@44);
    }];
    
    [goodsContentView addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderStatusLabel);
        make.left.equalTo(goodsContentView).offset(NNHMargin_15);
        make.right.lessThanOrEqualTo(self.orderStatusLabel.mas_left).offset(-10);
        make.height.equalTo(self.orderStatusLabel);
    }];
    
    [goodsContentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNumberLabel);
        make.top.equalTo(self.orderNumberLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [goodsContentView addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(NNHMargin_15);
        make.top.equalTo(self.goodsImageView).offset(NNHMargin_10);
        make.right.equalTo(goodsContentView).offset(-NNHMargin_15);
    }];
    
    [goodsContentView addSubview:self.goodsPriceLabel];
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsNameLabel);
        make.bottom.equalTo(goodsContentView).offset( -NNHMargin_15 - NNHMargin_10);
    }];
    
    // 付款信息
    UIView *payContentView = [[UIView alloc] init];
    [contentView addSubview:payContentView];
    [payContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsContentView.mas_bottom).offset(NNHMargin_10);
        make.left.right.equalTo(goodsContentView);
        make.height.equalTo(@44);
    }];
    
    UILabel *payTitleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:14]];
    [payContentView addSubview:payTitleLabel];
    [payTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(payContentView).offset(NNHMargin_15);
        make.centerY.equalTo(payContentView);
    }];
    
    UILabel *payLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextMain]];
    [payContentView addSubview:payLabel];
    [payLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(payContentView).offset(-NNHMargin_15);
        make.centerY.equalTo(payContentView);
    }];
    
    // 取货信息
    UIView *addressContentView = [[UIView alloc] init];
    [contentView addSubview:addressContentView];
    [addressContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payContentView.mas_bottom).offset(NNHMargin_10);
        make.left.right.equalTo(goodsContentView);
    }];
    
    UILabel *addressTitleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:14]];
    [addressContentView addSubview:addressTitleLabel];
    [addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressContentView).offset(NNHMargin_15);
        make.top.equalTo(addressContentView).offset(NNHMargin_15);
    }];
    
    UILabel *nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
    [addressContentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressTitleLabel);
        make.top.equalTo(addressTitleLabel.mas_bottom).offset(NNHMargin_15);
    }];
    
    UILabel *phoneLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
    [addressContentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(NNHMargin_10);
        make.centerY.equalTo(nameLabel);
    }];
    
    UILabel *addressLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
    [addressContentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(addressTitleLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(NNHMargin_15);
        make.bottom.equalTo(addressContentView).offset(-NNHMargin_15);
    }];
    
    // 更多信息
    UIView *moreContentView = [[UIView alloc] init];
    [contentView addSubview:moreContentView];
    [moreContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addressContentView.mas_bottom).offset(NNHMargin_10);
        make.left.right.equalTo(goodsContentView);
        make.height.equalTo(@44);
        make.bottom.equalTo(contentView).offset(-40);
    }];
    
    UILabel *moreTitleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:14]];
    [moreContentView addSubview:moreTitleLabel];
    [moreTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moreContentView).offset(NNHMargin_15);
        make.top.equalTo(moreContentView).offset(NNHMargin_15);
    }];
}

- (UIImageView *)goodsImageView
{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIConfigManager colorThemeSeperatorDarkGray];
    }
    return _goodsImageView;
}

- (UILabel *)orderNumberLabel
{
    if (_orderNumberLabel == nil) {
        _orderNumberLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
        _orderNumberLabel.backgroundColor = [UIColor whiteColor];
    }
    return _orderNumberLabel;
}

- (UILabel *)orderStatusLabel
{
    if (_orderStatusLabel == nil) {
        _orderStatusLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
        _orderStatusLabel.backgroundColor = [UIColor whiteColor];
    }
    return _orderStatusLabel;
}

- (UILabel *)goodsNameLabel
{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextImportant]];
        _goodsNameLabel.backgroundColor = [UIColor whiteColor];
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextTip]];
        _goodsPriceLabel.backgroundColor = [UIColor whiteColor];
    }
    return _goodsPriceLabel;
}

@end
