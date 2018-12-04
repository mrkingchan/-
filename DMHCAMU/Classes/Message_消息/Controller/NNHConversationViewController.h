//
//  NNHConversationViewController.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           会话控制器
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <RongIMKit/RongIMKit.h>

@interface NNHConversationViewController : RCConversationViewController 

/** 客服名称 */
@property (nonatomic, copy) NSString *customerServicesName;

@end
