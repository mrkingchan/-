//
//  NNHUserCollectionModel.h
//  ZTHYMall
//
//  Created by 牛牛汇 on 2017/5/20.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

//用户收藏模型

#import <Foundation/Foundation.h>

@interface NNHMyCollectionModel : NSObject

/** 收藏id */
@property (nonatomic, copy) NSString *collectionID;
/** 缩略图 */
@property (nonatomic, copy) NSString *thumb;
/** 商品名称 */
@property (nonatomic, copy) NSString *productname;
/** 商品价格 */
@property (nonatomic, copy) NSString *prouctprice;

@end
