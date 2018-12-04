//
//  NNHMallPaySuccessViewController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallPaySuccessViewController.h"

@interface NNHMallPaySuccessViewController ()

@end

@implementation NNHMallPaySuccessViewController

#pragma mark -
#pragma mark -------- Lifecycle


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIConfigManager colorThemeWhite];
    [self setNavItem];
    [self setupChildView];
}

#pragma mark -
#pragma mark --------- PrivateMethod

- (void)setNavItem
{
    self.navigationItem.title = @"付款成功";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(leftItemClick)];
}

- (void)setupChildView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(NNHNavBarViewHeight);
        make.height.equalTo(@(140));
    }];
    
    UIImageView *successImageView = [[UIImageView alloc] init];
    successImageView.image = [UIImage imageNamed:@"ic_pay_succeed"];
    [contentView addSubview:successImageView];
    [successImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.right.equalTo(contentView.mas_centerX).offset(-NNHMargin_20);
    }];
    
    UILabel *messageLabel = [UILabel NNHWithTitle:@"付款成功" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeLargerBtnTitles]];
    [contentView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contentView);
        make.left.equalTo(contentView.mas_centerX);
    }];
}

- (void)leftItemClick
{
//    NSArray *array = self.navigationController.viewControllers;
//    UIViewController *viewController = array[array.count - 4];
//
//    [self.navigationController popToViewController:viewController animated:YES];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark --------- RequestNetData




@end

