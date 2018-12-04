//
//  NNHNickNameViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHNickNameViewController.h"
#import "NNHTextField.h"
#import "NNHApiUserTool.h"

@interface NNHNickNameViewController ()

@property (nonatomic, strong) NNHTextField *nickNameTF;
@property (nonatomic, weak) UIButton *sureButton;

@end

@implementation NNHNickNameViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"修改昵称";
    
    // 文字改变的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nickNameTF];
    
    [self setupChildView];
}

- (void)setupChildView
{
    UILabel *promptLabel = [UILabel NNHWithTitle:@"由中英文、数字以及下划线组成且不超过8个汉字或16个字符" titleColor:[UIConfigManager colorTextLightGray] font:[UIConfigManager fontThemeTextTip]];
    promptLabel.numberOfLines = 2;
    UIButton *sureButton = [UIButton NNHOperationBtnWithTitle:@"确定" target:self action:@selector(sureNickNameAction) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
    sureButton.enabled = NO;
    
    [self.view addSubview:self.nickNameTF];
    [self.view addSubview:promptLabel];
    [self.view addSubview:sureButton];
    self.sureButton = sureButton;
    
    [self.nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NNHMargin_10 + (NNHNavBarViewHeight)));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    [promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.mas_bottom).offset(7);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
    }];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(promptLabel.mas_bottom).offset(NNHMargin_20 *2);
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
    }];
}

- (void)textChange
{
    self.sureButton.enabled = self.nickNameTF.hasText;
}


#pragma mark -
#pragma mark ---------UserAction
- (void)sureNickNameAction
{
    if ([self.nickNameTF.text checkIsValidateNickname] && [self convertToInt:self.nickNameTF.text] <= 16) {
        NNHWeakSelf(self)
        NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initChangeUserDataSourceWithNickName:self.nickNameTF.text sex:nil headerpic:nil borndate:nil area:nil areaCode:nil];
        [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
            NNHUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
            userModel.nickname = weakself.nickNameTF.text;
            [weakself.navigationController popViewControllerAnimated:YES];
        } failBlock:^(NNHRequestError *error) {
            
        } isCached:NO];
    }else{
        [SVProgressHUD showMessage:@"请输入合法的昵称"];
    }
    
}

- (NSInteger)convertToInt:(NSString*)strtemp
{
    NSInteger strlength = 0;
    // 这里一定要使用gbk的编码方式，网上有很多用Unicode的，但是混合的时候都不行
    NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    char* p = (char*)[strtemp cStringUsingEncoding:gbkEncoding];
    for (NSInteger i=0 ; i<[strtemp lengthOfBytesUsingEncoding:gbkEncoding] ;i++) {
        if (p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return strlength;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHTextField *)nickNameTF
{
    if (_nickNameTF == nil) {
        _nickNameTF = [[NNHTextField alloc] init];
        NSString *placeholderName = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.nickname;
        _nickNameTF.placeholder = [NSString isEmptyString:placeholderName] ? @"昵称" : placeholderName;
    }
    return _nickNameTF;
}

@end
