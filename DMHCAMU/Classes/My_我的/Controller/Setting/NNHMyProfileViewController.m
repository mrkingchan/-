//
//  NNHMyProfileViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyProfileViewController.h"
#import "NNHImagePickerController.h"
#import "NNHRealNameViewController.h"
#import "NNHNickNameViewController.h"
//#import "NNHManageAddressController.h"
//#import "NNHMyBankCardController.h"
#import "NNHMyGroup.h"
#import "NNHMyItem.h"
#import "NNHAlertTool.h"
#import "NNHApiUserTool.h"
#import "NNHUploadHelper.h"
#import "NNHUserModel.h"
#import "NNHAreaPickerView.h"
#import "NNHDatePickerView.h"

@interface NNHMyProfileViewController ()

/** 头部view */
@property (nonatomic, strong) UIView *headerView;
/** 头像 */
@property (nonatomic, strong) UIImageView *headImageView;
/** 区域选择 */
@property (nonatomic, strong) NNHAreaPickerView *pickerView;
/** 用户资料 */
@property (nonatomic, strong) NNHUserModel *userModel;
/** 我的平台号 */
@property (nonatomic, strong) NNHMyItem *infoItem;
/** 昵称 */
@property (nonatomic, strong) NNHMyItem *nameItem;
/** 性别 */
@property (nonatomic, strong) NNHMyItem *sexItem;
/** 生日 */
@property (nonatomic, strong) NNHMyItem *birthdayItem;
/** 地区 */
@property (nonatomic, strong) NNHMyItem *areaItem;
/** 实名认证 */
@property (nonatomic, strong) NNHMyItem *realNameItem;
/** 收货地址 */
@property (nonatomic, strong) NNHMyItem *addressItem;
/** 我的银行卡 */
@property (nonatomic, strong) NNHMyItem *bankItem;

@end

@implementation NNHMyProfileViewController

#pragma mark -
#pragma mark ---------Life Cycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
    [self setupChildViewDataSource:self.userModel];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"我的资料";
    self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.tableView.tableHeaderView = self.headerView;
    
    [self setupGroups];
}

- (void)setupChildViewDataSource:(NNHUserModel *)userModel
{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userModel.headerpic] placeholderImage:[UIImage imageNamed:@"ic_user_default"]];
    self.infoItem.rightTitle = userModel.customer_code;
    
    if ([NSString isEmptyString:userModel.nickname]) {
        self.nameItem.rightTitle = @"未设置";
        self.nameItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }else{
        self.nameItem.rightTitle = userModel.nickname;
    }
    
    if ([userModel.sex isEqualToString:@"0"]) {
        self.sexItem.rightTitle = @"未设置";
        self.sexItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }else{
        self.sexItem.rightTitle = userModel.uesrSex;
    }
    
    self.birthdayItem.rightTitle = userModel.borndate;
    
    if ([userModel.area_code integerValue] == 0) {
        self.areaItem.rightTitle = @"请选择";
    }else{
        self.areaItem.rightTitle = userModel.area;
    }
    
    if ([userModel.isnameauth integerValue] == 1) {
        self.realNameItem.rightTitle = @"已认证";
        self.realNameItem.rightTitleColor = [UIColor akext_colorWithHex:@"#00a762"];
    }else if ([userModel.isnameauth integerValue] == 2){
        self.realNameItem.rightTitle = @"审核中";
        self.realNameItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }else{
        self.realNameItem.rightTitle = @"未认证";
        self.realNameItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }
    
    if ([userModel.logisticsDec boolValue]) {
        self.addressItem.rightTitle = @"已设置";
        self.addressItem.rightTitleColor = [UIColor akext_colorWithHex:@"#00a762"];
    }else{
        self.addressItem.rightTitle = @"未设置";
        self.addressItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }
    
    if ([userModel.banknumber integerValue] > 0) {
        self.bankItem.rightTitle = userModel.banknumber;
    }else{
        self.bankItem.rightTitle = @"未添加";
        self.bankItem.rightTitleColor = [UIConfigManager colorThemeRed];
    }
    
    [self.tableView reloadData];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    group.items = @[self.nameItem, self.sexItem,self.birthdayItem,self.areaItem];
}

