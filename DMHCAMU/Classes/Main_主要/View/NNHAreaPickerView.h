//
//  NNHAreaPickerView.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHPickerVeiw.h"

@interface NNHAreaPickerView : NNHPickerVeiw

/** 选择地区的回调 **/
@property (nonatomic, copy) void(^didSelectedAreaBlock)(NSString *codeStr, NSString *provinceName, NSString *cityName, NSString *areaName);

@end
