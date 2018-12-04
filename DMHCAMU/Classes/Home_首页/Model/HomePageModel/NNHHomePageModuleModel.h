//
//  NNHHomePageModuleModel.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/22.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页 模块数据模型
 
 @Remarks          配置
 
 *****************************************************/

#import "NNHHomePageBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NNHHomePageModuleModel : NNHHomePageBaseModel

/** id */
@property (nonatomic, copy) NSString *moduleID;
/** code */
@property (nonatomic, copy) NSString *modulecode;
/** 排序 */
@property (nonatomic, copy) NSString *sort;

@end

NS_ASSUME_NONNULL_END
