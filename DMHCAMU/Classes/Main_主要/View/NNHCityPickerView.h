//
//  NNHAddressPickerView.h
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/27.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           省市区选择控件
 
 @Remarks          暂时控件高度写死为屏幕高度
 
 *****************************************************/

typedef  void(^AddressPickerBlock)(NSString *province, NSString *city, NSString *district);

#import <UIKit/UIKit.h>

@interface NNHCityPickerView : UIView

@property (nonatomic,copy) AddressPickerBlock addressPickerBlock;

/** 添加到父控件上 */
+ (instancetype)showInSuperView:(UIView *)superView complete:(AddressPickerBlock )addressPickerBlock;

@end
