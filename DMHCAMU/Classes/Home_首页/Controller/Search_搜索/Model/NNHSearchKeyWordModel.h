//
//  NNHSearchKeyWordModel.h
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/25.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHSearchKeyWordModel : NSObject

/** 搜索框文字内容 */
@property (nonatomic, copy) NSString *name;
/** 搜索类型 2-实体店 1-商城 */
@property (nonatomic, copy) NSString *type;
/** 搜索热词 */
@property (nonatomic, strong) NSMutableArray <NSString *>*keywords;

@end
