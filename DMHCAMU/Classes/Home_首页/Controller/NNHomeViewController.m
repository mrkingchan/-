//
//  NNHomeViewController.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/17.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNHomeViewController.h"
#import "NNHMallGoodsAuctioListController.h"
#import "NNHSearchViewController.h"
#import "NNHMallGoodsDetailViewController.h"
#import "NNHWalletViewController.h"

#import "NNHHomeTitleView.h"
#import "NNHHomePageBaseCell.h"
#import "NNHHomeCollectionSectionHeaderView.h"

#import "NNHHomePageBaseModel.h"
#import "NNHHomePageBannerModel.h"
#import "NNHHomePageGoodsModuleModel.h"
#import "NNHHomePageGoodsDetailModel.h"
#import "NNHHomePageModuleModel.h"

#import "NNHBannerModel.h"

#import "NNHAPIHomeTool.h"
#import "NNHHomePageCellFactory.h"

@interface NNHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
>

/**推荐商品的collectionview  **/
@property (nonatomic, strong) UICollectionView *productCollectionView;

/** 自定义的view */
@property (nonatomic, strong) NNHHomeTitleView *titleView;
/** 存放所有数据的数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;
/** 两行商品商品模型的数组 */
@property (nonatomic, strong) NNHHomePageGoodsModuleModel *rowListGoodsModel;
/** 回到顶部按钮 */
@property (nonatomic, strong) UIButton *topButton;
@end

@implementation NNHomeViewController

{
    NSInteger _page;
    CGFloat _titleViewHeight;
}

#pragma mark - view's lifeCircle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"首页";
    [self setupChildView];
    [self requestGoodsListUrl:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)setupChildView {
    // 适配
    nn_adjustsScrollViewInsets_NO(self.productCollectionView, self);
    [self.view addSubview:self.productCollectionView];
    [self.productCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.productCollectionView addSubview:self.titleView];
}

#pragma mark - loadData
- (void)requestGoodsListUrl:(BOOL)isRefresh
{
    _page = isRefresh ? 1 : _page + 1;
    NNHWeakSelf(self)
    NNHAPIHomeTool *homeTool = [[NNHAPIHomeTool alloc] initNewMallGoodsListDataWithPage:_page];
    [homeTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (isRefresh) {
            //刷新
            [weakself loadOrderDataSource:responseDic];
        }else{
            //加载更多
            NSArray *newsArr = [NNHHomePageGoodsDetailModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"proData"][@"list"]];
            [weakself.rowListGoodsModel.goodsArray addObjectsFromArray:newsArr];
            [weakself.productCollectionView reloadData];
            
            if ([responseDic[@"data"][@"proData"][@"total"] integerValue] == self.rowListGoodsModel.goodsArray.count) {
                [weakself.productCollectionView.mj_footer endRefreshingWithNoMoreData];
                return;
            }
            // 结束刷新
            [weakself.productCollectionView.mj_footer endRefreshing];
        }
    } failBlock:^(NNHRequestError *error) {
        [weakself.productCollectionView.mj_header endRefreshing];
        [weakself.productCollectionView.mj_footer endRefreshing];
    } isCached:NO];
}

