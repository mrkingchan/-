//
//  NNHAccountSettingViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAccountSettingViewController.h"
#import "NNHSetupMobileViewController.h"
#import "NNSetupLoginPasswordViewController.h"
#import "NNSetupPayPasswordViewController.h"
#import "NNHUserModel.h"
#import "NNHApiUserTool.h"
#import "NNHVerifyMobileController.h"
#import "NNHMyGroup.h"
#import "NNHMyItem.h"

@interface NNHAccountSettingViewController ()

/** 修改手机号码 */
@property (nonatomic, strong) NNHMyItem *phoneItem;
/** 修改登录密码 */
@property (nonatomic, strong) NNHMyItem *loginPwdItem;
/** 修改支付密码 */
@property (nonatomic, strong) NNHMyItem *walletPwdItem;
/** 用户数据 */
@property (nonatomic, strong) NNHUserModel *userModel;

@end

@implementation NNHAccountSettingViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self changeAccountSecurityStatus];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"账户安全";
    self.tableView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    
    [self setupGroups];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self.tableView reloadData];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    group.items = @[self.phoneItem, self.walletPwdItem, self.loginPwdItem];
}

- (void)changeAccountSecurityStatus
{
    self.userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    self.phoneItem.rightTitle = self.userModel.mobile;
    
    if ([self.userModel.payDec boolValue]) {
        self.walletPwdItem.rightTitle = @"已设置";
        self.walletPwdItem.rightTitleColor = [UIColor akext_colorWithHex:@"#009759"];
    }else{
        self.walletPwdItem.rightTitle = @"未设置";
        self.walletPwdItem.rightTitleColor = [UIConfigManager colorTextLightGray];
    }
    
    if ([self.userModel.isloginpwd boolValue]) {
        self.loginPwdItem.rightTitle = @"已设置";
        self.loginPwdItem.rightTitleColor = [UIColor akext_colorWithHex:@"#009759"];
    }else{
        self.loginPwdItem.rightTitle = @"未设置";
        self.loginPwdItem.rightTitleColor = [UIConfigManager colorTextLightGray];
    }
    
    [self.tableView reloadData];
}

- (NNHMyItem *)phoneItem
{
    if (_phoneItem == nil) {
        _phoneItem = [NNHMyItem itemWithTitle:@"修改手机" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NNHWeakSelf(self)
        _phoneItem.operation = ^{
            NNHVerifyMobileController *phoneVC = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_updatePhone];
            [weakself.navigationController pushViewController:phoneVC animated:YES];
        };
    }
    return _phoneItem;
}

- (NNHMyItem *)loginPwdItem
{
    if (_loginPwdItem == nil) {
        _loginPwdItem = [NNHMyItem itemWithTitle:@"登录密码" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NNHWeakSelf(self)
        _loginPwdItem.operation = ^{
            if ([weakself.userModel.isloginpwd boolValue]) {
                NNHVerifyMobileController *phoneVC = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_changeLoginPassword];
                [weakself.navigationController pushViewController:phoneVC animated:YES];
            }else{
                NNSetupLoginPasswordViewController *vc = [[NNSetupLoginPasswordViewController alloc] init];
                vc.firstSetUpPassword = YES;
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return _loginPwdItem;
}

- (NNHMyItem *)walletPwdItem
{
    if (_walletPwdItem == nil) {
        _walletPwdItem = [NNHMyItem itemWithTitle:@"支付密码" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        
        NNHWeakSelf(self)
        _walletPwdItem.operation = ^{
            if ([weakself.userModel.payDec isEqualToString:@"1"]) {
                NNHVerifyMobileController*verifyMobileVC = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_changePayPassword];
                [weakself.navigationController pushViewController:verifyMobileVC animated:YES];
            }else {
                NNSetupPayPasswordViewController *changPayCodeVc = [[NNSetupPayPasswordViewController alloc] initWithFromType:NNHChangePayCodeFromType_FistChange];
                [weakself.navigationController pushViewController:changPayCodeVc animated:YES];
            }
        };
    }
    return _walletPwdItem;
}

@end
