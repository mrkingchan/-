//
//  NNHDefaultStyleColor.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/18.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHDefaultStyleColor.h"

/** 主色调 */
static NSString *const kColorThemeRed = @"#ca181d";
/** 深黑色 */
static NSString *const kColorThemeDark = @"#333333";
/** 深灰色 */
static NSString *const kColorThemeDarkGray = @"#666666";
/** 灰色 **/
static NSString *const kColorThemeLightGray = @"#999999";
/** 分割线颜色 **/
static NSString *const kColorThemeSeperatorLightGray = @"#e5e5e5";
/** 分割线颜色深 **/
static NSString *const kColorThemeSeperatorDarkGray = @"#cccccc";
/** 背景颜色 **/
static NSString *const kColorThemeVCBgWhiteGray= @"#eeeeee";
/** 描边 **/
static NSString *const kColorThemeBorder= @"#e0e0e0";

@implementation NNHDefaultStyleColor

#pragma mark -
#pragma mark ---------Navigation
/** 导航栏颜色 **/
- (UIColor *)colorNaviBarBgColor
{
    return [UIColor whiteColor];
}

/** 导航title颜色 **/
- (UIColor *)colorNaviBarTitle
{
    return [self colorThemeDark];
}


#pragma mark -
#pragma mark ---------TabBar
/** TabBar颜色 **/
- (UIColor *)colorTabBarBgColor
{
    return [UIColor whiteColor];
}

/** TabBar title颜色 **/
- (UIColor *)colorTabBarTitleDefault
{
    return [self colorThemeBlack];
}

/** TabBar title高亮颜色 **/
- (UIColor *)colorTabBarTitleHeight
{
    return [self colorThemeRed];
}

#pragma mark -
#pragma mark ---------来自设计稿的主题色
/** 主色调 红色  **/
- (UIColor *)colorThemeRed
{
    return [UIColor akext_colorWithHex:kColorThemeRed];
}

/** 深黑色 **/
- (UIColor *)colorThemeDark
{
    return [UIColor akext_colorWithHex:kColorThemeDark];
}

/** 黑色  **/
- (UIColor *)colorThemeBlack
{
    return [UIColor akext_colorWithHex:kColorThemeDark];
}

/** 白色  **/
- (UIColor *)colorThemeWhite
{
    return [UIColor whiteColor];
}

/** 深灰色  **/
- (UIColor *)colorThemeDarkGray;
{
    return [UIColor akext_colorWithHex:kColorThemeDarkGray];
}

/** 次要文字(小提示，日期颜色) #858080 **/
- (UIColor *)colorTextLightGray
{
    return [UIColor akext_colorWithHex:kColorThemeLightGray];
}

/** 主题黑色蒙版色 **/
- (UIColor *)colorThemeMaskBlack
{
    return [[self colorThemeBlack] colorWithAlphaComponent:.9];
}

/** 分割线颜色 **/
- (UIColor *)colorThemeSeperatorLightGray
{
    return [UIColor akext_colorWithHex:kColorThemeSeperatorLightGray];
}

/** 系统分割线颜色 **/
- (UIColor *)colorThemeSeperatorDarkGray
{
    return [UIColor akext_colorWithHex:kColorThemeSeperatorDarkGray];
}

/** VC 背景色 **/
- (UIColor *)colorThemeColorForVCBackground
{
    return [UIColor akext_colorWithHex:kColorThemeVCBgWhiteGray];
}

/** 提示性背景色 **/
- (UIColor *)colorThemeColorForPromptBackground
{
    return NNHRGBColor(241, 250, 253);
}

#pragma mark -
#pragma mark ---------操作按钮
/** 操作按钮－#c6a351 **/
- (UIColor *)colorGoldOperation;
{
    return [UIColor akext_colorWithHex:@"#c6a351"];
}

/** 操作按钮－#393945 **/
- (UIColor *)colorBlueOperation
{
    return [UIColor akext_colorWithHex:@"#393945"];
}

/** 不可用属性颜色 **/
- (UIColor *)colorThemeDisable
{
    return NNHRGBColor(204, 204, 204);
}

#pragma mark -
#pragma mark ---------特殊文字颜色处理
/** 价格颜色 **/
- (UIColor *)colorPrice
{
    return [UIColor akext_colorWithHex:@"#f6bf4d"];
}

/** 商品标题颜色 **/
- (UIColor *)colorGoodsTitle
{
    return [UIColor akext_colorWithHex:@"#535353"];
}

@end