- (void)loadOrderDataSource:(NSDictionary *)responseDic
{
    [self.dataSource removeAllObjects];

    //banner
    NSArray *bannerArray = responseDic[@"data"][@"banner"];
    if (bannerArray.count) {
        NNHHomePageBannerModel *bannerModel = [NNHHomePageBannerModel mj_objectWithKeyValues:responseDic[@"data"]];
        [self.dataSource addObject:bannerModel];
    }
    //模块
    NSArray *moduleArray = responseDic[@"data"][@"modulebanner"];
    if (moduleArray.count) {
        NSArray *moduleModelArray = [NNHHomePageModuleModel mj_objectArrayWithKeyValuesArray:moduleArray];
        [self.dataSource addObjectsFromArray:moduleModelArray];
    }
  
    //商品
    self.rowListGoodsModel = [NNHHomePageGoodsModuleModel mj_objectWithKeyValues:responseDic[@"data"][@"proData"]];
    
    [self.dataSource addObject:self.rowListGoodsModel];

    [self.productCollectionView.mj_header endRefreshing];
    [self.productCollectionView reloadData];
    
    if ([responseDic[@"data"][@"proData"][@"total"] integerValue] == self.rowListGoodsModel.goodsArray.count) {
        [self.productCollectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    // 重置刷新状态
    [self.productCollectionView.mj_footer resetNoMoreData];
}

#pragma mark -
#pragma mark --------- UserActions
// 轮播／分类跳转
- (void)actionToOtherViewController:(NNHBannerModel *)model
{
    [[NNHJumpHelper sharedInstance] jumpToDifferenceViewControllerWithBannerModel:model viewController:self];
}

/** 点击回到列表顶部 */
- (void)topButtonAction
{
    [self.productCollectionView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - UICollectionViewDataSource &Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NNHHomePageBaseModel *baseModel = self.dataSource[section];
    if (baseModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods) {
        return baseModel.goodsArray.count;
    }
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NNHHomePageBaseModel *baseModel = self.dataSource[indexPath.section];
    NNHHomePageBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NNHHomePageCellFactory reuseIdentifierForModel:baseModel] forIndexPath:indexPath];
    cell.cellIndexPath = indexPath;
    cell.baseModel = baseModel;
    NNHWeakSelf(self)
    //点击banner
    cell.didSelectedItemBlock = ^(NSInteger index){
        NNHBannerModel *bannerModel = baseModel.bannerArray[index];
        [weakself actionToOtherViewController:bannerModel];
    };

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NNHHomePageBaseModel *baseModel = self.dataSource[indexPath.section];
    //点击的是商品
    if (baseModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods) {
        NNHHomePageGoodsDetailModel *goodsModel = baseModel.goodsArray[indexPath.row];
        NNHMallGoodsDetailViewController *listVC = [[NNHMallGoodsDetailViewController alloc] init];
        listVC.goodsID = goodsModel.goodsID;
        [self.navigationController pushViewController:listVC animated:YES];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [NNHHomePageCellFactory itemSizeWithModel:self.dataSource[indexPath.section]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return [NNHHomePageCellFactory headerSectionItemSizeWithModel:self.dataSource[section]];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头视图
    NNHHomeCollectionSectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([NNHHomeCollectionSectionHeaderView class]) forIndexPath:indexPath];
    NNHHomePageBaseModel *baseModel = self.dataSource[indexPath.section];
    header.baseModel = baseModel;
    if (baseModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods && baseModel.goodsArray.count > 0) {
        header.hidden = NO;
    }else {
        header.hidden = YES;
    }
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return [NNHHomePageCellFactory footerSectionItemSizeWithModel:self.dataSource[section]];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    NNHHomePageBaseModel *baseModel = self.dataSource[section];
    
    if (section == 0) {
        return UIEdgeInsetsMake(_titleViewHeight, 0, 0, 0);
    }
    
    if (baseModel.cellIdentifier == NNHHomePageModelCellIdentifier_NormalGoods) {
        return UIEdgeInsetsMake(0, NNHMargin_15, 0, NNHMargin_15);
    }else {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffSetY = scrollView.contentOffset.y;

    self.topButton.hidden = contentOffSetY < SCREEN_HEIGHT;
    
    //监听滑动量控制导航栏的隐藏和显示
    if (contentOffSetY > _titleViewHeight - (NNHNavBarViewHeight)) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
    else {
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }
}

#pragma mark - lazy Loads
- (NNHHomeTitleView *)titleView
{
    if (_titleView == nil) {
        _titleView = [[NNHHomeTitleView alloc] init];
        _titleViewHeight = (NNHNavBarViewHeight) + NNHNormalViewH;
        _titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _titleViewHeight);
        _titleView.backgroundColor = [UIConfigManager colorThemeWhite];
        _titleView.textFieldGroundColor = [UIConfigManager colorThemeColorForVCBackground];
        NNHWeakSelf(self)
        _titleView.didBeginEditSearchBlock = ^(){
            NNHSearchViewController *searchVc = [[NNHSearchViewController alloc] init];
            [weakself.navigationController pushViewController:searchVc animated:NO];
        };
    }
    return _titleView;
}

- (UICollectionView *)productCollectionView
{
    if (_productCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _productCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _productCollectionView.backgroundColor = [UIConfigManager colorThemeWhite];
        _productCollectionView.delegate = self;
        _productCollectionView.dataSource = self;
        _productCollectionView.showsVerticalScrollIndicator = NO;
        [NNHHomePageCellFactory registerCellClassForCollectionView:_productCollectionView];
        [_productCollectionView setContentInset:UIEdgeInsetsZero];
        
        [_productCollectionView registerClass:[NNHHomeCollectionSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([NNHHomeCollectionSectionHeaderView class])];
        
        NNHWeakSelf(self)
        _productCollectionView.mj_header = [NNHRefreshHeader headerWithRefreshingBlock:^{
            NNHStrongSelf(self)
            if (weakself.dataSource.count == 0) return ;
            [strongself.productCollectionView reloadData];
            [strongself requestGoodsListUrl:YES];
        }];
        _productCollectionView.mj_footer = [NNHRefreshFooter footerWithRefreshingBlock:^{
            NNHStrongSelf(self)
            [strongself requestGoodsListUrl:NO];
        }];
    }
    return _productCollectionView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UIButton *)topButton
{
    if (_topButton == nil) {
        _topButton = [UIButton NNHBtnImage:@"ic_top" target:self action:@selector(topButtonAction)];
        _topButton.hidden = YES;
        _topButton.adjustsImageWhenHighlighted = NO;
    }
    return _topButton;
}

#pragma mark - memory management
-(void)dealloc {
    if (_productCollectionView) {
        _productCollectionView.dataSource = nil;
        _productCollectionView.delegate = nil;
        _productCollectionView = nil;
    }
    if (_dataSource) {
        _dataSource = nil;
    }
    if (_titleView) {
        _titleView = nil;
    }
    if (_rowListGoodsModel) {
        _rowListGoodsModel = nil;
    }
    if (_topButton) {
        _topButton = nil;
    }
}
@end
