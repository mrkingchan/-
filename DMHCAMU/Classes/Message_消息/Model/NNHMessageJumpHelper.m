//
//  NNHMessageJumpHelper.m
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/19.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMessageJumpHelper.h"
#import "NNHMessageManager.h"
#import "NNHAPIRongCloudTool.h"

#import "NNHConversationViewController.h"


@implementation NNHMessageJumpHelper

/** 根据businessID 开启新的会话 */
+ (void)startConversatonWithGoodsDetailController:(UIViewController *)controller businessID:(NSString *)businessID
{
    NNHAPIRongCloudTool *rongColoudTool = [[NNHAPIRongCloudTool alloc] initCustomerServicesIDWithBusinessID:businessID];
    
    [rongColoudTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {

        NSString *targetID = responseDic[@"data"][@"userid"];
        dispatch_async(dispatch_get_main_queue(), ^{

            NNHConversationViewController *chatVc = [[NNHConversationViewController alloc] initWithConversationType:ConversationType_PRIVATE targetId:targetID];
            chatVc.targetId = targetID;
            chatVc.customerServicesName = responseDic[@"data"][@"name"];
            //显示聊天会话界面
            [controller.navigationController pushViewController:chatVc animated:YES];
        });
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

@end
