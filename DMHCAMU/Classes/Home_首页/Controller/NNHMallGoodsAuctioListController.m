//
//  NNHMallGoodsAuctioListController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsAuctioListController.h"
#import "NNHHomePageGoodsCell.h"
#import "NNHAPIHomeTool.h"
#import "NNHHomePageGoodsDetailModel.h"


@interface NNHMallGoodsAuctioListController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>


/**推荐商品的collectionview  **/
@property (nonatomic, strong) UICollectionView *collectionView;
/** 商品数组 */
@property (nonatomic, strong) NSMutableArray <NNHHomePageGoodsDetailModel *>*dataSource;

@end

@implementation NNHMallGoodsAuctioListController
{
    NSInteger _page;
}

#pragma mark -
#pragma mark ---------viewDidLoad


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    self.navigationItem.title = @"近期拍卖";
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setupChildView
{
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark -
#pragma mark ---------请求数据

- (void)requestGoodsDataWithUrl:(BOOL)isRefresh
{
    /*_page = isRefresh ? 1 : _page + 1;

    NNHAPIHomeTool *goodsTool = [[NNHAPIHomeTool alloc] initMallGoodsListWithKeywords:self.keywords cid:self.cid page:_page price_sort:self.priceSortString producttype:self.prefeatureString businessID:self.businessID];
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
     */
    
}

- (void)loadShopHomeDataSource:(NSDictionary *)responseDic
{
//    self.dataSource = [NNHHomePageGoodsDetailModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"][@"prolist"][@"list"]];
//    [self.collectionView reloadData];
//    [self.collectionView.mj_header endRefreshing];
//    if ([responseDic[@"data"][@"total"]integerValue] == self.dataSource.count) {
//        [self.collectionView.mj_footer endRefreshingWithNoMoreData];
//        return;
//    }
//    // 重置刷新状态
//    [self.collectionView.mj_footer resetNoMoreData];
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
//    cell.goodsModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark ---------UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NNHGoodsDetailViewController *goodsDetailVc = [[NNHGoodsDetailViewController alloc] init];
//    NNHCartGoodsModel *goodsModel = self.dataSource[indexPath.row];
//    goodsDetailVc.goodsID = goodsModel.productid;
//    [self.navigationController pushViewController:goodsDetailVc animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 12, 0, 12);
}

#pragma mark - lazy Loads
- (UICollectionView *)collectionView
{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 5;
        
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 29) * 0.5, (SCREEN_WIDTH - 29) * 0.5  + NNHNormalViewH * 2.2);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[NNHHomePageGoodsCell class] forCellWithReuseIdentifier:NSStringFromClass([NNHHomePageGoodsCell class])];
        [_collectionView setContentInset:UIEdgeInsetsMake(NNHMargin_5, 0, NNHMargin_5, 0)];
        
        NNHWeakSelf(self);
        [_collectionView setupEmptyDataText:@"啊哦，搜索不到相关结果" emptyImage:ImageName(@"ic_search_none") tapBlock:^ {
            NNHStrongSelf(self);
            [strongself requestGoodsDataWithUrl:YES];
        }];
        
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

- (NSMutableArray <NNHHomePageGoodsDetailModel *>*)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - memory management
-(void)dealloc {
    NSLog(@"%@释放了",NSStringFromClass([self class]));
    if (_collectionView) {
        _collectionView.dataSource = nil;
        _collectionView.delegate = nil;
        _collectionView = nil;
    }
    if (_dataSource) {
        [_dataSource removeAllObjects];
        _dataSource = nil;
    }
}
@end
