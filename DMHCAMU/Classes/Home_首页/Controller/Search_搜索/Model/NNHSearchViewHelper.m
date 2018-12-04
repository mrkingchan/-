//
//  NNHSearchViewHelper.m
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHSearchViewHelper.h"

NSString * const NNHSearchLocalHistorySave_GoodsKey = @"NNHSearchLocalHistorySave_GoodsKey";

@interface NNHSearchViewHelper ()

/** 本地保存历史记录key值 */
@property (nonatomic, copy) NSString *localHistorySearchSaveKey;

@end

@implementation NNHSearchViewHelper

/** 搜索页面 */
- (instancetype)init
{
    if (self = [super init]) {
        _localHistorySearchSaveKey = NNHSearchLocalHistorySave_GoodsKey;
    }
    return self;
}

/** 获取历史搜索数组 */
- (NSMutableArray *)getHistorySearchArray
{
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.localHistorySearchSaveKey];
    [self.historyArray removeAllObjects];
    [self.historyArray addObjectsFromArray:array];
    return self.historyArray;
}

/** 添加一条新的搜索记录 */
- (void)addNewHistoryWithSearchText:(NSString *)searchText;
{
    if ([searchText isEqualToString:@" "]) return;
    if ([searchText isEqualToString:@""]) return;
    BOOL isExist = NO;
    for (NSString *string in self.historyArray) {
        if ([string isEqualToString:searchText]) {
            isExist = YES;
            break;
        }
    }
    if (!isExist) {
        [self.historyArray insertObject:searchText atIndex:0];
    }
    else {
        [self.historyArray removeObject:searchText];
        [self.historyArray insertObject:searchText atIndex:0];
    }
    
    // 最多就10条
    if (self.historyArray.count > 10) {
        for (int i = 10; i<self.historyArray.count; i++) {
            [self.historyArray removeObjectAtIndex:i];
        }
    }
    [self updateLocalHistoryRecord];
}

/** 删除某一行的搜索记录 */
- (void)deleteHistroySearchRecordAtIndex:(NSInteger)index
{
    [self.historyArray removeObjectAtIndex:index];
    [self updateLocalHistoryRecord];
}

/** 清空所有的历史记录 */
- (void)removeAllHistorySearchRecord
{
    [self.historyArray removeAllObjects];
    [self updateLocalHistoryRecord];
}

/** 更新本地搜索记录 */
- (void)updateLocalHistoryRecord
{
    [[NSUserDefaults standardUserDefaults] setObject:self.historyArray forKey:self.localHistorySearchSaveKey];
}

- (NSMutableArray *)historyArray
{
    if (_historyArray == nil) {
        _historyArray = [NSMutableArray array];
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:self.localHistorySearchSaveKey];
        [_historyArray addObjectsFromArray:array];
    }
    return _historyArray;
}

@end
