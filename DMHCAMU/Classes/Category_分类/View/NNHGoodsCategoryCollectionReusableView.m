//
//  NNHGoodsCategoryCollectionReusableView.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/3.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHGoodsCategoryCollectionReusableView.h"
#import "NNHAllGoodsCategoryModel.h"


@interface NNHGoodsCategoryCollectionReusableView ()

/** 查看全部 */
@property (nonatomic, strong) UILabel *allLabel;
/** 分类名 */
@property (nonatomic, strong) UILabel *categoryNameLabel;

@end

@implementation NNHGoodsCategoryCollectionReusableView

#pragma mark -
#pragma mark ---------init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
        self.backgroundColor = [UIConfigManager colorThemeWhite];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeaderView)];
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.categoryNameLabel];
    [self.self.categoryNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.centerY.equalTo(self.mas_centerY);
    }];
    [self addSubview:self.allLabel];
    [self.self.allLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-NNHMargin_15);
        make.centerY.equalTo(self.mas_centerY);
    }];
}

- (void)didClickHeaderView
{
//    self.cateModel.showAllCate = !self.cateModel.showAllCate;
    if (self.didClickHeaderBlock) {
        self.didClickHeaderBlock();
    }
}

/** 设置首页商品的类别模型 */
- (void)setGoodsCateModel:(NNHAllGoodsCategoryModel *)goodsCateModel
{
    _goodsCateModel = goodsCateModel;
    self.categoryNameLabel.text = goodsCateModel.name;
}

/** */
- (void)setCateModel:(NNHStoreCategoryModel *)cateModel
{
    _cateModel = cateModel;
    self.categoryNameLabel.text = cateModel.category_name;
}

#pragma mark -
#pragma mark ---------getter && setter

- (UILabel *)allLabel
{
    if (_allLabel == nil) {
        _allLabel = [UILabel NNHWithTitle:@"查看全部" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _allLabel;
}

- (UILabel *)categoryNameLabel
{
    if (_categoryNameLabel == nil) {
        _categoryNameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    }
    return _categoryNameLabel;
}


@end
