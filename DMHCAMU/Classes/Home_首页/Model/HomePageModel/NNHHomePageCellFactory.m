//
//  NNHHomePageCellFactory.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageCellFactory.h"
#import "NNHHomePageBaseModel.h"

@implementation NNHHomePageCellFactory

/** 为collectionView注册cell **/
+ (void)registerCellClassForCollectionView:(UICollectionView *)collectionView
{
    NSArray *classNames = @[
                            @"NNHHomePageBaseCell",
                            @"NNHHomePageGoodsCell",
                            @"NNHHomePageBannerCell",
                            @"NNHHomePageEntranceCell",
                            ];
    for (NSString *name in classNames) {
        [collectionView registerClass:NSClassFromString(name) forCellWithReuseIdentifier:name];
    }
}

/** 根据model生成identifier **/
+ (NSString *)reuseIdentifierForModel:(NNHHomePageBaseModel *)pageModel
{
    
    switch (pageModel.cellIdentifier) {
        case NNHHomePageModelCellIdentifier_NormalGoods:
            return @"NNHHomePageGoodsCell";
            break;
        case NNHHomePageModelCellIdentifier_Banner:
            return @"NNHHomePageBannerCell";
            break;
        case NNHHomePageModelCellIdentifier_Entrance:
            return @"NNHHomePageEntranceCell";
            break;
        case NNHHomePageModelCellIdentifier_Default:
            return @"NNHHomePageBaseCell";
            break;
    }
    
    NNHLog(@"不应该到这里");
    return @"";
}

/** 根据模型获取item尺寸 */
+ (CGSize)itemSizeWithModel:(NNHHomePageBaseModel *)pageModel
{
    switch (pageModel.cellIdentifier) {
        case NNHHomePageModelCellIdentifier_NormalGoods:
            return [self getGoodsItemSize];
            break;
        case NNHHomePageModelCellIdentifier_Banner:
            return [self getBannerCellSize];
            break;
        case NNHHomePageModelCellIdentifier_Entrance:
            return [self getEntranceCellSize];
            break;
        case NNHHomePageModelCellIdentifier_Default:
            return CGSizeMake(SCREEN_WIDTH, 0.01);
            break;
    }
}

/** section头部视图size */
+ (CGSize)headerSectionItemSizeWithModel:(NNHHomePageBaseModel *)pageModel
{
    if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_Banner) {
        return CGSizeMake(SCREEN_WIDTH, NNHMargin_15);
    }else if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_Entrance) {
        return CGSizeMake(SCREEN_WIDTH, NNHMargin_15);
    }else if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods) {
        return CGSizeMake(SCREEN_WIDTH, 70);
    }else {
        return CGSizeMake(SCREEN_WIDTH, 0.01);
    }
}

/** section尾部视图size */
+ (CGSize)footerSectionItemSizeWithModel:(NNHHomePageBaseModel *)pageModel
{
    if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_Banner) {
        return CGSizeMake(SCREEN_WIDTH, 0.01);
    }else if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_Entrance) {
        return CGSizeMake(SCREEN_WIDTH, 0.01);
    }else if (pageModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods) {
        return CGSizeMake(SCREEN_WIDTH, NNHMargin_15);
    }else {
        return CGSizeMake(SCREEN_WIDTH, 0.01);
    }
}

/** 普通商品cell的尺寸 */
+ (CGSize)getGoodsItemSize
{
    return CGSizeMake((SCREEN_WIDTH - 35) * 0.5, (SCREEN_WIDTH - 35) * 0.5  + NNHNormalViewH * 1.9);
}

/** 单独banner的大小 */
+ (CGSize)getBannerCellSize
{
    CGFloat cellHeight = (SCREEN_WIDTH - 30) * 2 / 3;
    return CGSizeMake(SCREEN_WIDTH, cellHeight);
}

/** entranceCell 的大小 */
+ (CGSize)getEntranceCellSize
{
    CGFloat padding = NNHMargin_15;
    CGFloat cellWidth = (SCREEN_WIDTH - padding * 2 - NNHMargin_5) * 0.5;
    CGFloat cellHeight = cellWidth * 4 / 3;
    return CGSizeMake(SCREEN_WIDTH, cellHeight);
}

@end
