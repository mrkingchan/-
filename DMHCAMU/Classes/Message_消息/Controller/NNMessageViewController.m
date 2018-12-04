//
//  NNMessageViewController.m
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/17.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import "NNMessageViewController.h"
#import "NNHMessageSystemCell.h"
#import <RongIMKit/RongIMKit.h>
#import "NNHMessageFactoryModel.h"
#import "NSDictionary+NNHExtension.h"
#import "NNHJumpHelper.h"
#import "NNHBannerModel.h"

@interface NNMessageViewController ()<UITableViewDelegate, UITableViewDataSource>
/** 列表 */
@property (nonatomic, strong) UITableView *tableView;
/** 数组 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation NNMessageViewController

#pragma mark -
#pragma mark -------- Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"系统消息";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [self setupChildView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.dataSource removeAllObjects];
    NSArray *array = [[RCIMClient sharedRCIMClient] getLatestMessages:ConversationType_SYSTEM
                                                             targetId:@"0267aaf632e87a63288a08331f22c7c3"
                                                                count:100];
    [self.dataSource addObjectsFromArray:array];
    [self.tableView reloadData];
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

#pragma mark -
#pragma mark --------- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NNHMessageSystemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NNHMessageSystemCell class])];
    cell.rcMessageModel = self.dataSource[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessage *message = self.dataSource[indexPath.row];
    
    return [NNHMessageFactoryModel tableViewCellWithMessage:message cellType:NNHMessageShowType_System];
}

#pragma mark -
#pragma mark --------- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RCMessage *message = self.dataSource[indexPath.row];
    // 图文消息
    if ([message.content isKindOfClass:[RCRichContentMessage class]]) {
        
        RCRichContentMessage *richMessage = (RCRichContentMessage *)message.content;
        if (richMessage.extra) {
#warning 改变解码方法
            NSDictionary *orderDict = [richMessage.extra jsonValueDecoded];
            if (orderDict[@"url"] && orderDict[@"urltype"]) {
                NNHBannerModel *bannerModel = [[NNHBannerModel alloc] init];
                bannerModel.bannerUrl = orderDict[@"url"];
                bannerModel.bannerUrltype = orderDict[@"urltype"];
                [self jumpToOtherViewControllerWithBannerModel:bannerModel];
            }
        }
    }
}

- (void)jumpToOtherViewControllerWithBannerModel:(NNHBannerModel *)bannerModel
{
    [[NNHJumpHelper sharedInstance] jumpToDifferenceViewControllerWithBannerModel:bannerModel viewController:self];
}

#pragma mark -
#pragma mark --------- UITextFieldDelegate

#pragma mark -
#pragma mark --------- Getter && Setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [UITableView nnhTableViewPlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = YES;
        [_tableView setupEmptyDataText:@"暂无消息" emptyImage:ImageName(@"ic_message_none") tapBlock:nil];
        [_tableView registerClass:[NNHMessageSystemCell class] forCellReuseIdentifier:NSStringFromClass([NNHMessageSystemCell class])];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, NNHMargin_10, 0);
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
