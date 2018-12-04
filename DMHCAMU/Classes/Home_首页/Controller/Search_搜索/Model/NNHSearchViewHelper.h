//
//  NNHSearchViewHelper.h
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

//搜索界面帮助类

#import <Foundation/Foundation.h>

@interface NNHSearchViewHelper : NSObject

/** 历史搜索记录数组 */
@property (nonatomic, strong) NSMutableArray *historyArray;

/** 获取历史搜索数组 */
- (NSMutableArray *)getHistorySearchArray;

/** 添加一条新的搜索记录 */
- (void)addNewHistoryWithSearchText:(NSString *)searchText;

/** 删除某一行的搜索记录 */
- (void)deleteHistroySearchRecordAtIndex:(NSInteger)index;

/** 清空所有的历史记录 */
- (void)removeAllHistorySearchRecord;

@end
