//
//  NNHMyItem.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/23.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//  一个模型来描述cell每行的信息：图标、标题、右边内容（箭头，文字，开关等）

typedef NS_ENUM(NSInteger, NNHItemAccessoryViewType) {
    NNHItemAccessoryViewTypeNormal,   // 右边无内容
    NNHItemAccessoryViewTypeArrow,    // 右边显示箭头
    NNHItemAccessoryViewTypeRightLabel,  // 右边显示Label
    NNHItemAccessoryViewTypeSwitch,  // 右边显示开关
    NNHItemAccessoryViewTypeRightView,  // 右边显示箭头➕内容 / 箭头➕图片
    NNHItemAccessoryViewTypeCustomView,  // 右边自定义view
};

#import <Foundation/Foundation.h>

@interface NNHMyItem : NSObject

@property (nonatomic, copy) NSString *icon; /**< 图标*/
@property (nonatomic, copy) NSString *title; /**< 标题*/
@property (nonatomic, copy) NSString *detailTitle;/**< 副标题*/
@property (nonatomic, copy) NSString *rightTitle; /**< 当右边显示标题时 赋值*/
@property (nonatomic, copy) NSString *rightIcon; /**< 当右边显示小图标时 赋值*/
@property (nonatomic, copy) NSString *placeholder; /**< 占位文字，当传了此值 显示输入框*/
@property (nonatomic, strong) UIView *customRightView; /**< 自定义右边view */

@property (nonatomic, strong) UIColor *titleColor; /**< 标题颜色*/
@property (nonatomic, strong) UIFont *titleFont; /**< 标题字体*/
@property (nonatomic, strong) UIColor *detailColor;/**< 副标题颜色*/
@property (nonatomic, strong) UIFont *detailFont; /**< 副标题字体*/
@property (nonatomic, strong) UIColor *rightTitleColor;/**< 右标题颜色*/

@property (nonatomic, assign) Class destVcClass; /**< 点击这行cell，需要调转到哪个控制器 */
@property (nonatomic, copy) void (^operation)(void); /**< 封装点击这行cell想做的事情 */
@property (nonatomic, assign) NNHItemAccessoryViewType type; /**< 风格*/

#pragma 辅助属性
// 适用于角色选择
/* 提示数量 */
@property (nonatomic, copy) NSString *prompt;
/* 输入框当前键盘模式 */
@property (nonatomic, assign) UIKeyboardType currentKeyboardType;
/* 输入框内容限制长度 */
@property (nonatomic, assign) NSInteger limitLength;
/* 当前输入框里的内容 */
@property (nonatomic, copy) NSString *currentTextFieldText;

/** 适用于以方格排列的形式 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon;

/** 适用于以条形排列的形式 */
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon itemAccessoryViewType:(NNHItemAccessoryViewType)type;
+ (instancetype)itemWithTitle:(NSString *)title itemAccessoryViewType:(NNHItemAccessoryViewType)type;

@end
