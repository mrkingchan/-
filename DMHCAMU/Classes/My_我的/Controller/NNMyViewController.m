//
//  NNMyViewController.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/17.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNMyViewController.h"
#import "NNHSettingViewController.h"
#import "NNHMyProfileViewController.h"
#import "NNHMyOrderViewController.h"
#import "NNHQrCodeViewController.h"
#import "NNHMyCollectionViewController.h"
#import "NNHMyHeaderView.h"
#import "NNHMyGroup.h"
#import "NNHMyItem.h"
#import "NNHMineModel.h"
#import "NNHApiUserTool.h"
#import "NNHApplicationHelper.h"
#import "NNHWalletViewController.h"

#define KHeaderHeight 150
@interface NNMyViewController ()

/** 头部view */
@property (nonatomic, strong) NNHMyHeaderView *myHeaderView;
/** 会员模型 */
@property (nonatomic, strong) NNHMineModel *mineModel;

@end

@implementation NNMyViewController
#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
    [self requestMyDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置tableview
    [self setupTableview];
    
    // 设置数据
    [self setupGroups];
}

- (void)setupTableview
{
    self.tableView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.tableView.rowHeight = 60;
    self.tableView.contentInset = UIEdgeInsetsMake(KHeaderHeight, 0, 0, 0);
    [self.tableView insertSubview:self.myHeaderView atIndex:0];
}

- (void)setupGroups
{
    [self setupGroup0];
    [self setupGroup1];
    [self setupGroup2];
    
    [self.tableView reloadData];
}

- (void)setupGroup0
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];
    
    NNHMyItem *orderItem = [NNHMyItem itemWithTitle:@"我的投资" icon:nil itemAccessoryViewType:NNHItemAccessoryViewTypeCustomView];
    NNHMyItem *walletItem = [NNHMyItem itemWithTitle:@"我的钱包" icon:nil itemAccessoryViewType:NNHItemAccessoryViewTypeCustomView];
    
    orderItem.customRightView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_invest")];
    walletItem.customRightView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_wallet")];

    orderItem.destVcClass = [NNHMyOrderViewController class];
    walletItem.destVcClass = [NNHWalletViewController class];
    
    // 2.设置组的所有行数据
    group.items = @[orderItem, walletItem];
    
}

- (void)setupGroup1
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];

    NNHMyItem *collectionItem = [NNHMyItem itemWithTitle:@"我的关注" icon:nil itemAccessoryViewType:NNHItemAccessoryViewTypeCustomView];
    NNHMyItem *shareItem = [NNHMyItem itemWithTitle:@"邀请好友" icon:nil itemAccessoryViewType:NNHItemAccessoryViewTypeCustomView];

    collectionItem.customRightView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_concern")];
    shareItem.customRightView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_invite")];
    
    collectionItem.destVcClass = [NNHMyCollectionViewController class];
    shareItem.destVcClass = [NNHQrCodeViewController class];

    // 2.设置组的所有行数据
    group.items = @[collectionItem, shareItem];
}

- (void)setupGroup2
{
    // 1.创建组
    NNHMyGroup *group = [NNHMyGroup group];
    [self.groups addObject:group];

    NNHMyItem *settingItem = [NNHMyItem itemWithTitle:@"设置" icon:nil itemAccessoryViewType:NNHItemAccessoryViewTypeCustomView];
    
    settingItem.destVcClass = [NNHSettingViewController class];

    settingItem.customRightView = [[UIImageView alloc] initWithImage:ImageName(@"ic_center_set")];

    // 2.设置组的所有行数据
    group.items = @[settingItem];
}

- (void)requestMyDataSource
{
    NNHWeakSelf(self)
    NNHApiUserTool *userTool = [[NNHApiUserTool alloc] initMemberDataSource];
    [userTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        
        weakself.mineModel = [NNHMineModel mj_objectWithKeyValues:responseDic[@"data"]];
        
        // 保存用户资料
        [[NNHProjectControlCenter sharedControlCenter] userControl_saveUserDataWithUserInfo:weakself.mineModel.userModel];
        weakself.myHeaderView.mineModel = weakself.mineModel;
        
        [weakself.tableView reloadData];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y < -KHeaderHeight) {
        CGRect rect = self.myHeaderView.frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y;
        self.myHeaderView.frame = rect;
    }
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (NNHMyHeaderView *)myHeaderView
{
    if (_myHeaderView == nil) {
        _myHeaderView = [[NNHMyHeaderView alloc] initWithFrame:CGRectMake(0, -KHeaderHeight, SCREEN_WIDTH, KHeaderHeight)];
        NNHWeakSelf(self)
        _myHeaderView.headerViewJumpBlock = ^(NNHMyHeaderViewJumpType type){
            NNHMyProfileViewController *vc = [[NNHMyProfileViewController alloc] init];
            [weakself.navigationController pushViewController:vc animated:YES];
        };
    }
    return _myHeaderView;
}

@end
