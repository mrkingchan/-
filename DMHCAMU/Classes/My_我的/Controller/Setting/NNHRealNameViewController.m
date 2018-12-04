//
//  NNHRealNameViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHRealNameViewController.h"
#import "NNHImagePickerController.h"
#import "NNHTextField.h"
#import "NNHApiUserTool.h"
#import "NNHUploadHelper.h"
#import "UIButton+NNImagePosition.h"

@interface NNHRealNameViewController () <UITextFieldDelegate>

/** ScrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 用户数据 */
@property (nonatomic, strong) NNHUserModel *userModel;
/** 姓名 */
@property (nonatomic, strong) NNHTextField *nickNameTF;
/** 身份证 */
@property (nonatomic, strong) NNHTextField *cardTF;
/** 照片容器 */
@property (nonatomic, strong) UIView *photoContentView;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *sureButton;
/** 图片数组 */
@property (nonatomic, strong) NSMutableArray *photos;
/** 头部提示信息view */
@property (nonatomic, strong) UIView *titleView;
/** 提示信息label */
@property (nonatomic, strong) UILabel *messageLabel;
@end

@implementation NNHRealNameViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"实名认证";
    
    // 用户数据
    _userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    
    [self setupChildView];
    
    [self requestAuthInfo];
}

- (void)setupChildView
{
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
    [self.scrollView addSubview:self.titleView];
    [self.scrollView addSubview:self.nickNameTF];
    [self.scrollView addSubview:self.cardTF];
    [self.scrollView addSubview:lineView];
    [self.scrollView addSubview:self.sureButton];
    [self.scrollView addSubview:self.photoContentView];
    
    [self.titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.scrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(40));
    }];
    
    [self.nickNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(NNHMargin_15));
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@(NNHNormalViewH));
    }];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nickNameTF.mas_bottom);
        make.left.width.equalTo(self.nickNameTF);
        make.height.equalTo(@(NNHLineH));
    }];
    [self.cardTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.width.equalTo(self.nickNameTF);
        make.height.equalTo(self.nickNameTF);
    }];
    [self.photoContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cardTF.mas_bottom).offset(NNHMargin_15);
        make.left.equalTo(self.scrollView).offset(15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(self.view.mas_width).multipliedBy(0.67);
    }];
    
    NSString *tip = @"照片要求：jpg格式/png格式，大小不超过5M，信息清晰";
    UILabel *tipLabel = [UILabel NNHWithTitle:tip titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextMinTip]];
    [self.scrollView addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoContentView.mas_bottom).offset(NNHMargin_10);
        make.left.equalTo(self.scrollView).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
    
    NSString *content = @"*以下错误将导致审核不通过：\n1.证件过期或上传的证件信息模糊，\n2.填写的证件号，姓名与实际信息不一致，\n3.手持照缺用户名，用户名错误，用户名不清晰或明忽明非手写等。";
    UILabel *contentLabel = [UILabel NNHWithTitle:content titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextMinTip]];
    contentLabel.numberOfLines = 0;
    
    NSMutableParagraphStyle  *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 行间距设置
    [paragraphStyle setLineSpacing:10];
    NSMutableAttributedString *setString = [[NSMutableAttributedString alloc] initWithString:content];
    [setString  addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
    
    // 设置Label要显示的text
    contentLabel.attributedText = setString;
    
    [self.scrollView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(NNHMargin_15);
        make.left.equalTo(self.scrollView).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentLabel.mas_bottom).offset(NNHMargin_20);
        make.left.equalTo(self.scrollView).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(NNHNormalViewH));
        make.bottom.equalTo(self.scrollView).offset(-NNHNormalViewH);
    }];
    
    NNHUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    
    //已认证
    if ([userModel.isnameauth isEqualToString:@"1"]) {
        self.nickNameTF.text = userModel.realname;
        self.cardTF.text = userModel.idnumber;
        self.cardTF.enabled = self.nickNameTF.enabled = NO;
        self.titleView.hidden = self.sureButton.hidden = self.photoContentView.hidden = tipLabel.hidden = contentLabel.hidden = YES;
    }    
}

- (void)requestAuthInfo
{
    NNHWeakSelf(self)
    NNHApiUserTool *tool = [[NNHApiUserTool alloc] initAuthInfo];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself configAuthMessage:responseDic];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)configAuthMessage:(NSDictionary *)responseDic
{
    NSString *remark = responseDic[@"data"][@"remark"];
    if (remark.length) {
        self.messageLabel.text = remark;
        self.titleView.hidden = NO;
        
        [self.nickNameTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleView.mas_bottom).offset(NNHMargin_10);
            make.left.equalTo(self.scrollView);
            make.width.equalTo(@(SCREEN_WIDTH));
            make.height.equalTo(@(NNHNormalViewH));
        }];
    }
}

