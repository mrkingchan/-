//
//  NNHGoodsCategoryReusableView.h
//  ZTHYMall
//
//  Created by 来旭磊 on 17/4/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NNHStoreCategoryModel.h"
#import "NNHAllGoodsCategoryModel.h"

@interface NNHGoodsCategoryReusableView : UICollectionReusableView

/** <#注释#> */
@property (nonatomic, copy) void(^didClickHeaderBlock)();
/** 类别模型 */
@property (nonatomic, strong) NNHAllGoodsCategoryModel *goodsCateModel;

@end
