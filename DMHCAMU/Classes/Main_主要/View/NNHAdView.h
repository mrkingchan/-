//
//  NNHAdView.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/9/20.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHBannerModel;

@interface NNHAdView : UIView

/**
 *  显示广告页面方法
 */
- (void)show;

/**
 *  图片路径
 */
@property (nonatomic, copy) NSString *filePath;

/**
 *  展示时间s
 */
@property (nonatomic, assign) NSInteger timeout;

/**
 *  跳转
 */
@property (nonatomic, copy) void (^adJumpBlock) (void);

@end
