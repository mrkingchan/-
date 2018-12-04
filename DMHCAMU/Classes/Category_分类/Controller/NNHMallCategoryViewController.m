//
//  NNHCategoryViewController.m
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/9.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMallCategoryViewController.h"
#import "NNHMallGoodsSearchListController.h"

#import "NNHShopIndexCategoryCollectionCell.h"
#import "NNHGoodsCategoryCollectionReusableView.h"
#import "NNHGoodsCategoryReusableView.h"

#import "NNHAPIHomeTool.h"
#import "NNHAllGoodsCategoryModel.h"

@interface NNHMallCategoryViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout,
UITableViewDelegate,
UITableViewDataSource
>

/** <#注释#> */
@property (nonatomic, strong) UITableView *tableView;
/**推荐商品的collectionview  **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 分类数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** collectonview全部高度 */
@property (nonatomic, assign) CGFloat allContentSize;
/** 当前已经被推出来的sectionHeader **/
@property (nonatomic, strong)   NSMutableArray *sectionHeaders;
/** 判断当前是否是通过选择左边来跳转右边 **/
@property (nonatomic, assign)   BOOL isSelectedTableView;
@end

@implementation NNHMallCategoryViewController

#pragma mark -
#pragma mark ---------viewDidLoad

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupNavItem];
    [self setupChildView];
    self.isSelectedTableView = YES;
    [self requestCategoryData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

/** 设置导航栏 */
- (void)setupNavItem
{
    self.navigationItem.title = @"商品分类";
}

- (void)setupChildView
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(@90);
    }];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHNavBarViewHeight);
        make.bottom.right.equalTo(self.view);
        make.width.equalTo(@(SCREEN_WIDTH - 90));
    }];
}

/** 请求分类数据 */
- (void)requestCategoryData
{
    NNHWeakSelf(self)
    NNHAPIHomeTool *shopTool = [[NNHAPIHomeTool alloc] initAllGodsCategoryDataWithPage:0 businessID:nil showAll:NO];
    [shopTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NSArray *array = [NNHAllGoodsCategoryModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
        [weakself.dataSource addObjectsFromArray:array];
        [weakself.collectionView reloadData];
        [weakself.tableView reloadData];
        [weakself.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

#pragma mark -
#pragma mark ---------UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.font = [UIConfigManager fontThemeTextDefault];
    NNHAllGoodsCategoryModel *cateModel = self.dataSource[indexPath.row];
    cell.textLabel.text = cateModel.name;
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.highlightedTextColor = [UIConfigManager  colorThemeRed];
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    return cell;
}

#pragma mark -
#pragma mark ---------UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    CGFloat contentOffsetY = [self scrollerToIndex:index];
    if (contentOffsetY > self.allContentSize - (SCREEN_HEIGHT - NNHNavBarViewHeight)) {
        contentOffsetY = self.allContentSize - (SCREEN_HEIGHT - NNHNavBarViewHeight);
    }
    self.isSelectedTableView = YES;
    self.collectionView.contentOffset = CGPointMake(0, contentOffsetY);
}

- (CGFloat)scrollerToIndex:(NSInteger)index
{
    if (index == 0) {
        return 0;
    }else {
        CGFloat allHeight = 0;
        for (int i = 0; i < index; i ++) {
            NNHAllGoodsCategoryModel *cateModel = self.dataSource[i];
            NSInteger totalPageNum = (cateModel.sonCateArray.count  +  3  - 1) / 3;
            CGFloat width = (SCREEN_WIDTH - 90) / 3;
            CGFloat height = totalPageNum * width * 1.3 + NNHNormalViewH;
            allHeight += height;
        }
        return allHeight;
    }
}

#pragma mark -
#pragma mark ---------UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NNHAllGoodsCategoryModel *cateModel = self.dataSource[section];
    return cateModel.sonCateArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNHShopIndexCategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([NNHShopIndexCategoryCollectionCell class]) forIndexPath:indexPath];
    NNHAllGoodsCategoryModel *cateModel = self.dataSource[indexPath.section];
    cell.goodsCateModel = cateModel.sonCateArray[indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NNHGoodsCategoryReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([NNHGoodsCategoryReusableView class]) forIndexPath:indexPath];
    NNHAllGoodsCategoryModel *cateModel = self.dataSource[indexPath.section];
    headerView.goodsCateModel = cateModel;
//    NNHWeakSelf(self)
//    headerView.didClickHeaderBlock = ^(){
//        NNHMallGoodsListController *goodsList = [[NNHMallGoodsListController alloc] initListVcWithkeywords:nil cid:cateModel.categoryID prefeatureType:nil busniessID:nil];
//        [weakself.navigationController pushViewController:goodsList animated:YES];
//    };
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(SCREEN_WIDTH - 90, NNHNormalViewH);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectedTableView == NO) {
        NSIndexPath *tableIndexPath = [NSIndexPath indexPathForRow:indexPath.section inSection:0];
        [self.tableView selectRowAtIndexPath:tableIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
}

#pragma mark -
#pragma mark ---------UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNHAllGoodsCategoryModel *cateModel = self.dataSource[indexPath.section];
    NNHAllGoodsCategoryModel *subCateModel = cateModel.sonCateArray[indexPath.row];
    
    NNHMallGoodsSearchListController *listVC = [[NNHMallGoodsSearchListController alloc] initListVcWithkeywords:nil categoryID:subCateModel.categoryID ];
    [self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark -
#pragma mark ---------Getter && Setter
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    self.isSelectedTableView = NO;
}

#pragma mark -
#pragma mark ---------UserAction

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = NNHNormalViewH;
        _tableView.bounces = YES;
        _tableView.backgroundColor = [UIConfigManager colorThemeWhite];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _tableView;
}

- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 90) / 3, (SCREEN_WIDTH - 90) / 3 * 1.3);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[NNHShopIndexCategoryCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([NNHShopIndexCategoryCollectionCell class])];
        [_collectionView registerClass:[NNHGoodsCategoryReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([NNHGoodsCategoryReusableView class])];
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (CGFloat)allContentSize
{
    if (_allContentSize == 0) {
        if (self.dataSource.count > 0) {
            _allContentSize = [self scrollerToIndex:self.dataSource.count];
        }
    }
    return _allContentSize;
}

- (NSMutableArray *)sectionHeaders
{
    if (_sectionHeaders == nil) {
        _sectionHeaders = [NSMutableArray array];
    }
    return _sectionHeaders;
}

@end
