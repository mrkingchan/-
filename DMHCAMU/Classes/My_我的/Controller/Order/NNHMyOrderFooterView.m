//
//  NNHMyOrderFooterView.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderFooterView.h"
#import "NNHOrderOperationButton.h"
#import "NNHMyOrder.h"

@interface NNHMyOrderFooterView ()

@property (nonatomic, strong) UILabel *orderSubtotalLabel;
@property (nonatomic, strong) UIView *operationContentView;

@end

static CGFloat const oprecationButtonW = 80;
static CGFloat const oprecationButtonH = 30;
@implementation NNHMyOrderFooterView

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
    [self.contentView addSubview:self.orderSubtotalLabel];
    [self.orderSubtotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.height.mas_equalTo(44);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderSubtotalLabel.mas_bottom);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(NNHLineH));
    }];
    
    UIView *spaceView = [[UIView alloc] init];
    spaceView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self.contentView addSubview:spaceView];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView);
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(NNHMargin_10));
    }];
    
    [self.contentView addSubview:self.operationContentView];
    [self.operationContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(spaceView.mas_top);
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(lineView.mas_bottom);
    }];
}

- (void)setMyOrder:(NNHMyOrder *)myOrder
{
    _myOrder = myOrder;
    
    NSString *freightStr = @"";
    if ([myOrder.actualfreight integerValue] > 0) {
        freightStr = [NSString stringWithFormat:@" (含运费¥%@)",myOrder.actualfreight];
    }
    
    if ([NSString isEmptyString:myOrder.bullamount] || [myOrder.bullamount isEqualToString:@"0"]) {
        self.orderSubtotalLabel.text = [NSString stringWithFormat:@"共 %@ 件商品 合计：¥%@%@",myOrder.productcount,myOrder.totalamount,freightStr];
    }else if ([NSString isEmptyString:myOrder.totalamount] || [myOrder.totalamount isEqualToString:@"0"]) {
        self.orderSubtotalLabel.text = [NSString stringWithFormat:@"共 %@ 件商品 合计：%@ %@%@",myOrder.productcount,myOrder.bullamount,NNHCurrency,freightStr];
    }else{
        self.orderSubtotalLabel.text = [NSString stringWithFormat:@"共 %@ 件商品 合计：¥%@ + %@ %@%@",myOrder.productcount,myOrder.totalamount,myOrder.bullamount,NNHCurrency,freightStr];
    }
    
    // 创建足够的操作按钮
    while (self.operationContentView.subviews.count < myOrder.orderOperationButtons.count) {
        NNHOrderOperationButton *orderOperationButton = [[NNHOrderOperationButton alloc] init];
        [self.operationContentView addSubview:orderOperationButton];
    }
    
    for (NSInteger i = 0; i < self.operationContentView.subviews.count; i++) {
        NNHOrderOperationButton *orderOperationButton = self.operationContentView.subviews[i];
        if (i < myOrder.orderOperationButtons.count) {
            orderOperationButton.hidden = NO;
            orderOperationButton.orderOperationStatus = myOrder.orderOperationButtons[i];
            [orderOperationButton addTarget:self action:@selector(orderOprecationAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)orderOprecationAction:(NNHOrderOperationButton *)button
{
    if (self.reloadOrderDataSourceBlock) {
        self.reloadOrderDataSourceBlock(button.orderOperationStatus);
    }
}

- (UILabel *)orderSubtotalLabel
{
    if (_orderSubtotalLabel == nil) {
        _orderSubtotalLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextTip]];
        _orderSubtotalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _orderSubtotalLabel;
}

- (UIView *)operationContentView
{
    if (_operationContentView == nil) {
        _operationContentView = [[UIView alloc] init];
    }
    return _operationContentView;
}

@end
