//
//  NNHWebViewController.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/11/3.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHWebViewController.h"
//#import "NNHGoodsDetailViewController.h"
#import "YTKNetworkConfig.h"
#import <WebKit/WebKit.h>
//#import "NNHPayViewController.h"
#import "NNHBannerModel.h"
#import "NNHJumpHelper.h"

@interface NNHWebViewController () <WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webview;
@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation NNHWebViewController
{
    NSString *_rootBack;
}

#pragma mark -
#pragma mark ---------Life Cycle
- (void)dealloc
{
    self.webview.navigationDelegate = nil;
    [self.webview removeObserver:self forKeyPath:@"title"];
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
    [self clearCache];
}

- (void)clearCache
{
    if (UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"9.0")) {
        WKWebsiteDataStore *dateStore = [WKWebsiteDataStore defaultDataStore];
        [dateStore fetchDataRecordsOfTypes:[WKWebsiteDataStore allWebsiteDataTypes]
                         completionHandler:^(NSArray<WKWebsiteDataRecord *> * __nonnull records) {
                             for (WKWebsiteDataRecord *record  in records){
                                 [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:record.dataTypes
                                        forDataRecords:@[record]
                                     completionHandler:^{

                                       }];
                             }
       }];

    }else{
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                   NSUserDomainMask, YES)[0];
        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
                                objectForKey:@"CFBundleIdentifier"];
        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
        NSString *webKitFolderInCaches = [NSString
                                          stringWithFormat:@"%@/Caches/%@/WebKit",libraryDir,bundleId];
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCaches error:&error];
        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    // 导航
    UIImage *backImage = [[UIImage imageNamed:@"ic_nav_back"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    // 初始化webview
    [self setupChildView];
    
    // 展示网页
    [self setupRequest];
    
    // kvo监听
    [self setupKVO];    
}

- (void)setupRequest
{
    // 给本地链接增加协议
    if (![_url containsString:@"http://"]) {
        _url = [NSString stringWithFormat:@"%@%@",[YTKNetworkConfig sharedConfig].cdnUrl,_url];
    }
    
    // 给允许的跳转的url 拼接mtoken 及 接口版本号
    if ([NNHProjectControlCenter sharedControlCenter].userControl.isLoginIn) {
        if ([_url containsString:@"?"]) {
            _url = [NSString stringWithFormat:@"%@&mtoken=%@",_url,[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.mtoken];
        }else{
            _url = [NSString stringWithFormat:@"%@?mtoken=%@",_url,[NNHProjectControlCenter sharedControlCenter].userControl_currentUserModel.mtoken];
        }
    }
    
    // 拼接接口版本号
    if ([_url containsString:@"?"]) {
        _url = [NSString stringWithFormat:@"%@&_v=%@",_url,NNHPort];
    }else{
        _url = [NSString stringWithFormat:@"%@?&_v=%@",_url,NNHPort];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [self.webview loadRequest:request];
}

- (void)setupKVO
{
    // KVO监听属性改变 KVO注意点.一定要记得移除 (title／estimatedProgress)
    [self.webview addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [self.webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)setupChildView
{
    [self.view addSubview:self.webview];
    [self.webview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.progressView];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHNavBarViewHeight);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@1);
    }];
}

- (void)back
{
    if ([_rootBack isEqualToString:@"2"] && self.webview.canGoBack) {
        [self.webview goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/** 页面支付 */
- (void)pushPayViewControllerWithOrderNum:(NSString *)orderNum priceAmount:(NSString *)price bullAmount:(NSString *)bull noPayUrl:(NSString *)nopayUrl receiveUrl:(NSString *)receiveUrl
{
//    NNHPayViewController *payVc = [[NNHPayViewController alloc] initWithOrderNum:orderNum priceAmount:price bullAmount:bull payContentType:NNHPaymentContentType_Normal];
//    [self.navigationController pushViewController:payVc animated:YES];
//
//    NNHWeakSelf(self)
//    //取消支付 -> 去到未付款页面
//    payVc.canclePayBlock = ^(BOOL hasCreateOrder){
//        [weakself.navigationController popViewControllerAnimated:YES];
//        if (![NSString isEmptyString:nopayUrl]) {
//            [weakself.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:nopayUrl]]];
//        }
//    };
//    //成功失败一个效果
//    payVc.successPayBlock = ^(){
//        [weakself.navigationController popViewControllerAnimated:YES];
//        [weakself.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:receiveUrl]]];
//    };
}

#pragma mark -
#pragma mark ---------WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLFragmentAllowedCharacterSet]];
    
    // 返回处理
    if ([urlString rangeOfString:@"gobacktype="].location != NSNotFound) {
        NSRange rang = [urlString rangeOfString:@"gobacktype="];
        _rootBack = [urlString substringWithRange:NSMakeRange(rang.location + rang.length, 1)];
    }
    
//    // 跳转处理
//    if ([urlString rangeOfString:@"urltype=1"].location != NSNotFound && [urlString rangeOfString:@"goodsid"].location != NSNotFound) { // 商品详情
//        NSString *productStr = [[urlString componentsSeparatedByString:@"&"] firstObject];
//        NSString *productID = [[productStr componentsSeparatedByString:@"="] lastObject];
//        if (![NSString isEmptyString:productID]) {
//            NNHGoodsDetailViewController *vc = [[NNHGoodsDetailViewController alloc]init];
//            vc.goodsID = productID;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//        decisionHandler(WKNavigationActionPolicyCancel);
//
//        return;
//
//    }else if ([urlString rangeOfString:@"niuniuhuiappPay"].location != NSNotFound){ // 支付
//
//        urlString = [urlString stringByRemovingPercentEncoding];
//
//        // 解析url中的所有参数
//        NSDictionary *paramsDic = [urlString getUrlParameters];
//
//        // 获取对应参数的值
//        NSString *orderNo = paramsDic[@"orderNo"]; // 订单号
//        NSString *niuniuhuiappPay = paramsDic[@"niuniuhuiappPay"]; // 校验码
//        NSString *nopayUrl = paramsDic[@"nopayUrl"]; // 支付失败回调
//        NSString *receiveUrl = paramsDic[@"receiveUrl"]; // 支付成功回调
//        NSString *bull = paramsDic[@"bull"]; // 牛豆
//        NSString *price = paramsDic[@"price"]; // 价格
//
//        // 校验订单是否有效
//        NSString *checkOrderStr = [NSString stringWithFormat:@"bull=%@&nopayUrl=%@&orderNo=%@&price=%@&receiveUrl=%@%@",bull,nopayUrl,orderNo,price,receiveUrl,NNHAPI_PRIVATEKEY_IOS];
//        if ([niuniuhuiappPay isEqualToString:[checkOrderStr md5String]]) { // 调起支付
//            [self pushPayViewControllerWithOrderNum:orderNo priceAmount:price bullAmount:bull noPayUrl:nopayUrl receiveUrl:receiveUrl];
//        }
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//
//        return;
//    }else if ([urlString rangeOfString:@"urltype="].location != NSNotFound && [urlString rangeOfString:@"url="].location != NSNotFound){
//
//        urlString = [urlString stringByRemovingPercentEncoding];
//
//        // 解析url中的所有参数
//        NSDictionary *paramsDic = [urlString getUrlParameters];
//
//        NNHBannerModel *bannerModel = [[NNHBannerModel alloc] init];
//        bannerModel.bannerUrltype = paramsDic[@"urltype"];
//        bannerModel.bannerUrl = paramsDic[@"url"];
//
//        //banner 跳转
//        [[NNHJumpHelper sharedInstance] jumpToDifferenceViewControllerWithBannerModel:bannerModel viewController:self];
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//
//        return;
//    }
    decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
}

#pragma mark - KVO
#pragma mark ---------只要观察对象属性有新值就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (self.navTitle) {
        self.navigationItem.title = self.navTitle;
    }else{
        if (self.webview.title.length) {
            self.navigationItem.title = self.webview.title;
        }
    }

    self.progressView.progress = self.webview.estimatedProgress;
    self.progressView.hidden = self.webview.estimatedProgress >= 1;
}

#pragma mark -
#pragma mark ---------Getters & Setters
- (WKWebView *)webview
{
    if (_webview == nil) {
        _webview = [[WKWebView alloc] init];
        _webview.navigationDelegate = self;
    }
    return _webview;
}

- (UIProgressView *)progressView
{
    if (_progressView == nil) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.tintColor = [UIConfigManager colorThemeRed];
    }
    return _progressView;
}

@end
