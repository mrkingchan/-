//
//  NNHApiMyCollectionTool.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/19.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNHApiMyCollectionTool.h"

@implementation NNHApiMyCollectionTool

/**
 获取用户收藏列表
 @param page 页码
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionListWithPage:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"User.Collection.collectionList";
        self.reAPIName = @"获取用户收藏列表";
        self.reParams = @{
                          @"type" : @"1",
                          @"page" : [NSString stringWithFormat:@"%ld",page],
                          };
    }
    return self;
}

/**
 用户收藏操作

 @param objectID 收藏对象id
 @param isCollection 收藏还是取消收藏
 @return 数据请求类
 */
- (instancetype)initWithUserCollectionOperationWithCollectionObjectID:(NSString *)objectID
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
                          @"type"   : @"1",
                          };
    }
    return self;
}

@end
