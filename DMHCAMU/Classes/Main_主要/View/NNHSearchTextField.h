//
//  NNHSearchTextField.h
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/2.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           导航栏搜索TextField
 
 @Remarks          <#注释#>
 
 *****************************************************/



#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NNHSearchTextFieldUIStyle) {
    NNHSearchTextFieldUIStyle_White = 0,
    NNHSearchTextFieldUIStyle_Gray = 1,
};

@class NNHSearchTextField;

@protocol NNHSearchTextFieldDelegate <NSObject>

- (void)textFieldOfCurrentText:(NNHSearchTextField *)textField;

@end

@interface NNHSearchTextField : UIView

/** textField */
@property (nonatomic, strong) UITextField *textField;

/** 占位文字 */
@property (nonatomic, copy) NSString *placeHoldString;

@property (nonatomic, weak) id<NNHSearchTextFieldDelegate> tfDelegate;

/** textField 右侧view */
@property (nonatomic, strong) UIView *rightView;

/** 普通构造 **/
- (instancetype)initWithFrame:(CGRect)frame placeHold:(NSString *)placeHold uiStyle:(NNHSearchTextFieldUIStyle)style;

- (instancetype)initWithPlaceHold:(NSString *)placeHold uiStyle:(NNHSearchTextFieldUIStyle)style;


@end
