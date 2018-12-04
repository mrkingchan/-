//
//  NNHMessageManager.m
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/17.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMessageManager.h"
#import "NNHAPIRongCloudTool.h"
#import "NNHVoiceSynthesisHelper.h"

@interface NNHMessageManager ()<RCIMReceiveMessageDelegate, RCIMUserInfoDataSource>

/** 约定的系统消息用户数组 */
@property (nonatomic, strong) NSArray *systemUserArray;

@end

@implementation NNHMessageManager

#pragma mark -
#pragma mark -------- Lifecycle

- (instancetype)init{
    if (self = [super init]) {
        
        if ([[NNHProjectControlCenter sharedControlCenter] Config_isTestMode]) {
            [[RCIM sharedRCIM] initWithAppKey:NNH_RongCloud_Appkey_Develop];
        }else{
            [[RCIM sharedRCIM] initWithAppKey:NNH_RongCloud_Appkey];
        }
        
        [[RCIMClient sharedRCIMClient] setLogLevel:RC_Log_Level_Error];
        
        [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
        [RCIM sharedRCIM].enableMessageAttachUserInfo = YES;
        //持久化获取用户信息
        [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;
        //设置用户信息提供者
        [RCIM sharedRCIM].userInfoDataSource = self;
    }
    return self;
}

+ (NNHMessageManager *)shareManager{
    
    static NNHMessageManager* manager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        manager = [[[self class] alloc] init];
    });
    return manager;
}

#pragma mark -
#pragma mark --------- PublicMethod
- (void)configRongCloud
{
    NNHWeakSelf(self)
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NNHStrongSelf(self)
        [strongself connectWithUserTokenSuccess:nil];
    });
}

/** 判断融云登录状态 */
- (void)handleRongcloudConnectStatusWithReConnectBlock:(void(^)(void))reConnectBlock
{
    RCConnectionStatus status = [[RCIM sharedRCIM] getConnectionStatus];
    if (status != ConnectionStatus_Connected) {
        [self connectWithUserTokenSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if (reConnectBlock) {
                    reConnectBlock();
                }
            });
        }];
    }
}

- (void)connectWithUserTokenSuccess:(void(^)(void))successBlock;
{
    NSString *token = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.mtoken;
    [self disconnent];
    if (token.length > 0) {
        NNHLog(@"登录融云token");
        [self loginWithUserToken:token success:^{
            if (successBlock) {
                successBlock();
            }
        }];
    }
}

/** 根据用户token 登录融云 */
- (void)loginWithUserToken:(NSString *)token success:(void(^)(void))successBlock;
{
    NNHWeakSelf(self)
    NNHAPIRongCloudTool *loginTool = [[NNHAPIRongCloudTool alloc] initTokenWithUserToken:token];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NNHStrongSelf(self)
            
            [strongself setCurrentLoginUserWithInfo:responseDic];
            [strongself connectWithToken:responseDic[@"data"][@"token"] success:^(NSString *userId) {
                
                if (successBlock) {
                    successBlock();
                }
            }];
        });
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)connectWithToken:(NSString *)token success:(void(^)(NSString *userId))successBlock
{
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NNHLog(@"登陆成功。当前登录的用户ID：%@", userId);
        
        successBlock(userId);
    } error:^(RCConnectErrorCode status) {
        NNHLog(@"登陆的错误码为:%ld", (long)status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NNHLog(@"token错误");
    }];
}

/** 退出登录 */
- (void)disconnent
{
    RCConnectionStatus status = [[RCIM sharedRCIM] getConnectionStatus];
    if (status == ConnectionStatus_Connected) {
        [[RCIM sharedRCIM] disconnect:NO];
    }
}

/** 更新用户消息提供者 */
- (void)updateUserInfoListWithArray:(NSArray *)array
{
    [self.userArray removeAllObjects];
    [self.userArray addObjectsFromArray:array];
    [self.userArray addObjectsFromArray:self.systemUserArray];
}

#pragma mark -
#pragma mark ---------RCIMUserInfoDataSource
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion
{
    //本地通知必须提供消息用户信息
    [self nnh_getUserInfoWithUserId:userId completion:^(NNHMessageUser *messageUser) {
        if (messageUser == nil) {
            RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:@"客服" portrait:@""];
            completion(userInfo);
        }else {
            RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:messageUser.name portrait:messageUser.portraitUri];
            completion(userInfo);
        }
    }];
}

