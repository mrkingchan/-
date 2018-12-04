//
//  NNHSetUpLoginPasswordViewController.h
//  YWL
//
//  Created by 来旭磊 on 2018/3/7.
//  Copyright © 2018年 NBT. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           设置登录密码

 
 @Remarks          <#注释#>
 
 *****************************************************/

/** 用户实体店订单列表 类型  */
typedef NS_ENUM(NSInteger, NNSetUpPasswordSourceType){
    NNSetUpPasswordSourceRegistered = 0,      // 注册
    NNSetUpPasswordSourceSetting = 1,    // 设置
};

#import <UIKit/UIKit.h>

@interface NNSetupLoginPasswordViewController : UIViewController

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 加密串 */
@property (nonatomic, copy) NSString *encrypt;
/** 手机号码 */
@property (nonatomic, copy) NSString *mobile;
/** 登录后初次设置登录密码 */
@property (nonatomic, assign, getter=isFirstSetUpPassword) BOOL firstSetUpPassword;

@end
