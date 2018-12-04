//q
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/3.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NNHStoreCategoryModel.h"
#import "NNHAllGoodsCategoryModel.h"

@interface NNHGoodsCategoryCollectionReusableView : UICollectionReusableView

/** <#注释#> */
@property (nonatomic, copy) void(^didClickHeaderBlock)();

/** 类别模型 */
@property (nonatomic, strong) NNHStoreCategoryModel *cateModel;

/** 类别模型 */
@property (nonatomic, strong) NNHAllGoodsCategoryModel *goodsCateModel;

@end
