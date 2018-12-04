//
//  NNHMallGoodsSearchListController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsSearchListController.h"
#import "NNHMallGoodsDetailViewController.h"

#import "NNHHomePageGoodsCell.h"
#import "NNHSearchTextField.h"
#import "NNHMallGoodsListSortView.h"

#import "NNHAPIHomeTool.h"
#import "NNHHomePageGoodsDetailModel.h"

@interface NNHMallGoodsSearchListController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITextFieldDelegate
>

/** 导航栏中间搜索textField */
@property (nonatomic, strong) NNHSearchTextField *searchField;
/**推荐商品的collectionview  **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 筛选view **/
@property (nonatomic, strong) NNHMallGoodsListSortView *sortView;
/** 商品数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

/** 搜索关键字 */
@property (nonatomic, copy) NSString *keywords;
/** 分类id */
@property (nonatomic, strong) NSString *categoryID;
/** 价格排序字段 */
@property (nonatomic, copy) NSString *priceSortString;
/** 关注排序字段 */
@property (nonatomic, copy) NSString *followSortString;

@end

@implementation NNHMallGoodsSearchListController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------viewDidLoad

- (instancetype)initListVcWithkeywords:(NSString *)keywords categoryID:(nonnull NSString *)categoryID
{
    if (self = [super init]) {
        _keywords = keywords;
        _categoryID = categoryID;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeWhite];
    if (self.keywords.length) {
        self.searchField.textField.text = self.keywords;
    }
    [self setupNavItem];
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
    [self requestGoodsDataWithUrl:YES];

}

/** 设置导航栏 */
- (void)setupNavItem
{
    UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
    
    self.navigationItem.titleView = self.searchField;
}

- (void)setupChildView
{
    [self.view addSubview:self.sortView];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.sortView.mas_bottom);
    }];
}

- (void)leftItemClick
{
    if (self.pushFromSearchVc) {
        NSArray *array = self.navigationController.viewControllers;
        UIViewController *viewController = array[array.count - 3];
        [self.navigationController popToViewController:viewController animated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -
#pragma mark ---------------- PublicMethod ----------------


#pragma mark -
#pragma mark ---------请求数据

- (void)requestGoodsDataWithUrl:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;

    NNHAPIHomeTool *goodsTool = [[NNHAPIHomeTool alloc] initMallGoodsListWithKeywords:self.keywords cid:self.categoryID page:_page priceSort:self.priceSortString followNum:self.followSortString];
    NNHWeakSelf(self)
    [goodsTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {

        [SVProgressHUD dismiss];
        NNHStrongSelf(self)
        if (isRefresh) {
            [strongself loadShopHomeDataSource:responseDic];
        }else{
            // 数据转化
            if (responseDic[@"data"] == nil) return;
            NSArray *newsArr = [NNHHomePageGoodsDetailModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"prolist"][@"list"]];
            [strongself.dataSource addObjectsFromArray:newsArr];
            [strongself.collectionView reloadData];

            if ([responseDic[@"data"][@"prolist"][@"total"]integerValue] == strongself.dataSource.count) {
                [strongself.collectionView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [strongself.collectionView.mj_footer endRefreshing];
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.collectionView.mj_header endRefreshing];
        [weakself.collectionView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadShopHomeDataSource:(NSDictionary *)responseDic
{
    self.dataSource = [NNHHomePageGoodsDetailModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"prolist"][@"list"]];
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
    if ([responseDic[@"data"][@"total"]integerValue] == self.dataSource.count) {
        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.collectionView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark ---------UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNHHomePageGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NNHHomePageGoodsCell class]) forIndexPath:indexPath];
    cell.goodsModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNHHomePageGoodsDetailModel *goodsModel = self.dataSource[indexPath.row];
    NNHMallGoodsDetailViewController *listVC = [[NNHMallGoodsDetailViewController alloc] init];
    listVC.goodsID = goodsModel.productid;
    [self.navigationController pushViewController:listVC animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, NNHMargin_15, 0, NNHMargin_15);
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!textField.hasText) {
        return YES;
    }
    [[IQKeyboardManager sharedManager] resignFirstResponder];

    self.keywords = textField.text;
    [self requestGoodsDataWithUrl:YES];
    return YES;
}

#pragma mark -
#pragma mark ---------------- NNHGoodsListSortViewDelegate ----------------

#pragma mark -
#pragma mark ---------UserAction
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 35) * 0.5, (SCREEN_WIDTH - 35) * 0.5  + NNHNormalViewH * 1.9);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIConfigManager colorThemeWhite];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[NNHHomePageGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([NNHHomePageGoodsCell class])];
        [_collectionView setContentInset:UIEdgeInsetsMake(NNHMargin_5, 0, NNHMargin_5, 0)];
        
        [_collectionView setupEmptyDataText:@"啊哦，搜索不到相关结果" emptyImage:ImageName(@"ic_search_none") tapBlock:nil];
        
        NNHWeakSelf(self)
        _collectionView.mj_header = [NNHRefreshHeader headerWithRefreshingBlock:^{
            {
                NNHStrongSelf(self)
                [strongself requestGoodsDataWithUrl:YES];
            }
        }];
        _collectionView.mj_footer = [NNHRefreshFooter footerWithRefreshingBlock:^{
            {
                NNHStrongSelf(self)
                [strongself requestGoodsDataWithUrl:NO];
            }
        }];
    }
    return _collectionView;
}

- (NNHSearchTextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[NNHSearchTextField alloc] initWithPlaceHold:@"搜索商品或关键字" uiStyle:NNHSearchTextFieldUIStyle_Gray];
        _searchField.textField.delegate = self;
        _searchField.backgroundColor = NNHRGBColor(229, 229, 229);
        _searchField.frame = CGRectMake(0, 0, [NNHUIConfigManager widthCompareWithStandardScreenWidth:280], 26);
    }
    return _searchField;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NNHMallGoodsListSortView *)sortView
{
    if (_sortView == nil) {
        _sortView = [[NNHMallGoodsListSortView alloc] init];
        _sortView.frame = CGRectMake(0, NNHNavBarViewHeight, SCREEN_WIDTH, NNHNormalViewH);
        NNHWeakSelf(self)
        _sortView.didSelectedSortButtonBlock = ^(NSString * _Nonnull sortString, NSInteger index) {
            if (index == 0) {
                weakself.priceSortString = @"";
                weakself.followSortString = @"";
            }else if (index == 1) {
                weakself.followSortString = sortString;
            }else {
                weakself.priceSortString = sortString;
            }
            
            [weakself requestGoodsDataWithUrl:YES];
        };
    }
    return _sortView;
}
@end

