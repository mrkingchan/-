//
//  NNHAdvertScrollView.h
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/8/29.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           牛点首页、及商城首页 广告上下滚动的view
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@class NNHAdvertScrollView;

typedef enum : NSUInteger {
    // 一行文字滚动样式
    NNHAdvertScrollViewStyleNormal,
    // 二行文字滚动样式
    NNHAdvertScrollViewStyleMore,
} NNHAdvertScrollViewStyle;

@protocol NNHAdvertScrollViewDelegate <NSObject>
/// delegate
- (void)advertScrollView:(NNHAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface NNHAdvertScrollView : UIView

/** NNHAdvertScrollViewDelegate */
@property (nonatomic, weak) id<NNHAdvertScrollViewDelegate> delegate;

/** 默认 NNHAdvertScrollViewStyleNormal 样式 */
@property (nonatomic, assign) NNHAdvertScrollViewStyle advertScrollViewStyle;

/** 滚动时间间隔，默认为3s */
@property (nonatomic, assign) CFTimeInterval scrollTimeInterval;

/** NNHAdvertScrollViewStyleNormal 样式下的左边标志图片数组 */
@property (nonatomic, strong) NSArray *signImages;

/** NNHAdvertScrollViewStyleNormal 样式下的标题数组 */
@property (nonatomic, strong) NSArray *titles;

/** NNHAdvertScrollViewStyleNormal 样式下的标题字体颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *titleColor;

/** NNHAdvertScrollViewStyleNormal 样式下的标题文字位置，默认为 NSTextAlignmentLeft，仅仅针对 titles 起作用 */
@property (nonatomic, assign) NSTextAlignment textAlignment;

/** NNHAdvertScrollViewStyleMore 样式下的顶部左边标志图片数组 */
@property (nonatomic, strong) NSArray *topSignImages;

/** NNHAdvertScrollViewStyleMore 样式下的顶部标题数组 */
@property (nonatomic, strong) NSArray *topTitles;

/** NNHAdvertScrollViewStyleMore 样式下的底部左边标志图片数组 */
@property (nonatomic, strong) NSArray *bottomSignImages;

/** NNHAdvertScrollViewStyleMore 样式下的底部标题数组 */
@property (nonatomic, strong) NSArray *bottomTitles;

/** NNHAdvertScrollViewStyleMore 样式下的顶部标题字体颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *topTitleColor;

/** NNHAdvertScrollViewStyleMore 样式下的底部标题字体颜色，默认为黑色 */
@property (nonatomic, strong) UIColor *bottomTitleColor;

/** 标题字体大小，默认为13号字体 */
@property (nonatomic, strong) UIFont *titleFont;


@end
