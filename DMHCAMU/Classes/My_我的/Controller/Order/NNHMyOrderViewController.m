//
//  NNHMyOrderViewController.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderViewController.h"
#import "NNHMyOrderDetailViewController.h"
#import "NNHMyOrderCell.h"
#import "NNHMyOrderHeaderView.h"
#import "NNHMyOrderFooterView.h"
#import "NNHTopToolbar.h"
#import "NNHMyOrder.h"
#import "NNHAPIMyOrderTool.h"

@interface NNHMyOrderViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 记录当前订单状态 */
@property (nonatomic, assign) NSInteger currentOrderStatus;

@end

@implementation NNHMyOrderViewController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    NNHLog(@"--------%s-----",__func__);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self loadOrderListWithRefresh:YES];
}

- (instancetype)initWithOrderStatus:(NNHOrderToobarStatus)status
{
    if (self = [super init]) {
        _currentOrderStatus = status - 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _page = 1;
    self.navigationItem.title = @"我的订单";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    [self setupRefresh];
}

- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)setupRefresh
{
    NNHWeakSelf(self)
    self.tableView.mj_header = [NNHRefreshHeader headerWithRefreshingBlock:^{
        [weakself loadOrderListWithRefresh:YES];
    }];
    
    self.tableView.mj_footer = [NNHRefreshFooter footerWithRefreshingBlock:^{
        [weakself loadOrderListWithRefresh:NO];
    }];
}

#pragma mark -
#pragma mark ---------UserAction

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NNHMyOrder *order = self.dataSource[section];
    return order.orderGoods.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHMyOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHMyOrderCell class])];
    NNHMyOrder *order = self.dataSource[indexPath.section];
    cell.orderItem = order.orderGoods[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHMyOrderDetailViewController *orderDetailVc= [[NNHMyOrderDetailViewController alloc] init];
//    NNHMyOrder *order = self.dataSource[indexPath.section];
    [self.navigationController pushViewController:orderDetailVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NNHMyOrderHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([NNHMyOrderHeaderView class])];
    if (!headerView) {
        headerView = [[NNHMyOrderHeaderView alloc] initWithReuseIdentifier:NSStringFromClass([NNHMyOrderHeaderView class])];
    }
    headerView.myOrder = self.dataSource[section];
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    NNHMyOrderFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([NNHMyOrderFooterView class])];
    if (!footerView) {
        footerView = [[NNHMyOrderFooterView alloc] initWithReuseIdentifier:NSStringFromClass([NNHMyOrderFooterView class])];
    }
    NNHMyOrder *orderModel = self.dataSource[section];
    footerView.myOrder = orderModel;
    
    // 事件处理
    NNHWeakSelf(self)
    footerView.reloadOrderDataSourceBlock = ^(NNHMyOrderOperationStatusModel *order){
        NNHStrongSelf(self)
//        [strongself.orderOperationHelper jumpWithOrderModel:orderModel operationStatusModel:order viewController:strongself];
    };
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return NNHNormalViewH;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return NNHNormalViewH *2 + NNHMargin_10;
}

- (void)loadOrderListWithRefresh:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;
    NNHAPIMyOrderTool *orderTool = [[NNHAPIMyOrderTool alloc] initWithOrderToolbarType:self.currentOrderStatus page:_page];

    NNHWeakSelf(self)
    [orderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (isRefresh) {
            [weakself loadOrderDataSource:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"] == nil) return;
            NSArray *newsArr = [NNHMyOrder mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [weakself.dataSource addObjectsFromArray:newsArr];
            [weakself.tableView reloadData];

            if ([responseDic[@"data"][@"total"]integerValue] == self.dataSource.count) {
                [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [weakself.tableView.mj_footer endRefreshing];
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadOrderDataSource:(NSDictionary *)responseDic
{
    self.dataSource = [NNHMyOrder mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    if ([responseDic[@"data"][@"total"]integerValue] == self.dataSource.count) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewGroup];
        _tableView.separatorColor = [UIConfigManager colorThemeWhite];
        _tableView.rowHeight = 100;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
        [_tableView setupEmptyDataText:@"您还没有相关订单" emptyImage:ImageName(@"ic_order_none") tapBlock:nil];
        [_tableView registerClass:[NNHMyOrderCell class] forCellReuseIdentifier:NSStringFromClass([NNHMyOrderCell class])];
    }
    return _tableView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
