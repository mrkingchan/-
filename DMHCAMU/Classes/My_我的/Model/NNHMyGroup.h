//
//  NNHMyGroup.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/23.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//  一个group ＝＝ 一个section

#import <Foundation/Foundation.h>

@interface NNHMyGroup : NSObject

/** 组头 */
@property (nonatomic, copy) NSString *header;
/** 组尾 */
@property (nonatomic, copy) NSString *footer;
/** 存放的是item模型 */
@property (nonatomic, strong) NSArray *items;
/** 每行最多显示多少item */
@property (nonatomic, assign) NSInteger maxCol;
/** 每组item宽度高度的比例 */
@property (nonatomic, assign) CGFloat scale;
/** 分割线，默认0.5f */
@property (nonatomic, assign) CGFloat lineWidth;
/** 是否显示分割线 */
@property (nonatomic, assign, getter=isLineEable) BOOL lineEable;

// 辅助属性
/** 返回section的高度 */
@property (nonatomic, assign, readonly) CGFloat sectionHeight;

+ (instancetype)group;

@end
