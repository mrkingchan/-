//
//  NNHMyCollectionCell.m
//  ZTHYMall
//
//  Created by 牛牛汇 on 2017/5/20.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyCollectionCell.h"
#import "NNHMyCollectionModel.h"

@interface NNHMyCollectionCell ()

/** 商家图片 */
@property (nonatomic, strong) UIImageView *collectionImageView;
/** 商家店名 */
@property (nonatomic, strong) UILabel *collectionNameLabel;
/** 收藏价格 */
@property (nonatomic, strong) UILabel *collectionPriceLabel;

@end

@implementation NNHMyCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.collectionImageView];
    [self.collectionImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(120, 120));
    }];
    
    [self.contentView addSubview:self.collectionNameLabel];
    [self.collectionNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionImageView).offset(10);
        make.left.equalTo(self.collectionImageView.mas_right).offset(NNHMargin_15);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
    }];
    
    [self.contentView addSubview:self.collectionPriceLabel];
    [self.collectionPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionNameLabel);
        make.bottom.equalTo(self.collectionImageView).offset(-10);
    }];
}

- (void)setCollectionModel:(NNHMyCollectionModel *)collectionModel
{
    _collectionModel = collectionModel;
    
    [self.collectionImageView sd_setImageWithURL:[NSURL URLWithString:collectionModel.thumb]];
    self.collectionNameLabel.text = collectionModel.productname;
    
    NSString *priceStr = [NSString stringWithFormat:@"¥ %@",collectionModel.prouctprice];
    self.collectionPriceLabel.attributedText = [NSMutableAttributedString nn_changeFontAndColor:[UIFont boldSystemFontOfSize:18] Color:[UIConfigManager colorThemeRed] TotalString:priceStr SubStringArray:@[collectionModel.prouctprice]];    
}

#pragma mark -
#pragma mark ---------Getter && Setter
- (UIImageView *)collectionImageView
{
    if (_collectionImageView == nil) {
        _collectionImageView = [[UIImageView alloc] init];
        _collectionImageView.backgroundColor = [UIConfigManager colorThemeSeperatorDarkGray];
    }
    return _collectionImageView;
}

- (UILabel *)collectionNameLabel
{
    if (_collectionNameLabel == nil) {
        _collectionNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextImportant]];
        _collectionNameLabel.numberOfLines = 2;
        _collectionNameLabel.backgroundColor = [UIColor whiteColor];
    }
    return _collectionNameLabel;
}

- (UILabel *)collectionPriceLabel
{
    if (_collectionPriceLabel == nil) {
        _collectionPriceLabel = [UILabel NNHWithTitle:@"¥0.00" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextTip]];
        _collectionPriceLabel.backgroundColor = [UIColor whiteColor];
    }
    return _collectionPriceLabel;
}

@end
