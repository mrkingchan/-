//
//  NNHMallGoodsDetailContentView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/19.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsDetailContentView.h"
#import <WebKit/WebKit.h>

@interface NNHMallGoodsDetailContentView ()<WKNavigationDelegate>

/** 图文详情webView */
@property (nonatomic, strong) WKWebView *webView;


@end

@implementation NNHMallGoodsDetailContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupChildView];
        
    }
    return self;
}

- (void)setupChildView
{
    UILabel *titleLabel = [UILabel NNHWithTitle:@"图文详情" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextDefault]];
    
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.height.equalTo(@(NNHNormalViewH));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.height.equalTo(@(NNHLineH));
        make.bottom.equalTo(titleLabel);
    }];
    
    [self addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(titleLabel.mas_bottom).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(self).offset(-NNHMargin_20);
    }];
}
- (void)setUrlString:(NSString *)urlString
{
    _urlString = urlString;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (WKWebView *)webView
{
    if (_webView == nil) {
        _webView = [[WKWebView alloc] init];
        _webView.navigationDelegate = self;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

//页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NNHWeakSelf(self)
    [webView evaluateJavaScript:@"document.body.offsetHeight;" completionHandler:^(id _Nullable any, NSError * _Nullable error) {
        
        NSString *heightStr = [NSString stringWithFormat:@"%@",any];
        [weakself.webView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(heightStr.floatValue));
        }];
    }];
}

@end
