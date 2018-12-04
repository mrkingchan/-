//
//  NNHAllGoodsCategoryModel.h
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHAllGoodsCategoryModel : NSObject

/** 分类id */
@property (nonatomic, copy) NSString *categoryID;
/** 分类所属商家id */
@property (nonatomic, copy) NSString *parent_id;
/** 分类名 */
@property (nonatomic, copy) NSString *name;
/** 图片名 */
@property (nonatomic, copy) NSString *category_icon;
/**  */
@property (nonatomic, copy) NSString *status;
/** 分类id */
@property (nonatomic, copy) NSArray <NNHAllGoodsCategoryModel *>*sonCateArray;

///** 是否显示全部 */
@property (nonatomic, assign) BOOL showAllCate;


@end
