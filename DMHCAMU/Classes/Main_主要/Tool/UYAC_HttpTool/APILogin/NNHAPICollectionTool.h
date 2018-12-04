//
//  NNHAPICollectionTool.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2017/5/19.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

//收藏相关数据请求类

#import "NNHBaseRequest.h"

@interface NNHAPICollectionTool : NNHBaseRequest



/**
 获取用户收藏列表

 @param typeIndex 收藏类型1收藏的实体店 2类型收藏的商品 3收藏的供应商
  @param page 页码
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionListWithType:(NSInteger)typeIndex page:(NSInteger)page;



/**
 用户收藏操作

 @param objectID 收藏对象id
 @param collecctionType 收藏类型
 @param isCollection 收藏还是取消收藏
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionOperationWithCollectionObjectID:(NSString *)objectID
                                                       collectiontype:(NSInteger)collecctionType
                                                         isCollection:(BOOL)isCollection;


@end
