//
//  NNHHomeCustomNavView.h
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           主页 头部view
 
 @Remarks          view
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNHHomeTitleView : UIView


/** 点击购物车 */
@property (nonatomic, copy) void(^rightItemActionBlock)(void);
/** 搜索框回调 */
@property (nonatomic, copy) void(^didClickSearchBlock)(NSString *keywords);
/** 点击搜索框 */
@property (nonatomic, copy) void(^didBeginEditSearchBlock)(void);

/** 输入框是否可以输入文字 */
@property (nonatomic, assign) BOOL canInputText;

/** UIView */
@property (nonatomic, strong) UIView *rightItemView;

/** 显示关键字 */
@property (nonatomic, copy) NSString *keywords;

/** 背景颜色 */
@property (nonatomic, strong) UIColor *textFieldGroundColor;

@end


