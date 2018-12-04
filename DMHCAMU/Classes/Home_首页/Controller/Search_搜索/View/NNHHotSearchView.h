//
//  NNHHotSearchView.h
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

//搜索页面热门搜索控件

#import <UIKit/UIKit.h>

@interface NNHHotSearchView : UIView

/** 热门搜索数组 */
@property (nonatomic, strong) NSMutableArray *hotSearchArray;
/** 点击热词回调 */
@property (nonatomic, copy) void(^hotSearchWordClickBlock)(NSInteger tag, NSString *hotWord);

/** 清空按钮选择选中状态 */
- (void)clearSubViewstatus;

@end
