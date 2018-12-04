//
//  NNHMyOrderHeaderView.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderHeaderView.h"
#import "NNHMyOrder.h"
#import "NNHHorizontalButton.h"

@interface NNHMyOrderHeaderView ()

@property (nonatomic, strong) NNHHorizontalButton *shopButton;
@property (nonatomic, strong) UILabel *orderStatusLabel;

@end

@implementation NNHMyOrderHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.shopButton];
    [self.shopButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
    }];
    
    [self.contentView addSubview:self.orderStatusLabel];
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-NNHMargin_10);
        make.left.equalTo(self.shopButton.mas_right).offset(15);
    }];
    
    [self.orderStatusLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.orderStatusLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setMyOrder:(NNHMyOrder *)myOrder
{
    _myOrder = myOrder;
    [self.shopButton setTitle:myOrder.businessname forState:UIControlStateNormal];
    self.orderStatusLabel.text = myOrder.orderStatusText;
}

- (void)setShowArrowOrderStatusLabel:(BOOL)showArrowOrderStatusLabel
{
    _showArrowOrderStatusLabel = showArrowOrderStatusLabel;
    self.orderStatusLabel.hidden = !showArrowOrderStatusLabel;
}

- (void)jumpMerchantShopAction
{
    if (self.jumpMerchantShopBlock) {
        self.jumpMerchantShopBlock(self.myOrder.businessid);
    }
}

- (UIButton *)shopButton
{
    if (_shopButton == nil) {
        _shopButton = [[NNHHorizontalButton alloc] initWithTitle:@"" image:@"mine_order_arrow" titleFont:[UIConfigManager fontThemeTextDefault] titleColor:[UIConfigManager colorThemeDark]];
        [_shopButton addTarget:self action:@selector(jumpMerchantShopAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopButton;
}

- (UILabel *)orderStatusLabel
{
    if (_orderStatusLabel == nil) {
        _orderStatusLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _orderStatusLabel;
}

@end