- (void)setupGroup1
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    // 2.设置组的所有行数据
    group.items = @[self.realNameItem, self.bankItem, self.addressItem];
}

#pragma mark -
#pragma mark ---------UserAction
- (void)replaceHead
{
    NNHImagePickerController *imagePVC = [[NNHImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    NNHWeakSelf(self)
    [imagePVC setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        NNHStrongSelf(self)
        [NNHUploadHelper upLoadWithImage:[photos lastObject] andImageType:NNHPostImageTypeImageUser andSuccessBlock:^(NSString *upUrl, NSString *wholeUrl) {
            NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initChangeUserDataSourceWithNickName:nil sex:nil headerpic:upUrl borndate:nil area:nil areaCode:nil];
            [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                [SVProgressHUD showMessage:@"修改成功"];
                NNHUserModel *userModel = [NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel;
                userModel.headerpic = wholeUrl;
                strongself.headImageView.image = photos[0];
            } failBlock:^(NNHRequestError *error) {
                
            } isCached:NO];
        } failedBlock:^(NNHRequestError *error) {
            
        }];
    }];
    [self.navigationController presentViewController:imagePVC animated:YES completion:nil];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHMyItem *)infoItem
{
    if (_infoItem == nil) {
        _infoItem = [NNHMyItem itemWithTitle:@"我的平台号" itemAccessoryViewType:NNHItemAccessoryViewTypeRightLabel];
    }
    return _infoItem;
}

- (NNHMyItem *)nameItem
{
    if (_nameItem == nil) {
        _nameItem = [NNHMyItem itemWithTitle:@"昵称" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        _nameItem.destVcClass = [NNHNickNameViewController class];
    }
    return _nameItem;
}

- (NNHMyItem *)sexItem
{
    if (_sexItem == nil) {
        _sexItem = [NNHMyItem itemWithTitle:@"性别" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NSArray *sexs = @[@"男",@"女"];
        NNHWeakSelf(self)
        NNHWeakSelf(_sexItem)
        _sexItem.operation = ^{
            NNHStrongSelf(self)
            NNHStrongSelf(_sexItem)
            dispatch_async(dispatch_get_main_queue(),^{
                [[NNHAlertTool shareAlertTool] showActionSheet:strongself title:nil message:nil acttionTitleArray:sexs confirm:^(NSInteger index) {
                    NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initChangeUserDataSourceWithNickName:nil sex:[NSString stringWithFormat:@"%zd",index + 1] headerpic:nil borndate:nil area:nil areaCode:nil];
                    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                        [SVProgressHUD showMessage:@"修改成功"];
                        strongself.userModel.sex = [NSString stringWithFormat:@"%zd",index + 1];
                        strong_sexItem.rightTitle = sexs[index];
                        strong_sexItem.rightTitleColor = [UIConfigManager colorTextLightGray];
                        [strongself.tableView reloadData];
                    } failBlock:^(NNHRequestError *error) {
                        
                    } isCached:NO];
                } cancle:^{
                    
                }];
            });
        };
    }
    return _sexItem;
}

- (NNHMyItem *)birthdayItem
{
    if (_birthdayItem == nil) {
        _birthdayItem = [NNHMyItem itemWithTitle:@"生日" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NNHWeakSelf(self)
        NNHWeakSelf(_birthdayItem)
        _birthdayItem.operation = ^{
            NNHStrongSelf(self)
            NNHStrongSelf(_birthdayItem)
            NNHDatePickerView *datePickerView = [[NNHDatePickerView alloc] initWithDatePickerType:NNHDatePickerTypeDate minYear:1900];
            datePickerView.dateBlock = ^(NSString *timeStr) {
                NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initChangeUserDataSourceWithNickName:nil sex:nil headerpic:nil borndate:timeStr area:nil areaCode:nil];
                [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                    [SVProgressHUD showMessage:@"修改成功"];
                    strongself.userModel.borndate = timeStr;
                    strong_birthdayItem.rightTitle = timeStr;
                    [strongself.tableView reloadData];
                } failBlock:^(NNHRequestError *error) {
                    
                } isCached:NO];
            };
            [datePickerView showDatePicker];
        };
    }
    return _birthdayItem;
}

