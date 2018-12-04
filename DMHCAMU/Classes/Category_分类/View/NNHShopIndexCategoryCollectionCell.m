//
//  NNHShopIndexCategoryCollectionCell.m
//  ZTHYMall
//
//  Created by 来旭磊 on 17/4/5.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHShopIndexCategoryCollectionCell.h"
#import "NNHAllGoodsCategoryModel.h"


@interface NNHShopIndexCategoryCollectionCell ()

/** 分类图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 分类图片 */
@property (nonatomic, strong) UILabel *goodsNameLabel;
@end

@implementation NNHShopIndexCategoryCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsNameLabel];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(NNHMargin_5);
        make.centerX.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(0.8);
        make.height.equalTo(self.contentView.mas_width).multipliedBy(0.8);
    }];
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-NNHMargin_10);
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(NNHMargin_5);
    }];
}

- (void)setGoodsCateModel:(NNHAllGoodsCategoryModel *)goodsCateModel
{
    _goodsCateModel = goodsCateModel;
    self.goodsNameLabel.text = goodsCateModel.name;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsCateModel.category_icon]];
}

#pragma mark -
#pragma mark ---------Getter && Setter

- (UIImageView *)goodsImageView
{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIConfigManager colorThemeSeperatorDarkGray];
    }
    return _goodsImageView;
}

- (UILabel *)goodsNameLabel
{
    if (_goodsNameLabel == nil) {
        _goodsNameLabel = [UILabel NNHWithTitle:@"电饭锅" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
        _goodsNameLabel.numberOfLines = 2;
    }
    return _goodsNameLabel;
}

@end