#pragma mark -
#pragma mark --------- RCIMReceiveMessageDelegate
- (void)onRCIMReceiveMessage:(RCMessage *)message
                        left:(int)left
{
    [[NSNotificationCenter defaultCenter] postNotificationName:NNH_NotificationMessage_messageCenterGetNewMessage object:message];
    //文字消息
    if ([message.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *textMessage = (RCTextMessage *)message.content;
        if (textMessage.extra) {
#warning 改了解码方法
            NSDictionary *orderDict = [textMessage.extra jsonValueDecoded];
            if (orderDict[@"voice_content"] && [orderDict[@"voice_content"] length]) {
                [[NNHVoiceSynthesisHelper sharedInstance] speechText:orderDict[@"voice_content"]];
                [RCIM sharedRCIM].disableMessageAlertSound = YES;
            }else {
                [RCIM sharedRCIM].disableMessageAlertSound = NO;
            }
        }
    }
    
    //图文消息
    if ([message.content isKindOfClass:[RCRichContentMessage class]]) {
        
        RCRichContentMessage *richMessage = (RCRichContentMessage *)message.content;
        if (richMessage.extra) {
#warning 改了解码方法
            NSDictionary *orderDict = [richMessage.extra jsonValueDecoded];
            if (orderDict[@"voice_content"] && [orderDict[@"voice_content"] length]) {
                [[NNHVoiceSynthesisHelper sharedInstance] speechText:orderDict[@"voice_content"]];
                [RCIM sharedRCIM].disableMessageAlertSound = YES;
            }else {
                [RCIM sharedRCIM].disableMessageAlertSound = NO;
            }
        }
    }
}

/**
 前台消息是否自定义
 
 @param message 消息
 @return 是否给出自定义消息
 */
-(BOOL)onRCIMCustomAlertSound:(RCMessage*)message
{
    if ([self isAllowedSoundNotification]) {
        return NO;
    }else {
        return YES;
    }
}

- (BOOL)onRCIMCustomLocalNotification:(RCMessage *)message withSenderName:(NSString *)senderName
{
    [self addLocalNotificationWithMessage:message sendName:senderName];
    return YES;
}

-(void)addLocalNotificationWithMessage:(RCMessage *)message sendName:(NSString *)sendName
{
    //定义本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:0];//立即触发
    //设置通知属性
    notification.alertBody = [self getNotificationPushContentWithMessage:message sendName:sendName]; //通知主体
    notification.applicationIconBadgeNumber = 1;//应用程序图标右上角显示的消息数
    notification.alertAction = @"打开应用"; //待机界面的滑动动作提示
    if ([self isAllowedSoundNotification]) {
        notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    }
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

- (NSString *)getNotificationPushContentWithMessage:(RCMessage *)message sendName:(NSString *)sendName
{
    NSString *pushContent = @"您有一条新的消息~";
    
    //    if (message.conversationType != ConversationType_SYSTEM){
    if ([message.targetId isEqualToString:NNH_RongCloud_Message_OrderHandle]) {
        //订单处理消息
        pushContent = [self get_nnhNotificationContentWithMessage:message];
    }else if ([message.targetId isEqualToString:NNH_RongCloud_Message_RechargeOrWidth]){
        //充值提现
        pushContent = [self get_nnhNotificationContentWithMessage:message];
    }else if ([message.targetId isEqualToString:NNH_RongCloud_Message_Income]){
        //分润收益
        pushContent = [self get_nnhNotificationContentWithMessage:message];
    }else if ([message.targetId isEqualToString:NNH_RongCloud_Message_System]){
        //系统消息
        pushContent = [self get_nnhNotificationContentWithMessage:message];
    }else {
        //私聊消息-客服
        NSString *subTitle = @"";
        if ([message.content isKindOfClass:[RCTextMessage class]]) {
            RCTextMessage *textMsg = (RCTextMessage *)message.content;
            subTitle = textMsg.content;
        } else if ([message.content isKindOfClass:[RCImageMessage class]]) {
            subTitle = @"[图片]";
        } else if ([message.content isKindOfClass:[RCVoiceMessage class]]) {
            subTitle = @"[语音]";
        } else if ([message.content isKindOfClass:[RCLocationMessage class]]) {
            subTitle = @"[位置]";
        }else if ([message.content isKindOfClass:[RCRichContentMessage class]]) {
            RCRichContentMessage *richMessage = (RCRichContentMessage *)message.content;
            subTitle = richMessage.title;
        }else {
            subTitle = @"您有一条新的消息~";
        }
        pushContent = [NSString stringWithFormat:@"%@：%@",sendName,subTitle];
    }
    //    }
    return pushContent;
}

/** 根据消息类型不同获取消息展示内容 */
- (NSString *)get_nnhNotificationContentWithMessage:(RCMessage *)message
{
    NSString *pushContent = @"您有一条新的消息~";
    //文字消息
    if ([message.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *textMessage = (RCTextMessage *)message.content;
        pushContent = textMessage.content;
    }
    //图文消息
    if ([message.content isKindOfClass:[RCRichContentMessage class]]) {
        RCRichContentMessage *richMessage = (RCRichContentMessage *)message.content;
        pushContent = richMessage.title;
    }
    return pushContent;
}

//是否允许声音推送
- (BOOL)isAllowedSoundNotification
{
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        if (setting.types & UIUserNotificationTypeSound) {
            return YES;
        }else {
            return NO;
        }
    }else {
        return NO;
    }
    return YES;
}


#pragma mark -
#pragma mark ---------用户信息相关
/** 设置当前登录用户信息 */
- (void)setCurrentLoginUserWithInfo:(NSDictionary *)info
{
    NSString *userId = info[@"data"][@"userid"];
    NSString *name = info[@"data"][@"name"];
    NSString *portraitUri = info[@"data"][@"portraitUri"];
    
    RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portraitUri];
    [[RCIM sharedRCIM] setCurrentUserInfo:userInfo];
}

/** 根据用户userId 获取用户信息 */
- (void)nnh_getUserInfoWithUserId:(NSString*)userId completion:(void (^)(NNHMessageUser *))completion
{
    [self.userArray enumerateObjectsUsingBlock:^(NNHMessageUser * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([userId isEqualToString:obj.userid]) {
            completion(obj);
            *stop = YES;
        }
    }];
    completion(nil);
}

- (NSMutableArray *)userArray
{
    if (_userArray == nil) {
        _userArray = [NSMutableArray array];
    }
    return _userArray;
}

- (NSArray *)systemUserArray
{
    if (_systemUserArray == nil) {
        NNHMessageUser *incomeUser = [[NNHMessageUser alloc] init];
        incomeUser.name = @"分润消息";
        incomeUser.userid = NNH_RongCloud_Message_Income;
        _systemUserArray = @[incomeUser];
    }
    return _systemUserArray;
}

@end
