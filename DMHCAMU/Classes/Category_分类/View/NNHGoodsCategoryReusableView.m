//
//  NNHGoodsCategoryReusableView.m
//  ZTHYMall
//
//  Created by 来旭磊 on 17/4/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHGoodsCategoryReusableView.h"


@interface NNHGoodsCategoryReusableView ()

/**  */
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation NNHGoodsCategoryReusableView


#pragma mark -
#pragma mark ---------init
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
        self.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeaderView)];
        [self addGestureRecognizer:tap];
//        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
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
    self.nameLabel.text = goodsCateModel.name;
}

#pragma mark -
#pragma mark ---------getter && setter

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextMain]];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

@end
