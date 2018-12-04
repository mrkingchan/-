//
//  NNHSearchHistorySectionHeaderView.h
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

//搜索页面列表sectionHeaderView

#import <UIKit/UIKit.h>

@interface NNHSearchHistorySectionHeaderView : UITableViewHeaderFooterView

/** 清空历史搜索block */
@property (nonatomic, copy) void(^removeAllOperationBlock)(void);

@end
