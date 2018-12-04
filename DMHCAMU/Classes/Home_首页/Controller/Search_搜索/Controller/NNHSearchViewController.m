//
//  NNHSearchViewController.m
//  WBTMall
//
//  Created by 来旭磊 on 17/4/10.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHSearchViewController.h"
#import "NNHMallGoodsSearchListController.h"

#import "NNHSearchTextField.h"
#import "NNHSearchHistorySectionHeaderView.h"
#import "NNHHotSearchView.h"

#import "NNHSearchViewHelper.h"
#import "NNHAPIHomeTool.h"
#import "NNHSearchKeyWordModel.h"

@interface NNHSearchViewController ()<UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

/** 搜索关键字 */
@property (nonatomic, copy) NSString *keyword;
/** 导航栏搜索框 */
@property (nonatomic, strong) NNHSearchTextField *searchField;
/** 历史列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 热词view */
@property (nonatomic, strong) NNHHotSearchView *hotSearchView;
/** 搜索帮助类 */
@property (nonatomic, strong) NNHSearchViewHelper *searchHelper;
/** 搜索热词模型 */
@property (nonatomic, strong) NNHSearchKeyWordModel *searchModel;
@end

@implementation NNHSearchViewController

#pragma mark -
#pragma mark -------- Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeWhite];
    self.navigationItem.titleView = self.searchField;
    [self setupChildView];
    
    [self requestSearchData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.tableView reloadData];
    
    if (self.hotSearchView.hotSearchArray.count > 0) {
        [self.hotSearchView clearSubViewstatus];
    }
}

- (void)viewWillDisappear: (BOOL)animated
{
    [super viewWillDisappear:animated];
    //关闭键盘事件相应
//    [self.view endEditing:YES];
    [[IQKeyboardManager sharedManager] resignFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.searchField.textField becomeFirstResponder];
}

#pragma mark -
#pragma mark --------- PrivateMethod

- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)requestSearchData
{
    NNHWeakSelf(self);
    NNHAPIHomeTool *searchTool = [[NNHAPIHomeTool alloc] initSearchKeyWordData];
    [searchTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        weakself.searchModel = [NNHSearchKeyWordModel mj_objectWithKeyValues:responseDic[@"data"]];
        weakself.searchField.placeHoldString = weakself.searchModel.name;
        //热门搜索
        weakself.hotSearchView.hotSearchArray = weakself.searchModel.keywords;
        weakself.tableView.tableHeaderView = weakself.hotSearchView;
        [weakself.tableView reloadData];
    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}

#pragma mark -
#pragma mark --------- PublicMethod
- (void)pushSearchResultController
{
    [self.searchField.textField resignFirstResponder];
    NNHMallGoodsSearchListController *goodsList = [[NNHMallGoodsSearchListController alloc] initListVcWithkeywords:self.keyword categoryID:nil];
    goodsList.pushFromSearchVc = YES;
    [self.navigationController pushViewController:goodsList animated:YES];
}

#pragma mark -
#pragma mark --------- UserActions
- (void)searchActionWithSearchWord:(NSString *)searchWord
{
    self.keyword = searchWord;
    [self.searchHelper addNewHistoryWithSearchText:searchWord];
    [self pushSearchResultController];
}

#pragma mark -
#pragma mark --------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchHelper.historyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.font = [UIConfigManager fontThemeTextDefault];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.searchHelper.historyArray[indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchWord = self.searchHelper.historyArray[indexPath.row];
    [self searchActionWithSearchWord:searchWord];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.searchHelper.historyArray.count > 0) {
        NNHSearchHistorySectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([NNHSearchHistorySectionHeaderView class])];
        NNHWeakSelf(self)
        headerView.removeAllOperationBlock = ^{
            [weakself.searchHelper removeAllHistorySearchRecord];
            [weakself.tableView reloadData];
        };
        return headerView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.searchHelper.historyArray.count > 0) {
        return NNHNormalViewH;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchHelper deleteHistroySearchRecordAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

#pragma mark -
#pragma mark --------- UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField.hasText) {
        [self searchActionWithSearchWord:textField.text];
        return NO;
    }else if (self.searchModel.name && ![self.searchModel.name isEqualToString:@""]) {
        textField.text = self.searchModel.name;
        [self searchActionWithSearchWord:self.searchModel.name];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark --------- Getter && Setter
- (NNHSearchTextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[NNHSearchTextField alloc] initWithPlaceHold:@"搜索艺术品" uiStyle:NNHSearchTextFieldUIStyle_Gray];
        _searchField.frame = CGRectMake(0, 0, [NNHUIConfigManager widthCompareWithStandardScreenWidth:320], 26);
        _searchField.textField.delegate = self;
        if (self.keyword) {
            _searchField.textField.text = self.keyword;
        }
    }
    return _searchField;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.backgroundColor = [UIConfigManager colorThemeWhite];
        _tableView.separatorColor = [UIConfigManager colorThemeColorForVCBackground];
        _tableView.rowHeight = NNHNormalViewH;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [_tableView registerClass:[NNHSearchHistorySectionHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([NNHSearchHistorySectionHeaderView class])];
    }
    return _tableView;
}

- (NNHHotSearchView *)hotSearchView
{
    if (_hotSearchView == nil) {
        _hotSearchView = [[NNHHotSearchView alloc] init];
        NNHWeakSelf(self)
        _hotSearchView.hotSearchWordClickBlock = ^(NSInteger tag, NSString *hotWord){
            weakself.searchField.textField.text = hotWord;
            [weakself searchActionWithSearchWord:hotWord];
        };
    }
    return _hotSearchView;
}

- (NNHSearchViewHelper *)searchHelper
{
    if (_searchHelper == nil) {
        _searchHelper = [[NNHSearchViewHelper alloc] init];
    }
    return _searchHelper;
}

@end
