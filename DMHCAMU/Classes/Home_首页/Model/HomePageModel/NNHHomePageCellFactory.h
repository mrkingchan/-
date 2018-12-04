//
//  NNHHomePageCellFactory.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页cell 工厂类
 
 @Remarks          配置
 
 *****************************************************/

#import <Foundation/Foundation.h>
@class NNHHomePageBaseModel;

@interface NNHHomePageCellFactory : NSObject

/** 为collectionView注册cell **/
+ (void)registerCellClassForCollectionView:(UICollectionView *)collectionView;

/** 根据model生成identifier **/
+ (NSString *)reuseIdentifierForModel:(NNHHomePageBaseModel *)pageModel;

/** 根据模型获取item尺寸 */
+ (CGSize)itemSizeWithModel:(NNHHomePageBaseModel *)pageModel;

/** section头部视图size */
+ (CGSize)headerSectionItemSizeWithModel:(NNHHomePageBaseModel *)pageModel;

/** section尾部视图size */
+ (CGSize)footerSectionItemSizeWithModel:(NNHHomePageBaseModel *)pageModel;


@end

