//
//  NNHApiMyCollectionTool.h
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/19.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHApiMyCollectionTool : NNHBaseRequest

/**
 获取用户收藏列表
 @param page 页码
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionListWithPage:(NSInteger)page;



/**
 用户收藏操作
 
 @param objectID 收藏对象id
 @param isCollection 收藏还是取消收藏
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionOperationWithCollectionObjectID:(NSString *)objectID
                                                         isCollection:(BOOL)isCollection;

@end
