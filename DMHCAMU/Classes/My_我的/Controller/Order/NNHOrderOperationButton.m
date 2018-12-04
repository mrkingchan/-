//
//  NNHOrderOperationButton.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHOrderOperationButton.h"
#import "NNHMyOrderOperationStatusModel.h"

@implementation NNHOrderOperationButton

- (instancetype)init
{
    if (self = [super init]) {
        self.titleLabel.font = [UIConfigManager fontThemeTextDefault];
        self.layer.borderColor = [UIConfigManager colorThemeSeperatorDarkGray].CGColor;
        self.layer.borderWidth = 0.5;
        self.layer.cornerRadius = 2.0;
        [self setTitleColor:[UIConfigManager colorThemeDark] forState:UIControlStateNormal];
        [self setTitleColor:[UIConfigManager colorThemeDisable] forState:UIControlStateDisabled];
    }
    return self;
}

-(void)setOrderOperationStatus:(NNHMyOrderOperationStatusModel *)orderOperationStatus
{
    _orderOperationStatus = orderOperationStatus;
    
    self.enabled = [orderOperationStatus.act integerValue] == 1;
    [self setTitle:orderOperationStatus.actname forState:UIControlStateNormal];
    
    if ([orderOperationStatus.acttype integerValue] == NNHOrderOperationStatus_pay || [orderOperationStatus.acttype integerValue] == NNHOrderOperationStatus_sureReceiving) {
        self.layer.borderColor = [UIConfigManager colorThemeRed].CGColor;
        [self setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
    }else{
        self.layer.borderColor = [UIConfigManager colorThemeSeperatorDarkGray].CGColor;
        [self setTitleColor:[UIConfigManager colorThemeDark] forState:UIControlStateNormal];
    }
}

@end
