//
//  NNHHomeCollectionSectionHeaderView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页 sectionHeaderView
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
@class NNHHomePageBaseModel;
NS_ASSUME_NONNULL_BEGIN

@interface NNHHomeCollectionSectionHeaderView : UICollectionReusableView

/** section标题 */
@property (nonatomic, copy) NNHHomePageBaseModel *baseModel;

@end

NS_ASSUME_NONNULL_END
