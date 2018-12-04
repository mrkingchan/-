//
//  NNHHomePageGoodsCell.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageGoodsCell.h"
#import "NNHHomePageGoodsModuleModel.h"
#import "NNHHomePageGoodsDetailModel.h"


@interface NNHHomePageGoodsCell ()

/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 商品标题 */
@property (nonatomic, strong) UILabel *goodsTitleLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;
/** 关注人数 */
@property (nonatomic, strong) UILabel *followCountLabel;

@end

@implementation NNHHomePageGoodsCell

- (void)setupChildView
{
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.goodsTitleLabel];
    [self.contentView addSubview:self.followCountLabel];
    [self.contentView addSubview:self.goodsPriceLabel];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.equalTo(self.contentView.mas_width);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_5);
        make.right.equalTo(self.contentView).offset(-NNHMargin_5);
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(NNHMargin_10);
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_10);
        make.right.equalTo(self.contentView).offset(-NNHMargin_10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-NNHMargin_10);
        make.height.equalTo(@(NNHMargin_15));
    }];
    
    [self.followCountLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.goodsTitleLabel);
        make.centerY.equalTo(self.goodsPriceLabel);
    }];
    
    self.goodsImageView.layer.cornerRadius = NNHMargin_5;
    self.goodsImageView.layer.masksToBounds = YES;
    
}

- (void)setBaseModel:(NNHHomePageBaseModel *)baseModel
{
    [super setBaseModel:baseModel];
    
    NNHHomePageGoodsModuleModel *model = (NNHHomePageGoodsModuleModel *)baseModel;
    NNHHomePageGoodsDetailModel *goodsModel = model.goodsArray[self.cellIndexPath.row];
    self.goodsModel = goodsModel;
}

- (void)setGoodsModel:(NNHHomePageGoodsDetailModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.thumb]];

    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.prouctprice];
    self.goodsTitleLabel.text = [NSString stringWithFormat:@" %@",goodsModel.productname];
    self.followCountLabel.text = [NSString stringWithFormat:@"关注 %@",goodsModel.salecount];
}

#pragma mark -
#pragma mark ---------getter && setter

- (UIImageView *)goodsImageView
{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    }
    return _goodsImageView;
}

- (UILabel *)goodsTitleLabel
{
    if (_goodsTitleLabel == nil) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.text = @"商品名称";
        _goodsTitleLabel.font = [UIConfigManager fontThemeTextDefault];
        _goodsTitleLabel.textColor = [UIConfigManager colorGoodsTitle];
    }
    return _goodsTitleLabel;
}

- (UILabel *)followCountLabel
{
    if (_followCountLabel == nil) {
        _followCountLabel = [[UILabel alloc] init];
        _followCountLabel.font = [UIFont systemFontOfSize:11];
        _followCountLabel.textColor = [UIConfigManager colorTextLightGray];
        _followCountLabel.text = @"0人关注";
    }
    return _followCountLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:14];
        _goodsPriceLabel.textColor = [UIConfigManager colorPrice];
        _goodsPriceLabel.text = @"￥0";
    }
    return _goodsPriceLabel;
}


@end
