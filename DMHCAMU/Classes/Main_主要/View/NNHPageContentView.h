//
//  NNHPageContentView.h
//  DMHCAMU
//
//  Created by 来旭磊 on 2018/1/13.
//  Copyright © 2018年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHPageContentView;

@protocol NNHPageContentViewDelegare <NSObject>
/// delegatePageContentView
- (void)nnh_pageContentView:(NNHPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

@end

@interface NNHPageContentView : UIView
/**
 *  对象方法创建 SGPageContentView
 *
 *  @param frame     frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;
/**
 *  类方法创建 SGPageContentView
 *
 *  @param frame     frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
+ (instancetype)pageContentViewWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;

/** delegatePageContentView */
@property (nonatomic, weak) id<NNHPageContentViewDelegare> pageContentViewDelegate;

/** 给外界提供的方法，获取 NNHSegmentedControl 选中按钮的下标, 必须实现 */
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex;

@end
