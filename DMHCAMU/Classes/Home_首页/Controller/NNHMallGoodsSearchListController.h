//
//  NNHMallGoodsSearchListController.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           商城商品搜索结果列表
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNHMallGoodsSearchListController : UIViewController

/**
 初始化商城商品列表控制器
 @param keywords 关键字
 @param categoryID 分类id
 @return 商城列表页
 */
- (instancetype)initListVcWithkeywords:(NSString *)keywords categoryID:(NSString *)categoryID;

/** 是否从搜索界面进来 */
@property (nonatomic, assign) BOOL pushFromSearchVc;

@end

