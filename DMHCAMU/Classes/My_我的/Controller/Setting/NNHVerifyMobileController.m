//
//  NNHVerifyMobileController.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHVerifyMobileController.h"
#import "NNHTextField.h"
#import "NNHCountDownButton.h"
#import "NNSetupLoginPasswordViewController.h"
#import "NNSetupPayPasswordViewController.h"
#import "NNHSetupMobileViewController.h"
#import "NNHApiUserTool.h"

@interface NNHVerifyMobileController ()

/** 手机号码 */
@property (nonatomic, strong) UILabel *phoneNumLabel;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 手机号码 */
@property (nonatomic, strong) NNHTextField *phoneField;
/** 用户名 */
@property (nonatomic, strong) NNHTextField *nameField;
/** 验证码 */
@property (nonatomic, strong) NNHTextField *codeField;
/** 获取验证码 */
@property (nonatomic, strong) NNHCountDownButton *codeButton;
/** 发送验证码类型 */
@property (nonatomic, assign) NNHSendVerificationCodeType verificationType;

@end

@implementation NNHVerifyMobileController
{
    NSString *_currentPhoneNumber;
}

#pragma mark - Life Cycle Methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (instancetype)initWithType:(NNHSendVerificationCodeType)type
{
    if (self = [super init]) {
        _verificationType = type;
        _currentPhoneNumber = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.completemobile;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"验证手机";
    
    [self setupChildView];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30 + (NNHNavBarViewHeight));
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@44);
    }];
    
    if (self.verificationType == NNHSendVerificationCodeType_userForgetpwd) {
        [self.view addSubview:self.nameField];
        [self.nameField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.phoneField.mas_bottom).offset(15);
            make.left.right.equalTo(self.phoneField);
            make.height.equalTo(self.phoneField);
        }];
    }
    
    UIView *codeView = [[UIView alloc] init];
    codeView.backgroundColor = [UIConfigManager colorThemeWhite];
    NNHViewBorderRadius(codeView, NNHMargin_5, NNHLineH, [UIConfigManager colorThemeSeperatorLightGray]);
    [self.view addSubview:codeView];
    [codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.phoneField);
        make.top.equalTo(self.verificationType == NNHSendVerificationCodeType_userForgetpwd ? self.nameField.mas_bottom : self.phoneField.mas_bottom).offset(15);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    [codeView addSubview:self.codeField];
    [self.codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(codeView);
        make.top.bottom.equalTo(codeView);
        make.width.equalTo(@(SCREEN_WIDTH - 120));
    }];
    
    [codeView addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(codeView).offset(-NNHMargin_10);
        make.centerY.equalTo(codeView);
        make.height.equalTo(@(30));
        make.width.equalTo(@80);
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.top.equalTo(codeView.mas_bottom).offset(60);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    if (self.verificationType == NNHSendVerificationCodeType_userForgetpwd) {
        self.codeButton.enabled = self.phoneField.text.length  > 10 && self.nameField.text.length >= 6;
        self.ensureButton.enabled = self.phoneField.text.length  > 10 && self.codeField.hasText && self.nameField.text.length >= 6;
    }else{
        self.ensureButton.enabled = self.codeField.hasText;
    }
}

#pragma mark - Target Methods
- (void)clickEnsureButton:(UIButton *)button
{
    NNHWeakSelf(self)
    NNHApiUserTool *apiTool = [[NNHApiUserTool alloc] initResetPasswordValidationWithMobile:self.phoneField.text code:self.codeField.text username:@"" codeType:self.verificationType];
    [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (weakself.verificationType == NNHSendVerificationCodeType_changeLoginPassword || weakself.verificationType == NNHSendVerificationCodeType_userForgetpwd) {
            NNSetupLoginPasswordViewController *setVc = [[NNSetupLoginPasswordViewController alloc] init];
            setVc.encrypt = responseDic[@"data"][@"encrypt"];
            setVc.mobile = responseDic[@"data"][@"mobile"];
            [weakself.navigationController pushViewController:setVc animated:YES];
        }else if (weakself.verificationType == NNHSendVerificationCodeType_updatePhone) {
            NNHSetupMobileViewController *vc = [[NNHSetupMobileViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        }else {
            NNSetupPayPasswordViewController *setVc = [[NNSetupPayPasswordViewController alloc] initWithFromType:NNHChangePayCodeFromType_Other];
            [weakself.navigationController pushViewController:setVc animated:YES];
        }
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark - Lazy Loads
- (UILabel *)phoneNumLabel
{
    if (_phoneNumLabel == nil) {
        _phoneNumLabel = [UILabel NNHWithTitle:_currentPhoneNumber titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _phoneNumLabel;
}

- (NNHTextField *)phoneField
{
    if (_phoneField == nil) {
        _phoneField = [[NNHTextField alloc] init];
        if (_verificationType == NNHSendVerificationCodeType_userForgetpwd) {
            _phoneField.placeholder = @"请输入您的手机号码";
            _phoneField.enabled = YES;
        }else{
            _phoneField.text = _currentPhoneNumber;
            _phoneField.enabled = NO;
        }
        _phoneField.keyboardType = UIKeyboardTypeNumberPad;
        [_phoneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneField.nn_maxLength = 11;
        NNHViewBorderRadius(_phoneField, NNHMargin_5, NNHLineH, [UIConfigManager colorThemeSeperatorLightGray]);
    }
    return _phoneField;
}

- (NNHTextField *)nameField
{
    if (_nameField == nil) {
        _nameField = [[NNHTextField alloc] init];
        _nameField.placeholder = @"请输入6-25位用户名";
        _nameField.keyboardType = UIKeyboardTypeASCIICapable;
        [_nameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _nameField.nn_maxLength = 25;
        NNHViewBorderRadius(_nameField, NNHMargin_5, NNHLineH, [UIConfigManager colorThemeSeperatorLightGray]);
    }
    return _nameField;
}

- (NNHTextField *)codeField
{
    if (_codeField == nil) {
        _codeField = [[NNHTextField alloc] init];
        _codeField.placeholder = @"请输入验证码";
        _codeField.keyboardType = UIKeyboardTypeNumberPad;
        [_codeField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _codeField.nn_maxLength = 6;
    }
    return _codeField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"下一步" target:self action:@selector(clickEnsureButton:) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
        _ensureButton.enabled = NO;
        _ensureButton.nn_acceptEventInterval = NNHAcceptEventInterval;
    }
    return _ensureButton;
}

/** 获取验证码按钮 */
- (NNHCountDownButton *)codeButton
{
    if (_codeButton == nil) {
        NNHWeakSelf(self)
        _codeButton = [[NNHCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"获取验证码" clickAction:^(NNHCountDownButton *countBtn) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *mobile = ![NSString isEmptyString:_currentPhoneNumber] ? _currentPhoneNumber : weakself.phoneField.text;
                NNHApiUserTool *apiTool;
                if (weakself.verificationType == NNHSendVerificationCodeType_userForgetpwd) {
                    apiTool = [[NNHApiUserTool alloc] initWithMobile:mobile username:weakself.nameField.text];
                }else{
                    apiTool = [[NNHApiUserTool alloc] initWithMobile:mobile verifyCodeType:weakself.verificationType];
                }
                [apiTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
            });
        }];
        _codeButton.layer.cornerRadius = 2.5f;
        _codeButton.layer.masksToBounds = YES;
        _codeButton.enabled = ![NSString isEmptyString:_currentPhoneNumber];
    }
    return _codeButton;
}


@end
