//
//  NNHWalletTransferRecordCell.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHWalletTransferRecordCell.h"
@interface NNHWalletTransferRecordCell ()

/** 流水内容 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 金额 */
@property (nonatomic, strong) UILabel *amountLabel;

@end

@implementation NNHWalletTransferRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIConfigManager colorThemeWhite];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.amountLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.bottom.equalTo(self.contentView.mas_centerY).offset(-NNHMargin_5);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
    }];
    
    [self.amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - Lazy Loads

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"公司回购" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (_timeLabel == nil) {
        _timeLabel = [UILabel NNHWithTitle:@"2018-10-19" titleColor:[UIConfigManager colorTextLightGray] font:[UIFont systemFontOfSize:12]];
    }
    return _timeLabel;
}

- (UILabel *)amountLabel
{
    if (_amountLabel == nil) {
        _amountLabel = [UILabel NNHWithTitle:@"+0.0" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _amountLabel;
}

@end

