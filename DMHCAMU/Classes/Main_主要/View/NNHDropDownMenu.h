//
//  NNHDropDownMenu.h
//  ElegantLife
//
//  Created by 牛牛 on 16/9/24.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHDropDownMenu : UIView

/**
 *  内容
 */
@property (nonatomic, strong) UIView *content;

/**
 *  内容控制器
 */
@property (nonatomic, strong) UIViewController *contentController;

+ (instancetype)menu;

/**
 *  显示
 */
- (void)showFrom:(UIView *)from;

/**
 *  销毁
 */
- (void)dismiss;

@end