#pragma mark -
#pragma mark ---------UserAction
- (void)sureRealNameAction
{
    if ([NSString isEmptyString:self.photos[0]]) {
        [SVProgressHUD showMessage:@"请上传身份证正面照"];
        return;
    }
    
    if ([NSString isEmptyString:self.photos[1]]) {
        [SVProgressHUD showMessage:@"请上传身份证反面照"];
        return;
    }
    
    if ([NSString isEmptyString:self.photos[2]]) {
        [SVProgressHUD showMessage:@"请上传手持身份证照"];
        return;
    }
    
    NNHWeakSelf(self)
    [SVProgressHUD nn_showWithStatus:@"提交中"];
    NNHApiUserTool *tool = [[NNHApiUserTool alloc] initWithRealName:self.nickNameTF.text idnumber:self.cardTF.text idcardimg:[self.photos componentsJoinedByString:@","]];
    [tool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [SVProgressHUD nn_dismiss];
        weakself.userModel.realname = weakself.nickNameTF.text;
        weakself.userModel.idnumber = weakself.cardTF.text;
        weakself.userModel.isnameauth = @"2";
        [weakself.navigationController popViewControllerAnimated:YES];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)uploadPhotoAction:(UIButton *)button
{
    NNHImagePickerController *imagePickerVC = [[NNHImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    NNHWeakSelf(self)
    [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        [NNHUploadHelper upLoadWithImage:[photos lastObject] andImageType:NNHPostImageTypeImageDetail andSuccessBlock:^(NSString *upUrl, NSString *wholeUrl) {
            [button setTitle:@"" forState:UIControlStateNormal];
            [button setImage:ImageName(@"") forState:UIControlStateNormal];
            [button setBackgroundImage:[photos lastObject] forState:UIControlStateNormal];
            [weakself.photos replaceObjectAtIndex:button.tag - 1000 withObject:upUrl];
        } failedBlock:^(NNHRequestError *error) {
            
        }];
    }];
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (void)textFieldDidChange:(NNHTextField *)textField
{
    self.sureButton.enabled = self.nickNameTF.hasText && self.cardTF.hasText;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHTextField *)nickNameTF
{
    if (_nickNameTF == nil) {
        _nickNameTF = [[NNHTextField alloc] init];
        [_nickNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _nickNameTF.placeholder = @"真实姓名";
    }
    return _nickNameTF;
}

- (NNHTextField *)cardTF
{
    if (_cardTF == nil) {
        _cardTF = [[NNHTextField alloc] init];
        [_cardTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _cardTF.keyboardType = UIKeyboardTypeASCIICapable;
        _cardTF.nn_maxLength = 18;
        _cardTF.placeholder = @"身份证号";
    }
    return _cardTF;
}

- (UIButton *)sureButton
{
    if (_sureButton == nil) {
        _sureButton = [UIButton NNHOperationBtnWithTitle:@"提交" target:self action:@selector(sureRealNameAction) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
        _sureButton.enabled = NO;
    }
    return _sureButton;
}

- (UIView *)photoContentView
{
    if (_photoContentView == nil) {
        _photoContentView = [[UIView alloc] init];
        _photoContentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        CGFloat btnW = (SCREEN_WIDTH - 40) / 2;
        CGFloat btnH = btnW * 2 / 3;
        UIButton *photoOneButton = [self btnWithTitle:@"上传身份证正面" imageName:@"icon_idcard_ front"];
        photoOneButton.tag = 1000;
        [_photoContentView addSubview:photoOneButton];
        [photoOneButton addTarget:self action:@selector(uploadPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        [photoOneButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(_photoContentView);
            make.width.equalTo(@(btnW));
            make.height.equalTo(@(btnH));
        }];
        
        UIButton *photoTwoButton = [self btnWithTitle:@"上传身份证反面" imageName:@"icon_idcard_ back"];
        photoTwoButton.tag = 1001;
        [_photoContentView addSubview:photoTwoButton];
        [photoTwoButton addTarget:self action:@selector(uploadPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        [photoTwoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.equalTo(_photoContentView);
            make.size.equalTo(photoOneButton);
        }];
        
        UIButton *photoThreeButton = [self btnWithTitle:@"上传手持身份证" imageName:@"icon_idcard_hand"];
        photoThreeButton.tag = 1002;
        [_photoContentView addSubview:photoThreeButton];
        [photoThreeButton addTarget:self action:@selector(uploadPhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        [photoThreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(photoOneButton.mas_bottom).offset(10);
            make.left.equalTo(_photoContentView);
            make.size.equalTo(photoOneButton);
        }];
    }
    return _photoContentView;
}

- (UIButton *)btnWithTitle:(NSString *)title imageName:(NSString *)imageName
{
    
    UIButton *btn = [UIButton NNHBtnImage:imageName target:self action:@selector(uploadPhotoAction:)];
    
    btn.adjustsImageWhenHighlighted = NO;
    
    return btn;
}

- (NSMutableArray *)photos
{
    if (_photos == nil) {
        _photos = [NSMutableArray arrayWithObjects:@"",@"",@"", nil];
    }
    return _photos;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        _messageLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeRed] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _messageLabel;
}

- (UIView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[UIView alloc] init];
        _titleView.backgroundColor = [UIColor akext_colorWithHex:@"#fff3d9"];
        [_titleView addSubview:self.messageLabel];
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_titleView).offset(NNHMargin_15);
            make.width.equalTo(@(SCREEN_WIDTH - 30));
            make.centerY.equalTo(_titleView);
        }];
        _titleView.hidden = YES;
    }
    return _titleView;
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView .showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        _scrollView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    }
    return _scrollView;
}

@end
