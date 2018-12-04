//
//  NNHColorProtocol.h
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/18.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NNHColorProtocol <NSObject>


/** 所有函数都要以color开头哦 **/
/** 为了去掉消息转发时候的warning 才写optional 其实是requeired **/

@optional

#pragma mark -
#pragma mark ---------来自设计稿的主题色
/** 主色调 红色  **/
- (UIColor *)colorThemeRed;
/** 深黑色 **/
- (UIColor *)colorThemeDark;
/** 黑色  **/
- (UIColor *)colorThemeBlack;
/** 白色  **/
- (UIColor *)colorThemeWhite;
/** 深灰色  **/
- (UIColor *)colorThemeDarkGray;
/** 次要文字(小提示，日期颜色) #858080 **/
- (UIColor *)colorTextLightGray;
/** 主题黑色蒙版色 **/
- (UIColor *)colorThemeMaskBlack;
/** 分割线颜色 **/
- (UIColor *)colorThemeSeperatorLightGray;
/** 系统分割线颜色 **/
- (UIColor *)colorThemeSeperatorDarkGray;
/** VC 背景色 **/
- (UIColor *)colorThemeColorForVCBackground;
/** 提示性背景色 **/
- (UIColor *)colorThemeColorForPromptBackground;


#pragma mark -
#pragma mark ---------Navigation
/** 导航栏颜色 **/
- (UIColor *)colorNaviBarBgColor;
/** 导航title颜色 **/
- (UIColor *)colorNaviBarTitle;


#pragma mark -
#pragma mark ---------操作按钮
/** 操作按钮－#c6a351 **/
- (UIColor *)colorGoldOperation;
/** 操作按钮－#393945 **/
- (UIColor *)colorBlueOperation;
/** 不可用属性颜色 **/
- (UIColor *)colorThemeDisable;


#pragma mark -
#pragma mark ---------TabBar
/** TabBar颜色 **/
- (UIColor *)colorTabBarBgColor;
/** TabBar title颜色 **/
- (UIColor *)colorTabBarTitleDefault;
/** TabBar title高亮颜色 **/
- (UIColor *)colorTabBarTitleHeight;


#pragma mark -
#pragma mark ---------特殊文字颜色处理
/** 价格颜色 **/
- (UIColor *)colorPrice;
/** 商品标题颜色 **/
- (UIColor *)colorGoodsTitle;

@end
