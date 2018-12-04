//
//  NNHSearchHistorySectionHeaderView.m
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHSearchHistorySectionHeaderView.h"

@interface NNHSearchHistorySectionHeaderView ()

/** 历史搜索 */
@property (nonatomic, strong) UILabel *searchTitleLabel;
/** 清空历史button */
@property (nonatomic, strong) UIButton *removeAllButton;

@end

@implementation NNHSearchHistorySectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.searchTitleLabel];
    [self.contentView addSubview:self.removeAllButton];
    [self.searchTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
    }];
    [self.removeAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.width.equalTo(@(100));
    }];
    
    UIView *lineView = [UIView lineView];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(NNHLineH));
    }];
}

- (void)removeAllbuttonAction
{
    if (self.removeAllOperationBlock) {
        self.removeAllOperationBlock();
    }
}

- (UILabel *)searchTitleLabel
{
    if (_searchTitleLabel == nil) {
        _searchTitleLabel = [UILabel NNHWithTitle:@"历史搜索" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
    }
    return _searchTitleLabel;
}

- (UIButton *)removeAllButton
{
    if (_removeAllButton == nil) {
        _removeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_removeAllButton setImage:[UIImage imageNamed:@"ic_search_delete"] forState:UIControlStateNormal];
        [_removeAllButton setTitle:@"清空历史" forState:UIControlStateNormal];
        [_removeAllButton setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateNormal];
        _removeAllButton.titleLabel.font = [UIConfigManager fontThemeTextDefault];
        [_removeAllButton addTarget:self action:@selector(removeAllbuttonAction) forControlEvents:UIControlEventTouchUpInside];
        _removeAllButton.adjustsImageWhenHighlighted = NO;
    }
    return _removeAllButton;
}


@end
