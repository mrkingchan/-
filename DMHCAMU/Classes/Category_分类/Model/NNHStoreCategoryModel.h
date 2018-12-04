//
//  NNHStoreCategoryModel.h
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHStoreSonCateModel : NSObject

/** 分类id */
@property (nonatomic, copy) NSString *sonCateID;
/** 分类所属商家id */
@property (nonatomic, copy) NSString *businessid;
/** 分类名 */
@property (nonatomic, copy) NSString *category_name;
/**  */
@property (nonatomic, copy) NSString *parent_id;
/** 排序 */
@property (nonatomic, copy) NSString *sort;
/** 是否删除 */
@property (nonatomic, copy) NSString *is_delete;
/** 分类id */
@property (nonatomic, copy) NSString *category_icon;

@end

@interface NNHStoreCategoryModel : NSObject

/** 分类id */
@property (nonatomic, copy) NSString *categoryID;
/** 分类所属商家id */
@property (nonatomic, copy) NSString *businessid;
/** 分类名 */
@property (nonatomic, copy) NSString *category_name;
/**  */
@property (nonatomic, copy) NSString *parent_id;
/** 排序 */
@property (nonatomic, copy) NSString *sort;
/** 是否删除 */
@property (nonatomic, copy) NSString *is_delete;
/** 分类id */
@property (nonatomic, copy) NSString *category_icon;
/** 分类id */
@property (nonatomic, copy) NSArray <NNHStoreSonCateModel *>*sonCateArray;

///** 是否显示全部 */
@property (nonatomic, assign) BOOL showAllCate;

@end
