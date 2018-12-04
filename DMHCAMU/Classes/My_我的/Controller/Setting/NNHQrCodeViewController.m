//
//  NNHQrCodeViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHQrCodeViewController.h"
#import "NNHShareHelper.h"
#import "NNHApiUserTool.h"
#import "UIImageView+WebCache.h"
#import "NNHShareModel.h"
#import "NNHWebViewController.h"
#import "NNHShareHelper.h"

@interface NNHQrCodeViewController ()

/** 平台号 */
@property (nonatomic, strong) UILabel *nnhNumberLabel;
/** 二维码 */
@property (nonatomic, strong) UIImageView *qrCodeView;

@end

@implementation NNHQrCodeViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"邀请好友";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    // 初始化子控件
    [self setupChildView];
    
    [self requestDataSource];
}

- (void)requestDataSource
{
    NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initMyQrCode];
    NNHWeakSelf(self)
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself.qrCodeView sd_setImageWithURL:[NSURL URLWithString:responseDic[@"data"][@"url"]]];
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

- (void)setupChildView
{
    // 内容背景
    UIView *contentView = [[UIImageView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    NNHViewRadius(contentView, 5.0)
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40 + (NNHNavBarViewHeight));
        make.left.equalTo(self.view).offset(35);
        make.right.equalTo(self.view).offset(-35);
    }];
    
    // 头像
    CGFloat iconViewWH = 70;
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView sd_setImageWithURL:[NSURL URLWithString:[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.headerpic] placeholderImage:ImageName(@"ic_user_default")];
    iconView.contentMode = UIViewContentModeScaleAspectFill;
    NNHViewBorderRadius(iconView, 70*0.5, 2.0, [UIColor whiteColor]);
    [contentView addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(30);
        make.left.equalTo(contentView).offset(30);
        make.size.mas_equalTo(CGSizeMake(iconViewWH, iconViewWH));
    }];
    
    // 昵称
    UILabel *nickLabel = [UILabel NNHWithTitle:[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.nickname titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextImportant]];
    [contentView addSubview:nickLabel];
    [nickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconView.mas_right).offset(15);
        make.bottom.equalTo(iconView.mas_centerY).offset(-8);
    }];
    
    // 手机
    UILabel *phoneLabel = [UILabel NNHWithTitle:[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.mobile titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextImportant]];
    [contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nickLabel);
        make.top.equalTo(iconView.mas_centerY).offset(8);
    }];
    
    // 二维码
    [contentView addSubview:self.qrCodeView];
    [self.qrCodeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconView.mas_bottom).offset(40);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];

    // 保存
    UIButton *saveButton = [UIButton NNHOperationBtnWithTitle:@"保存图片" target:self action:@selector(savePhontAction) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
    [contentView addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qrCodeView.mas_bottom).offset(30);
        make.left.equalTo(contentView).offset(60);
        make.right.equalTo(contentView).offset(-60);
        make.height.equalTo(@44);
        make.bottom.equalTo(contentView).offset(-50);
    }];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)savePhontAction
{
    UIImage *image = self.qrCodeView.image;
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error) {
        [SVProgressHUD showMessage:@"保存成功"];
    }
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UIImageView *)qrCodeView
{
    if (_qrCodeView == nil) {
        _qrCodeView = [[UIImageView alloc] init];
    }
    return _qrCodeView;
}

@end
