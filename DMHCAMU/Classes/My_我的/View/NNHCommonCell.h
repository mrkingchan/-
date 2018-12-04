//
//  NNHCommonCell.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyItem, NNHCountDownButton;

@interface NNHCommonCell : UITableViewCell

/** cell数据模型 **/
@property (nonatomic, strong) NNHMyItem *myItem;
/** 倒计时 **/
@property (nonatomic, copy) void (^sendVerificationCodeBlock)(NNHCountDownButton *countBtn);
/** 监听输入框 **/
@property (nonatomic, copy) void (^textFieldValueChangedBlock)(NSString *text, NNHMyItem *myItem);

@end
