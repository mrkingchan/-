//
//  NNSetupPayPasswordViewController.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

/** 判断从那个页面进入 */
typedef NS_ENUM(NSInteger, NNHChangePayCodeFromType) {
    NNHChangePayCodeFromType_FistChange,     //第一次修改资金密码
    NNHChangePayCodeFromType_Other,          //其他页面 （返回两次）
};

@interface NNSetupPayPasswordViewController : UIViewController

- (instancetype)initWithFromType:(NNHChangePayCodeFromType)fromType;


@end
