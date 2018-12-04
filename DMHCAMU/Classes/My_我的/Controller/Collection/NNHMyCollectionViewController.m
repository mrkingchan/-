//
//  NNHMyCollectionViewController.m
//  ZTHYMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyCollectionViewController.h"
#import "NNHMyCollectionCell.h"
#import "NNHApiMyCollectionTool.h"
#import "NNHMyCollectionModel.h"
#import "NNHAlertTool.h"


@interface NNHMyCollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

/** tableView */
@property (nonatomic, strong) UITableView *tableView;
/** 数据模型 */
@property (nonatomic, strong) NSMutableArray <NNHMyCollectionModel *>*dataSource;

@end

@implementation NNHMyCollectionViewController
{
    NSInteger _page;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"我的关注";
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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
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
    NNHWeakSelf(self)
    _page = isRefresh ? 1 : _page + 1;
    NNHApiMyCollectionTool *collectionTool = [[NNHApiMyCollectionTool alloc] initWithUserCollectionListWithPage:_page];
    [collectionTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadOrderDataSource:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"] == nil) return;
            NSArray *newsArr = [NNHMyCollectionModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
            [strongself.dataSource addObjectsFromArray:newsArr];
            [strongself.tableView reloadData];

            if ([responseDic[@"data"][@"total"]integerValue] == [self.dataSource count]) {
                [strongself.tableView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [strongself.tableView.mj_footer endRefreshing];
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadOrderDataSource:(NSDictionary *)responseDic
{
    self.dataSource = [NNHMyCollectionModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"list"]];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
    if ([responseDic[@"data"][@"total"]integerValue] == [self.dataSource count]) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.tableView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHMyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHMyCollectionCell class])];
    cell.collectionModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NNHMyCollectionModel *model = self.dataSource[indexPath.row];
        NNHWeakSelf(self)
        NNHApiMyCollectionTool *collectionTool = [[NNHApiMyCollectionTool alloc] initWithUserCollectionOperationWithCollectionObjectID:model.collectionID isCollection:NO];
        [collectionTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
            
            [SVProgressHUD showMessage:@"取消关注"];
            [weakself.dataSource removeObjectAtIndex:indexPath.row];
            [weakself.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        } failBlock:^(NNHRequestError *error) {
            
        } isCached:NO];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消关注";
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.rowHeight = 150;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView setupEmptyDataText:@"您还没有相关关注" emptyImage:ImageName(@"ic_collection_none") tapBlock:nil];
        [_tableView registerClass:[NNHMyCollectionCell class] forCellReuseIdentifier:NSStringFromClass([NNHMyCollectionCell class])];
    }
    return _tableView;
}

- (NSMutableArray <NNHMyCollectionModel *>*)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

@end
