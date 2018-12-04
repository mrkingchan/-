//
//  NNHVerifyMobileController.h
//  ZTHYMall
//
//  Created by leiliao lai on 17/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           验证手机控制器
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNHVerifyMobileController : UIViewController

/**
 初始化控制器对象
 
 @param type 发送验证码类型
 @return 实例对象
 */
- (instancetype)initWithType:(NNHSendVerificationCodeType)type;

@end