- (NNHMyItem *)areaItem
{
    if (_areaItem == nil) {
        _areaItem = [NNHMyItem itemWithTitle:@"地区" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NNHWeakSelf(self)
        _areaItem.operation = ^{
            [weakself.tableView endEditing:YES];
            [weakself.pickerView showWithAnimation:YES fatherView:weakself.navigationController.view];
        };
    }
    return _areaItem;
}

- (NNHMyItem *)realNameItem
{
    if (_realNameItem == nil) {
        _realNameItem = [NNHMyItem itemWithTitle:@"实名认证" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
        NNHWeakSelf(self)
        _realNameItem.operation = ^{
            if ([[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.isnameauth integerValue] !=2 ) {
                NNHRealNameViewController *vc = [[NNHRealNameViewController alloc] init];
                [weakself.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return _realNameItem;
}

- (NNHMyItem *)addressItem
{
    if (_addressItem == nil) {
        _addressItem = [NNHMyItem itemWithTitle:@"收货地址" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
//        _addressItem.destVcClass = [NNHManageAddressController class];
    }
    return _addressItem;
}

- (NNHMyItem *)bankItem
{
    if (_bankItem == nil) {
        _bankItem = [NNHMyItem itemWithTitle:@"我的银行卡" itemAccessoryViewType:NNHItemAccessoryViewTypeRightView];
//        _bankItem.destVcClass = [NNHMyBankCardController class];
    }
    return _bankItem;
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        _headerView.backgroundColor = [UIConfigManager colorThemeWhite];
        
        UILabel *headlabel = [UILabel NNHWithTitle:@"头像" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
        [_headerView addSubview:headlabel];
        [headlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_headerView).offset(NNHMargin_15);
            make.centerY.equalTo(_headerView);
        }];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:ImageName(@"common_icon_arrow")];
        [_headerView addSubview:arrowView];
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_headerView).offset(-NNHMargin_15);
            make.centerY.equalTo(_headerView);
        }];
        
        [_headerView addSubview:self.headImageView];
        [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(arrowView.mas_left).offset(-NNHMargin_15);
            make.centerY.equalTo(_headerView);
            make.size.mas_equalTo(CGSizeMake(54, 54));
        }];
    }
    return _headerView;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil) {
        _headImageView = [[UIImageView alloc] init];
        _headerView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.userInteractionEnabled = YES;
        [_headImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(replaceHead)]];
        NNHViewBorderRadius(_headImageView, 54/2, 1, [UIConfigManager colorThemeSeperatorLightGray]);
    }
    return _headImageView;
}

- (NNHAreaPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[NNHAreaPickerView alloc] init];
        NNHWeakSelf(self);
        _pickerView.didSelectedAreaBlock = ^(NSString *codeStr, NSString *provinceName, NSString *cityName, NSString *areaName){
            NNHStrongSelf(self)
            NSString *areaStr = [NSString stringWithFormat:@"%@-%@-%@",provinceName,cityName,areaName];
            NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initChangeUserDataSourceWithNickName:nil sex:nil headerpic:nil borndate:nil area:areaStr areaCode:codeStr];
            [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
                [SVProgressHUD showMessage:@"修改成功"];
                strongself.areaItem.rightTitle = areaStr;
                strongself.userModel.area = areaStr;
                strongself.userModel.area_code = codeStr;
                [strongself.tableView reloadData];
            } failBlock:^(NNHRequestError *error) {
                
            } isCached:NO];
        };
    }
    return _pickerView;
}

@end
