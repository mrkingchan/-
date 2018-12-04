//
//  NNHSettingViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHSettingViewController.h"
#import "NNHAccountSettingViewController.h"
#import "NNHMyProfileViewController.h"
#import "NNHMyGroup.h"
#import "NNHMyItem.h"
#import "NNHAlertTool.h"
#import "NNHApiLoginTool.h"
#import "NNHApplicationHelper.h"

@interface NNHSettingViewController ()

@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIButton *loginButton;

@end

@implementation NNHSettingViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self setupGroups];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"设置";
    self.tableView.tableFooterView = self.footerView;
}

- (void)setupGroups
{
    [self.groups removeAllObjects];
    [self setupGroup0];
    [self setupGroup2];
    [self setupGroup3];
    
    [self.tableView reloadData];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *infoItem = [NNHMyItem itemWithTitle:@"个人设置" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    NNHMyItem *accountItem = [NNHMyItem itemWithTitle:@"账户安全" itemAccessoryViewType:NNHItemAccessoryViewTypeArrow];
    
    infoItem.destVcClass = [NNHMyProfileViewController class];
    accountItem.destVcClass = [NNHAccountSettingViewController class];
    
    group.items = @[infoItem,accountItem];
}

- (void)setupGroup2
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    group.footer = @"要开启或停用，您可以在设置>通知中心>寰宇商城中设置";
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *messageItem = [NNHMyItem itemWithTitle:@"消息提醒" itemAccessoryViewType:NNHItemAccessoryViewTypeRightLabel];
    
    messageItem.rightTitle = [NNHProjectControlCenter sharedControlCenter].openMessagePush ? @"已开启" : @"已停用";

    
    group.items = @[messageItem];
}

- (void)setupGroup3
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    NNHMyItem *cacheItem = [NNHMyItem itemWithTitle:@"清除本地缓存" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
    NNHMyItem *currentVersionItem = [NNHMyItem itemWithTitle:@"当前版本" itemAccessoryViewType:NNHItemAccessoryViewTypeRightLabel];
    
    CGFloat cacheNum = [[SDImageCache sharedImageCache] getSize] / 1000.0 / 1024.0;
    cacheItem.rightTitle = cacheNum >= 1 ? [NSString stringWithFormat:@"%.2fM",cacheNum] : [NSString stringWithFormat:@"%.2fKB",cacheNum * 1024];
    currentVersionItem.rightTitle = [NSString stringWithFormat:@"V%@",[NNHProjectControlCenter sharedControlCenter].currentVersion];
    
    NNHWeakSelf(self)
    NNHWeakSelf(cacheItem)
    cacheItem.operation = ^{
        NNHStrongSelf(self)
        NNHStrongSelf(cacheItem)
        dispatch_async(dispatch_get_main_queue(),^{
            [[NNHAlertTool shareAlertTool] showAlertView:strongself title:@"提示" message:@"确定清除本地缓存?" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
                [SVProgressHUD showMessage:@"清除成功"];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
                strongcacheItem.rightTitle = @"0M";
                [strongself.tableView reloadData];
                
            } cancle:^{
            }];
        });
    };
    
    group.items = @[cacheItem,currentVersionItem];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)loginAction
{
    NNHWeakSelf(self)
    [[NNHAlertTool shareAlertTool] showAlertView:self title:@"确定要退出登录吗?" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{

        // 清除数据
        [[NNHApplicationHelper sharedInstance] logingOut];
        
        weakself.navigationController.tabBarController.selectedIndex=0;
        [weakself.navigationController popViewControllerAnimated:NO];
        
    } cancle:^{
        
    }];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UIView *)footerView
{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NNHOperationButtonH + NNHMargin_20 *2)];
        
        [_footerView addSubview:self.loginButton];
        [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(NNHMargin_15);
            make.right.mas_equalTo(-NNHMargin_15);
            make.top.equalTo(_footerView).offset(NNHMargin_20 *2);
            make.bottom.equalTo(_footerView);
        }];
    }
    return _footerView;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {        
        NSString *title = [[NNHProjectControlCenter sharedControlCenter] loginStatus:NO] ? @"退出登录" : @"登录";
        _loginButton = [UIButton NNHOperationBtnWithTitle:title target:self action:@selector(loginAction) operationButtonType:NNHOperationButtonTypeGrey isAddCornerRadius:YES];
    }
    return _loginButton;
}

@end
