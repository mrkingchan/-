//
//  NNHConversationViewController.m
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHConversationViewController.h"
#import "NNHAPIRongCloudTool.h"
#import "NNHMessageUser.h"
@interface NNHConversationViewController ()

@end

@implementation NNHConversationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏对话人名称
    self.displayUserNameInCell = NO;
    
    if (self.customerServicesName) {
        self.navigationItem.title =self.customerServicesName;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    
    if (self.customerServicesName) return;
    //获取用户信息
    NNHWeakSelf(self)
    NNHAPIRongCloudTool *rongCloudTool = [[NNHAPIRongCloudTool alloc] initUserListWithUserID:self.targetId];
    [rongCloudTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NSArray *array = responseDic[@"data"];
        NSArray *userArray = [NNHMessageUser mj_objectArrayWithKeyValuesArray:array];
        if (userArray.count > 0) {
            NNHMessageUser *user = userArray[0];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.navigationItem.title = user.name;
                
            });
        }else {
         weakself.navigationItem.title = @"客服";
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}

@end
