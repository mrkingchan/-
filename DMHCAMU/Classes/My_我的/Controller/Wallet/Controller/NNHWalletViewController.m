//
//  NNHWalletViewController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHWalletViewController.h"
#import "NNHTopToolbar.h"
#import "NNHWalletTransferRecordCell.h"
#import "NNHWalletTitleView.h"


@interface NNHWalletViewController ()<UITableViewDelegate, UITableViewDataSource, NNHTopToolbarDelegate>

/** 顶部操作view */
@property (nonatomic, strong) NNHWalletTitleView *titleView;
/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 顶部工具条 */
@property (nonatomic, strong) NNHTopToolbar *collectionToolbar;
/** 数据模型 */
@property (nonatomic, strong) NSMutableArray <NSMutableArray *>*dataSource;
/** 收藏类型 */
@property (nonatomic, assign) NNHWalletTransferRecordType recordType;

@end

@implementation NNHWalletViewController
{
    NSInteger _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"我的钱包";
    [self setupChildView];
    [self setupRefresh];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self requestCollectionListDataWithRefresh:YES];
}

- (void)setupChildView
{
    [self.view addSubview:self.titleView];
    
    [self.view addSubview:self.collectionToolbar];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionToolbar.mas_bottom).offset(NNHLineH);
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNHRefreshHeader headerWithRefreshingBlock:^{
        [weakself requestCollectionListDataWithRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNHRefreshFooter footerWithRefreshingBlock:^{
        [weakself requestCollectionListDataWithRefresh:NO];
    }];
}

#pragma mark -
#pragma mark ---------requestData
- (void)requestCollectionListDataWithRefresh:(BOOL)isRefresh
{
//    NNHWeakSelf(self)
//    _page = isRefresh ? 1 : _page + 1;
//    NNHAPICollectionTool *collectionTool = [[NNHAPICollectionTool alloc] initWithUserCollectionListWithType:self.collectionType page:_page];
//    //    [SVProgressHUD showWithStatus:nil];
//    [collectionTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//
//        //        [SVProgressHUD dismiss];
//
//        NNHStrongSelf(self)
//        if (isRefresh) {
//            [strongself loadOrderDataSource:responseDic];
//        }else{
//            // 数据转化
//            if (responseDic[@"data"] == nil) return;
//            NSArray *newsArr = [NNHUserCollectionModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
//            [strongself.dataSource[strongself.collectionType] addObjectsFromArray:newsArr];
//            [strongself.tableView reloadData];
//
//            if ([responseDic[@"data"][@"total"]integerValue] == [self.dataSource[self.collectionType] count]) {
//                [strongself.tableView.mj_footer endRefreshingWithNoMoreData];
//                return;
//            }
//            // 结束刷新
//            [strongself.tableView.mj_footer endRefreshing];
//        }
//    } failBlock:^(NNHRequestError *error) {
//        [weakself.tableView.mj_header endRefreshing];
//        [weakself.tableView.mj_footer endRefreshing];
//    } isCached:NO];
}

- (void)loadOrderDataSource:(NSDictionary *)responseDic
{
//    self.dataSource[self.collectionType] = [NNHUserCollectionModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
//    [self.tableView reloadData];
//    [self.tableView.mj_header endRefreshing];
//
//    if ([responseDic[@"data"][@"total"]integerValue] == [self.dataSource[self.collectionType] count]) {
//        [self.tableView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
//    // 重置刷新状态
//    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------UserAction

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    NSMutableArray *array = self.dataSource[self.recordType];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHWalletTransferRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHWalletTransferRecordCell class])];
//    NNHUserCollectionModel *collectionModel = self.dataSource[self.collectionType][indexPath.row];
//    cell.collectionModel = collectionModel;
//    NNHWeakSelf(self)
//

    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NNHUserCollectionModel *collectionModel = self.dataSource[self.collectionType][indexPath.row];
//    if (self.collectionType == NNHMyCollectionType_Goods) {
//        NNHGoodsDetailViewController *goodsVc = [[NNHGoodsDetailViewController alloc] init];
//        goodsVc.goodsID = collectionModel.collectionID;
//        [self.navigationController pushViewController:goodsVc animated:YES];
//    }else if (self.collectionType == NNHMyCollectionType_Shop) {
//        NNHShopHomeController *shopVc = [[NNHShopHomeController alloc] initWithBusinessid:collectionModel.collectionID];
//        [self.navigationController pushViewController:shopVc animated:YES];
//    }else if (self.collectionType == NNHMyCollectionType_Store) {
//        NNHPhysicalStoreDetailViewController *storeVc = [[NNHPhysicalStoreDetailViewController alloc] initWithStoreID:collectionModel.collectionID];
//        [self.navigationController pushViewController:storeVc animated:YES];
//    }
}

#pragma mark -
#pragma mark ---------NNHTopToolbarDelegate

- (void)topToolbar:(NNHTopToolbar *)toolbar didSelectedButton:(UIButton *)button
{
    self.recordType = button.tag;
    [self.tableView reloadData];
    [self requestCollectionListDataWithRefresh:YES];
}

#pragma mark -
#pragma mark ---------Getters & Setters

- (NNHWalletTitleView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[NNHWalletTitleView alloc] init];
        CGFloat imageHeight = (SCREEN_WIDTH - 30) * 345 / 690;
        _titleView.frame = CGRectMake(0, NNHNavBarViewHeight, SCREEN_WIDTH, imageHeight + 40);
        NNHWeakSelf(self)
        _titleView.walletOperationBlock = ^(NNHWalletOperationType operationType) {
            if (operationType == NNHWalletOperationType_recharge) {

            }else {
                NNHLog(@"提现");
            }
        };
    }
    return _titleView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.separatorColor = [UIConfigManager colorThemeColorForVCBackground];
        _tableView.rowHeight = 70;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setupEmptyDataText:@"您还没有相关记录" emptyImage:ImageName(@"ic_order_none") tapBlock:nil];
        [_tableView registerClass:[NNHWalletTransferRecordCell class] forCellReuseIdentifier:NSStringFromClass([NNHWalletTransferRecordCell class])];
        
    }
    return _tableView;
}

- (NNHTopToolbar *)collectionToolbar
{
    if (_collectionToolbar == nil) {
        _collectionToolbar = [[NNHTopToolbar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleView.frame) + 10, SCREEN_WIDTH, NNHNormalViewH) titles:@[@"投资收益",@"充值体现",@"艺术品消费"]];
        _collectionToolbar.delegate = self;
    }
    return _collectionToolbar;
}

- (NSMutableArray <NSMutableArray *>*)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        for (int i = 0; i < 3; i++) {
            NSMutableArray *array = [NSMutableArray array];
            [_dataSource addObject:array];
        }
    }
    return _dataSource;
}


@end
