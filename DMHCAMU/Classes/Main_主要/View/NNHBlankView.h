//
//  NNHBlankView.h
//  ElegantLife
//
//  Created by 牛牛 on 16/5/4.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface NNHBlankView : UIView

@property (nonatomic, copy) void(^operationActionBlock)(void);

/*!
 @method
 @brief   无数据时显示页面
 @param   contents 提示文字 如果传操作按钮title则显示操作按钮
 */
- (instancetype)initWithContents:(NSArray *)contents blankIcon:(NSString *)icon operationButtonTitle:(NSString *)title;

/*!
 @method
 @brief   无网络时显示页面
 */
- (instancetype)initWithNoNetworkView;

@end
