//
//  NNHLoginRegisterViewController.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/2/27.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNHLoginViewController : UIViewController

typedef  void (^completionBlock)(void);

//类方法初始化，方便调用吧~
+ (instancetype)presentInViewController:(UIViewController *)VC withAniamtion:(BOOL)Aniamtion andCompletion:(completionBlock)block;
//实例方法消失
- (void)dismissVC;

/** 登陆成功的回调 */
@property (nonatomic, copy) completionBlock successLoginblock;

// 扫描二维码后用到的参数
/** 登陆成功block 带参数type 用于扫描二维码 */
@property (nonatomic, copy) void(^successLoginTypeBlock)(NSString *type);
/** 引荐人id */
@property (nonatomic, copy) NSString *parentid;
/** 引荐人校验码 */
@property (nonatomic, copy) NSString *checkcode;
/** 平台号 */
@property (nonatomic, copy) NSString *stocode;

@end
