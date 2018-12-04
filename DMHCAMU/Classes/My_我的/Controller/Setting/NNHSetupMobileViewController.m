//
//  NNHSetupMobileViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2018/8/10.
//  Copyright © 2018年 牛牛汇. All rights reserved.
//

#import "NNHSetupMobileViewController.h"
#import "NNHCountDownButton.h"
#import "NNHTextField.h"
#import "NNHApiUserTool.h"

@interface NNHSetupMobileViewController ()

/** 电话号码 */
@property (nonatomic, strong) NNHTextField *phoneTextFiled;
/** 验证码 */
@property (nonatomic, strong) NNHTextField *codeTextFiled;
/** 获取验证码按钮 */
@property (nonatomic, strong) NNHCountDownButton *codeButton;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *ensureButton;
/** 添加验证码的view */
@property (nonatomic, strong) UIView *middleView;

@end

@implementation NNHSetupMobileViewController

#pragma mark -
#pragma mark ---------Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"修改手机";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    
}

/** 添加子控件 */
- (void)setupChildView
{
    [self.view addSubview:self.phoneTextFiled];
    [self.view addSubview:self.middleView];
    [self.view addSubview:self.ensureButton];
    [self.middleView addSubview:self.codeTextFiled];
    [self.middleView addSubview:self.codeButton];
    
    
    [self.phoneTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHMargin_10 + (NNHNavBarViewHeight));
        make.height.equalTo(@(NNHNormalViewH));
        make.left.right.equalTo(self.view);
    }];
    
    [self.middleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneTextFiled.mas_bottom).offset(NNHMargin_10);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.middleView.mas_centerY);
        make.right.equalTo(self.middleView.mas_right).offset(-NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(104, 34));
    }];
    [self.codeTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.middleView);
        make.right.equalTo(self.codeButton.mas_left);
    }];
    
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.middleView.mas_bottom).offset(NNHTopToolbarH);
        make.height.equalTo(@(NNHNormalViewH));
        make.width.equalTo(@(SCREEN_WIDTH - NNHMargin_15 * 2));
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma mark -
#pragma mark ---------私有方法
/** 点击登录 */
- (void)ensureButtonClick:(UIButton *)button
{
    NNHWeakSelf(self)
    NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initUpdatePhoneWithMobile:self.phoneTextFiled.text valicode:self.codeTextFiled.text];
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
        userModel.mobile = [weakself.phoneTextFiled.text replaceStringWithAsterisk:3 length:weakself.phoneTextFiled.text.length - 6];
        [weakself.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}


#pragma mark -
#pragma mark ---------UITextFieldDelegate

- (void)textFieldDidChange:(NNHTextField *)textField
{
    //限制字符串长度
    if (textField == self.phoneTextFiled) {
        if (textField.text.length > 11) {
            textField.text = [textField.text substringToIndex:11];
        }
    }
    if (textField == self.codeTextFiled) {
        if (textField.text.length > 6) {
            textField.text = [textField.text substringToIndex:6];
        }
    }
    
    if (![self.phoneTextFiled.text checkIsPhoneNumber] && self.phoneTextFiled.text.length == 11 && [self.phoneTextFiled isFirstResponder]) {
        [SVProgressHUD showMessage:@"您输入的手机号码不正确"];
        return;
    }
    
    // 验证码状态
    self.codeButton.enabled = self.phoneTextFiled.text.length == 11 && self.codeButton.curSec == 60;
    
    self.ensureButton.enabled = self.phoneTextFiled.hasText && self.codeTextFiled.hasText;
}

#pragma mark -
#pragma mark ---------getter && setter
- (NNHTextField *)phoneTextFiled
{
    if (_phoneTextFiled == nil) {
        _phoneTextFiled = [[NNHTextField alloc] init];
        _phoneTextFiled.font = [UIConfigManager fontThemeTextMain];
        _phoneTextFiled.backgroundColor = [UIColor whiteColor];
        _phoneTextFiled.placeholder = @"请输入您的手机号";
        _phoneTextFiled.layer.borderWidth = NNHLineH;
        _phoneTextFiled.layer.borderColor = [UIConfigManager colorThemeSeperatorLightGray].CGColor;
        [_phoneTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextFiled;
}

/** 验证码输入框 */
- (NNHTextField *)codeTextFiled
{
    if (_codeTextFiled == nil) {
        _codeTextFiled = [[NNHTextField alloc] init];
        _codeTextFiled.font = [UIConfigManager fontThemeTextMain];
        _codeTextFiled.placeholder = @"请输入验证码";
        //        _codeTextFiled.delegate = self;
        _codeTextFiled.keyboardType = UIKeyboardTypeNumberPad;
        [_codeTextFiled addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _codeTextFiled;
}

/** 确定按钮 */
- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"确定" target:self action:@selector(ensureButtonClick:) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
        _ensureButton.enabled = NO;
    }
    return _ensureButton;
}

/** 获取验证码按钮 */
- (NNHCountDownButton *)codeButton
{
    if (_codeButton == nil) {
        NNHWeakSelf(self)
        _codeButton = [[NNHCountDownButton alloc] initWithTotalTime:60 titleBefre:@"获取验证码" titleConting:@"s" titleAfterCounting:@"重新获取" clickAction:^(NNHCountDownButton *countBtn) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initWithMobile:weakself.phoneTextFiled.text verifyCodeType:NNHSendVerificationCodeType_updatePhone];
                [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [countBtn startCounting];
                    [SVProgressHUD showMessage:@"获取验证码成功 请注意查收"];
                } failBlock:^(NNHRequestError *error) {
                    [countBtn resetButton];
                } isCached:NO];
                
            });
        }];
        _codeButton.enabled = NO;
        _codeButton.layer.cornerRadius = NNHMargin_5;
        _codeButton.clipsToBounds = YES;
    }
    return _codeButton;
}

- (UIView *)middleView
{
    if (_middleView == nil) {
        _middleView = [[UIView alloc] init];
        _middleView.backgroundColor = [UIColor whiteColor];
        _middleView.layer.borderWidth = NNHLineH;
        _middleView.layer.borderColor = [UIConfigManager colorThemeSeperatorLightGray].CGColor;
    }
    return _middleView;
}
@end
