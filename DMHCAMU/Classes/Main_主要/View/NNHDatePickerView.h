//
//  NNHDatePickerView.h
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/27.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

typedef NS_ENUM(NSInteger, NNHDatePickerType) {
    NNHDatePickerTypeYear, // 年
    NNHDatePickerTypeYearAndMonth, // 年月
    NNHDatePickerTypeDate, // 年月日
//    NNHDatePickerTypeDateHourMinute, // 年月日时分
//    NNHDatePickerTypeDateHourMinuteSecond, // 年月日时分秒
//    NNHDatePickerTypeTime, // 时分
//    NNHDatePickerTypeTimeAndSecond, // 时分秒
//    NNHDatePickerTypeMinuteAndSecond, // 分秒
//    NNHDatePickerTypeDateAndTime, // 月日周 时分
};

#import <UIKit/UIKit.h>

typedef  void(^ChooseDateBlock)(NSString *timeStr);

@interface NNHDatePickerView : UIView

@property (nonatomic, copy) ChooseDateBlock dateBlock;

/** minYear最小的年份，传0为2017 */
- (instancetype)initWithDatePickerType:(NNHDatePickerType)type minYear:(NSUInteger)minYear;

- (void)showDatePicker;

@end
