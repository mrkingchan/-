//
//  NNHMessageManager.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/17.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           消息管理者，负责所有消息及用户登录操作
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>
#import "NNHMessageUser.h"

@interface NNHMessageManager : NSObject

/** 用户信息数组 */
@property (nonatomic, strong) NSMutableArray <NNHMessageUser*>*userArray;

+ (NNHMessageManager *)shareManager;

/** 配置融云 **/
- (void)configRongCloud;

/** 处理融云登录状态 */
- (void)handleRongcloudConnectStatusWithReConnectBlock:(void(^)(void))reConnectBlock;

/** 根据用户token 登录融云 */
- (void)connectWithUserTokenSuccess:(void(^)(void))successBlock;

/** 根据用户userId 获取用户信息 */
- (void)nnh_getUserInfoWithUserId:(NSString*)userId completion:(void (^)(NNHMessageUser*))completion;
/** 退出登录 */
- (void)disconnent;

/** 更新用户消息提供者 */
- (void)updateUserInfoListWithArray:(NSArray *)array;

@end
