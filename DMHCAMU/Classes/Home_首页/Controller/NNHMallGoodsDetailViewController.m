//
//  NNHMallGoodsDetailViewController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsDetailViewController.h"
#import "NNHMallGoodsDetailNavView.h"
#import "NNHMallGoodsDetailOperationView.h"
#import "NNHMallGoodsDetailHeaderView.h"
#import "NNHMallGoodsDetailServiceView.h"
#import "NNHMallGoodsDetailContentView.h"
#import "NNHHomeMallGoodsReserveViewController.h"
#import "NNHAPIHomeTool.h"
#import "NNHAPIGoodsTool.h"
#import "NNHAlertTool.h"
#import "NNHApplicationHelper.h"
#import "NNHMallGoodsDetailModel.h"

@interface NNHMallGoodsDetailViewController ()

/** 最底部scrollView */
@property (nonatomic, strong) UIScrollView *scrollView;
/** 导航栏 */
@property (nonatomic, strong) NNHMallGoodsDetailNavView *navBarView;
/** 底部操作view */
@property (nonatomic, strong) NNHMallGoodsDetailOperationView *bottomOperationView;
/** 服务内容 */
@property (nonatomic, strong) NNHMallGoodsDetailServiceView *serviceView;
/** 图文详情 */
@property (nonatomic, strong) NNHMallGoodsDetailContentView *contentView;
/** 服务内容 */
@property (nonatomic, strong) NNHMallGoodsDetailHeaderView *headerView;
/** 数据模型 */
@property (nonatomic, strong) NNHMallGoodsDetailModel *goodsModel;
@end

@implementation NNHMallGoodsDetailViewController


#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NNHLog(@"---------%s-------",__func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    
    // 获取数据
    [self requestGoodDetailDataSource];
    
}

- (void)setupChildView
{
    // 适配
    nn_adjustsScrollViewInsets_NO(self.scrollView, self);

    [self.view addSubview:self.bottomOperationView];
    [self.bottomOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-(NNHBottomSafeHeight));
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(@(NNHOrderDetailOperationViewH));
    }];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsZero);
        make.bottom.equalTo(self.bottomOperationView.mas_top);
    }];
    
    [self.view addSubview:self.navBarView];
    [self.navBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(NNHNavBarViewHeight));
    }];
    
    [self.scrollView addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.scrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
    }];
    
    [self.scrollView addSubview:self.serviceView];
    [self.serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.top.equalTo(self.headerView.mas_bottom).offset(NNHMargin_10);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.top.equalTo(self.serviceView.mas_bottom).offset(NNHMargin_10);
        make.bottom.equalTo(self.scrollView);
    }];
}

- (void)requestGoodDetailDataSource
{
    NNHWeakSelf(self)
    NNHAPIGoodsTool *goodsTool = [[NNHAPIGoodsTool alloc] initGoodsDetailDataWithGoodsID:self.goodsID];
    [goodsTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        [weakself laodGoodsData:responseDic];
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)laodGoodsData:(NSDictionary *)responseDic
{
    self.goodsModel = [NNHMallGoodsDetailModel mj_objectWithKeyValues:responseDic[@"data"]];
    self.headerView.goodsModel = self.goodsModel;
    self.contentView.urlString = self.goodsModel.detailInfo;
    self.bottomOperationView.goodsModel = self.goodsModel;
}

/** 拨打咨询电话 */
- (void)callServiceMobile
{
    if (self.goodsModel.phone.length == 0) return;
    
    [[NNHAlertTool shareAlertTool] showAlertView:self title:@"咨询电话" message:self.goodsModel.phone cancelButtonTitle:@"取消" otherButtonTitle:@"拨打" confirm:^{
        [[NNHApplicationHelper sharedInstance] openPhoneNum:self.goodsModel.phone InView:self.view];
    } cancle:^{
        
    }];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
    }
    return _scrollView;
}

- (NNHMallGoodsDetailNavView *)navBarView
{
    if (_navBarView == nil) {
        _navBarView = [[NNHMallGoodsDetailNavView alloc] init];
        NNHWeakSelf(self)
        _navBarView.backBlock = ^{
            [weakself.navigationController popViewControllerAnimated:YES];
        };
    }
    return _navBarView;
}

- (NNHMallGoodsDetailOperationView *)bottomOperationView
{
    if (_bottomOperationView == nil) {
        _bottomOperationView = [[NNHMallGoodsDetailOperationView alloc] init];
        NNHWeakSelf(self)
        _bottomOperationView.operationViewJumpBlock = ^(NNHMallGoodsDetailBottomOperationType type) {
            if (type == NNHMallGoodsDetailBottomOperationType_addCart) {
                NNHHomeMallGoodsReserveViewController *reserveVC = [[NNHHomeMallGoodsReserveViewController alloc] init];
                reserveVC.goodsModel = weakself.goodsModel;
                [weakself.navigationController pushViewController:reserveVC animated:YES];
            }else if (type == NNHMallGoodsDetailBottomOperationType_message) {
                [weakself callServiceMobile];
            }
        };
    }
    return _bottomOperationView;
}

- (NNHMallGoodsDetailHeaderView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[NNHMallGoodsDetailHeaderView alloc] init];
    }
    return _headerView;
}

- (NNHMallGoodsDetailServiceView *)serviceView
{
    if (_serviceView == nil) {
        _serviceView = [[NNHMallGoodsDetailServiceView alloc] init];
    }
    return _serviceView;
}

- (NNHMallGoodsDetailContentView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[NNHMallGoodsDetailContentView alloc] init];
    }
    return _contentView;
}


@end
