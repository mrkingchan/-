//
//  NNHMyOrderCell.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderCell.h"
#import "NNHMyOrderItem.h"
#import "NNHOrderOperationButton.h"
#import "UIImageView+WebCache.h"
#import "NNHMyOrderOperationStatusModel.h"

@interface NNHMyOrderCell ()

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
/** 付款状态 */
@property (nonatomic, strong) UILabel *payStatusLabel;
/** 商品操作按钮容器 */
@property (nonatomic, strong) UIView *operationContentView;

@end

static CGFloat const oprecationButtonW = 70;
static CGFloat const oprecationButtonH = 30;
@implementation NNHMyOrderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
    }];
    
    [contentView addSubview:self.orderStatusLabel];
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView);
        make.right.equalTo(contentView).offset(-NNHMargin_15);
        make.height.equalTo(@44);
    }];
    
    [contentView addSubview:self.orderNumberLabel];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderStatusLabel);
        make.left.equalTo(contentView).offset(NNHMargin_15);
        make.right.lessThanOrEqualTo(self.orderStatusLabel.mas_left).offset(-10);
        make.height.equalTo(self.orderStatusLabel);
    }];
    
    [contentView addSubview:self.goodsImageView];
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.orderNumberLabel);
        make.top.equalTo(self.orderNumberLabel.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(90, 90));
    }];
    
    [contentView addSubview:self.goodsNameLabel];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsImageView.mas_right).offset(NNHMargin_15);
        make.top.equalTo(self.goodsImageView).offset(NNHMargin_10);
        make.right.equalTo(contentView).offset(-NNHMargin_15);
    }];
    
    [contentView addSubview:self.goodsPriceLabel];
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodsNameLabel);
        make.bottom.equalTo(self.goodsImageView).offset(-NNHMargin_10);
    }];
    
    [contentView addSubview:self.payStatusLabel];
    [self.payStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom);
        make.left.equalTo(self.orderNumberLabel);
        make.height.equalTo(@55);
    }];
    
    [contentView addSubview:self.operationContentView];
    [self.operationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.payStatusLabel);
        make.left.equalTo(self.payStatusLabel.mas_right);
        make.right.equalTo(contentView);
        make.height.equalTo(self.payStatusLabel);
    }];
}

- (void)setOrderItem:(NNHMyOrderItem *)orderItem
{
    _orderItem = orderItem;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:orderItem.orderItemIcon]];
    self.goodsNameLabel.text = orderItem.orderItemName;
    
//    NSString *priceStr = [NSString goodsPriceWithAmount:orderItem.orderItemPrice bull:orderItem.orderItemBullamount];
//    if (![NSString isEmptyString:priceStr]) {
//        self.goodsPriceLabel.text = priceStr;
//    }
    
    // 创建足够的操作按钮
    while (self.operationContentView.subviews.count < orderItem.operatingButtons.count) {
        NNHOrderOperationButton *orderOperationButton = [[NNHOrderOperationButton alloc] init];
        [self.operationContentView addSubview:orderOperationButton];
    }
    for (NSInteger i = 0; i < self.operationContentView.subviews.count; i++) {
        NNHOrderOperationButton *orderOperationButton = self.operationContentView.subviews[i];
        orderOperationButton.backgroundColor = [UIColor whiteColor];
        if (i < orderItem.operatingButtons.count) {
            orderOperationButton.hidden = NO;
            orderOperationButton.orderOperationStatus = orderItem.operatingButtons[i];
            [orderOperationButton addTarget:self action:@selector(refundAction:) forControlEvents:UIControlEventTouchUpInside];
            [orderOperationButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.operationContentView);
                make.right.equalTo(self.operationContentView).offset(-NNHMargin_15 - (NNHMargin_15 + oprecationButtonW)* i);
                make.size.mas_equalTo(CGSizeMake(oprecationButtonW, oprecationButtonH));
            }];
        }else{
            orderOperationButton.hidden = YES;
        }
    }
}

- (void)refundAction:(NNHOrderOperationButton *)button
{
    if (self.clickOperatingButtonBlock || self.orderItem.operatingButtons.count > 0) {
        self.clickOperatingButtonBlock(button.orderOperationStatus);
    }
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

- (UILabel *)payStatusLabel
{
    if (_payStatusLabel == nil) {
        _payStatusLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextTip]];
        _payStatusLabel.backgroundColor = [UIColor whiteColor];
    }
    return _payStatusLabel;
}

- (UIView *)operationContentView
{
    if (_operationContentView == nil) {
        _operationContentView = [[UIView alloc] init];
    }
    return _operationContentView;
}

@end
