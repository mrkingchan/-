//
//  NNHLoginRegisterViewController.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/2/27.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHLoginViewController.h"
#import "NNHRegisterViewController.h"
#import "NNHVerifyMobileController.h"
#import "NNHLoginTextField.h"
#import "NNHApiLoginTool.h"
#import "NNHNavigationController.h"
#import "NNHMessageManager.h"

@interface NNHLoginViewController ()

/** 电话号码 */
@property (nonatomic, strong) NNHLoginTextField *phoneTextFiled;
/** 密码 */
@property (nonatomic, strong) NNHLoginTextField *passwordTextFiled;
/** 登录按钮 */
@property (nonatomic, strong) UIButton *loginButton;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
/** 忘记密码按钮 */
@property (nonatomic, strong) UIButton *missCodeButton;
/** 注册 */
@property (nonatomic, strong) UIButton *registerButton;

@end

/** 跳出VC **/
static BOOL  isClick = YES;
@implementation NNHLoginViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupChildView];
}

/** 添加子控件 */
- (void)setupChildView
{
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-NNHMargin_10);
        make.top.equalTo(self.view).offset(STATUSBAR_HEIGHT);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"登录" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:34]];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backButton.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(15);
    }];
    
    CGFloat marginX = 42;
    [self.view addSubview:self.phoneTextFiled];
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(110);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH - marginX * 2));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.view addSubview:self.passwordTextFiled];
    [self.passwordTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(15);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [self.view addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.passwordTextFiled.mas_bottom).offset(50);
        make.centerX.equalTo(self.phoneTextFiled);
        make.size.equalTo(self.phoneTextFiled);
    }];
    
    [self.view addSubview:self.missCodeButton];
    [self.missCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginButton.mas_bottom);
        make.left.equalTo(self.phoneTextFiled).offset(15);
        make.height.equalTo(@(50));
    }];
    [self.view addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.missCodeButton);
        make.right.equalTo(self.phoneTextFiled).offset(-15);
        make.height.equalTo(@(50));
    }];
}

#pragma mark -
#pragma mark ---------私有方法
- (void)loginButtonClick:(UIButton *)button
{
    NNHApiLoginTool *loginTool = [[NNHApiLoginTool alloc] initLoginWithUserName:self.phoneTextFiled.text password:self.passwordTextFiled.text];
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:@"登录中"];
    [loginTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        [SVProgressHUD dismissWithDelay:0.5 completion:^{
            [strongself loginSuccessfullyProcessData:responseDic];
        }];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)loginSuccessfullyProcessData:(NSDictionary *)responseDic
{
    // 保存登录数据
    NNHUserModel *userModel = [NNHUserModel mj_objectWithKeyValues:responseDic[@"data"]];
    [[NNHProjectControlCenter sharedControlCenter] userControl_saveUserDataWithUserInfo:userModel];
    
    // 连接融云
    [[NNHMessageManager shareManager] connectWithUserTokenSuccess:nil];
    
    // 通知清空消息列表
    [[NSNotificationCenter defaultCenter] postNotificationName:NNH_NotificationMessage_messageChangeCurrentLoginUser object:nil];
    
    if (self.successLoginblock) {
        self.successLoginblock();
    }
    
    [self dismissVC];
}

- (void)missCodeButtonClick
{
    NNHVerifyMobileController *vc = [[NNHVerifyMobileController alloc] initWithType:NNHSendVerificationCodeType_userForgetpwd];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)registerButtonClick
{
    NNHRegisterViewController *vc = [[NNHRegisterViewController alloc] init];
    [self.navigationController pushViewController:vc animated:NO];
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNHLoginTextField *)textField
{
    self.loginButton.enabled = self.phoneTextFiled.text.length >= NNHMinPhoneLength && self.passwordTextFiled.text.length >= 6;
}

#pragma mark -----------PrivateMethods
+ (instancetype)presentInViewController:(UIViewController *)VC withAniamtion:(BOOL)Aniamtion andCompletion:(completionBlock)block;
{
    if (isClick) {
        isClick = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            isClick = YES;
        });
        NNHLoginViewController *log = [[NNHLoginViewController alloc]init];
        NNHNavigationController *nav = [[NNHNavigationController alloc] initWithRootViewController:log];
        log.successLoginblock = block;
        [VC presentViewController:nav animated:YES completion:nil];
        return log;
    }
    return nil;
}

- (void)dismissVC
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark ---------getter && setter
- (NNHLoginTextField *)phoneTextFiled
{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [[NNHLoginTextField alloc] init];
        _phoneTextFiled.placeholder = @"请填写您的手机号";
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        _phoneTextFiled.nn_maxLength = NNHMaxPhoneLength;
    }
    return _phoneTextFiled;
}

- (NNHLoginTextField *)passwordTextFiled
{
    if (_passwordTextFiled == nil) {
        _passwordTextFiled = [[NNHLoginTextField alloc] init];
        _passwordTextFiled.placeholder = @"请填写您的密码";
        _passwordTextFiled.showSecureButotn = YES;
        _passwordTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextFiled.nn_maxLength = 16;
    }
    return _passwordTextFiled;
}

- (UIButton *)loginButton
{
    if (_loginButton == nil) {
        _loginButton = [UIButton NNHOperationBtnWithTitle:@"立即登录" target:self action:@selector(loginButtonClick:) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
    }
    return _loginButton;
}

- (UIButton *)backButton
{
    if (_backButton == nil) {
        _backButton = [UIButton NNHBtnImage:@"ic_nav_close" target:self action:@selector(dismissVC)];
        _backButton.adjustsImageWhenHighlighted = NO;
    }
    return _backButton;
}

- (UIButton *)missCodeButton
{
    if (_missCodeButton == nil) {
        _missCodeButton = [UIButton NNHBtnTitle:@"忘记密码?" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeRed]];
        [_missCodeButton addTarget:self action:@selector(missCodeButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _missCodeButton.adjustsImageWhenHighlighted = NO;
    }
    return _missCodeButton;
}

- (UIButton *)registerButton
{
    if (_registerButton == nil) {
        _registerButton = [UIButton NNHBtnTitle:@"注册" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorThemeRed]];
        [_registerButton addTarget:self action:@selector(registerButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _registerButton.adjustsImageWhenHighlighted = NO;
    }
    return _registerButton;
}
@end

