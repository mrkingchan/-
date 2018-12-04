//
//  NNHHomePageBaseCell.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页基类model
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@class NNHHomePageBaseModel;

@interface NNHHomePageBaseCell : UICollectionViewCell

/** cell的indexPath */
@property (nonatomic, strong) NSIndexPath *cellIndexPath;

/** 设置子控件 */
- (void)setupChildView;

/** 数据模型 */
@property (nonatomic, strong) NNHHomePageBaseModel *baseModel;

/** 顶部点击模块的block回调 **/
@property (nonatomic, copy) void (^didSelectedItemBlock)(NSInteger index);

@end

