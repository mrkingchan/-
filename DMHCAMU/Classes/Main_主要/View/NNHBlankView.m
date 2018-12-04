//
//  NNHBlankView.m
//  ElegantLife
//
//  Created by 牛牛 on 16/5/4.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import "NNHBlankView.h"

@interface NNHBlankView ()

@property (nonatomic, strong) UIImageView *blankIcon;
@property (nonatomic, strong) UIButton *operationButton;

@end

@implementation NNHBlankView

- (instancetype)initWithNoNetworkView
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        // 添加背景
        [self addSubview:self.blankIcon];
        [self.blankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(NNHMargin_20 * 3 + (NNHNavBarViewHeight));
            make.centerX.equalTo(self);
        }];
        
        // 刷新按钮
        UIButton *refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [refreshButton addTarget:self action:@selector(refreshAction) forControlEvents:UIControlEventTouchUpInside];
        [refreshButton setBackgroundImage:ImageName(@"shopping_error_refresh") forState:UIControlStateNormal];
        [self addSubview:refreshButton];
        [refreshButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.centerX.equalTo(self);
        }];
        
    }
    return self;
}

- (instancetype)initWithContents:(NSArray *)contents blankIcon:(NSString *)icon operationButtonTitle:(NSString *)title
{
    if (self = [super init]) {
        
        self.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        CGFloat top = 50;
        
        // 添加背景
        [self addSubview:self.blankIcon];
        self.blankIcon.image = ImageName(icon);
        [self.blankIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(top);
            make.centerX.equalTo(self);
        }];
        
        CGFloat labelMaxY = top + self.blankIcon.image.size.height + NNHMargin_10;
        CGFloat labelMarginH = 15;
        CGFloat labelH = 20;
        CGFloat count = contents.count;
        // 根据传入内容创建控件
        for (NSInteger i = 0; i < count; i++) {
            UILabel *label = [self setupTitle:contents[i]];
            label.nnh_x = 0;
            label.nnh_y = labelMaxY + i * (labelH + labelMarginH);
            label.nnh_width = SCREEN_WIDTH;
            label.nnh_height = labelH;
            [self addSubview:label];
            
            if (i > 0) {
                label.textColor = [UIConfigManager colorTextLightGray];
                label.font = [UIConfigManager fontThemeTextTip];
            }
        }
        
        // 操作按钮根据title来控制
        CGFloat btnMaxY = labelMaxY + count *(labelH + labelMarginH);
        if (title) {
            [self addSubview:self.operationButton];
            [self.operationButton setTitle:title forState:UIControlStateNormal];
            [self.operationButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(btnMaxY + 25);
                make.centerX.equalTo(self);
                make.size.mas_equalTo(CGSizeMake(160, 44));
                
            }];
        }
    }
    return self;
}

- (void)operationAction
{
    if (self.operationActionBlock) self.operationActionBlock();
}

- (void)refreshAction
{
    if (self.operationActionBlock) self.operationActionBlock();
}

- (UIImageView *)blankIcon
{
    if (_blankIcon == nil) {
        _blankIcon = [[UIImageView alloc] init];
        _blankIcon.image = ImageName(@"ic_web_none");
    }
    return _blankIcon;
}

- (UIButton *)operationButton
{
    if (_operationButton == nil) {
        _operationButton = [UIButton NNHOperationBtnWithTitle:@"" target:self action:@selector(operationAction) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
        _operationButton.backgroundColor = [UIConfigManager colorThemeRed];
        _operationButton.adjustsImageWhenHighlighted = NO;
    }
    return _operationButton;
}

- (UILabel *)setupTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = [UIConfigManager colorThemeDark];
    label.font = [UIConfigManager fontThemeTextMain];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

@end
