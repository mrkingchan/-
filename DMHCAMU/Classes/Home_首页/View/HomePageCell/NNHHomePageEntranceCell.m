//
//  NNHHomePageEntranceCell.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/22.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageEntranceCell.h"
#import "NNHHomePageModuleModel.h"
#import "NNHBannerModel.h"


@interface NNHHomePageEntranceCell ()

/** 保存图片数组 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation NNHHomePageEntranceCell


- (void)setupChildView
{

    CGFloat cellWidth = (SCREEN_WIDTH - NNHMargin_15 * 2 - NNHMargin_5) * 0.5;
    CGFloat cellHeight = cellWidth * 2 / 3;
    
    UIImageView *leftImage = [self creatImageView];
    [self.contentView addSubview:leftImage];
    [self.imageArray addObject:leftImage];
    [leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@(cellWidth));
    }];

    
    UIImageView *topImage = [self creatImageView];
    [self.contentView addSubview:topImage];
    [self.imageArray addObject:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.top.equalTo(self.contentView);
        make.width.equalTo(leftImage);
        make.bottom.equalTo(self.mas_centerY).offset(-2.5);
    }];

    UIImageView *bottomImage = [self creatImageView];
    [self.contentView addSubview:bottomImage];
    [self.imageArray addObject:bottomImage];
    [bottomImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topImage);
        make.size.equalTo(topImage);
        make.bottom.equalTo(self.contentView);
    }];

    for (int i = 0; i < self.imageArray.count; i ++) {
        UIImageView *imageView = self.imageArray[i];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImageView:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)clickImageView:(UITapGestureRecognizer *)tap
{
    NSInteger tag = tap.view.tag;
    if (self.didSelectedItemBlock) {
        self.didSelectedItemBlock(tag);
    }
}

- (void)setBaseModel:(NNHHomePageBaseModel *)baseModel
{
    NNHHomePageModuleModel *moduleModel = (NNHHomePageModuleModel *)baseModel;
    
    for (int i = 0; i < moduleModel.bannerArray.count; i ++) {
        UIImageView *imageView = self.imageArray[i];
        NNHBannerModel *model = moduleModel.bannerArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.bannerThumb]];
    }
}

- (UIImageView *)creatImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    imageView.layer.cornerRadius = NNHMargin_5;
    imageView.layer.masksToBounds = YES;
    return imageView;
}

#pragma mark -
#pragma mark ---------Getter && Setter

- (NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end
