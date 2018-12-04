//
//  NNHAPICollectionTool.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2017/5/19.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAPICollectionTool.h"

@implementation NNHAPICollectionTool

/**
 获取用户收藏列表
 
 @param typeIndex 收藏类型1收藏的实体店 2类型收藏的商品 3收藏的供应商
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionListWithType:(NSInteger)typeIndex page:(NSInteger)page;
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"User.Collection.collectionList";
        self.reAPIName = @"获取用户收藏列表";
        self.reParams = @{
                          @"type" : [NSString stringWithFormat:@"%ld",typeIndex + 1],
                          @"page" : [NSString stringWithFormat:@"%ld",page],
                          };
    }
    return self;
}

/**
 添加新的收藏
 
 @param objectID 收藏对象id
 @param collecctionType 收藏类型
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionOperationWithCollectionObjectID:(NSString *)objectID
                                                       collectiontype:(NSInteger)collecctionType
                                                         isCollection:(BOOL)isCollection
{
    self = [super init];
    if (self) {
        
        if (isCollection) {
            self.requestReServiceType = @"User.Collection.addCollection";
            self.reAPIName = @"用户添加收藏";
        }else {
            self.requestReServiceType = @"User.Collection.cancelCollection";
            self.reAPIName = @"用户取消收藏";
        }
        
        self.reParams = @{
                          @"obj_id" : objectID,
                          @"type"   : [NSString stringWithFormat:@"%ld",collecctionType + 1],
                          };
    }
    return self;
}


@end
