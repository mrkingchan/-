//
//  NNHPayMentHelper.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/21.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHPayMentHelper.h"
//#import "NNHAPIPaymentTool.h"
#import "NNHRequestError.h"
#import "NSDictionary+NNHExtension.h"
#import "APay.h"
#import "UIViewController+NNHExtension.h"

static NSString *Scheme = @"DMHCAMU";
@interface NNHPayMentHelper ()<APayDelegate>

@end

@implementation NNHPayMentHelper

static   NNHPayMentHelper *handle;
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [[NNHPayMentHelper alloc] init];
    });
    return handle;
}

- (instancetype)init
{
    self = [super init];
    if (self){
        
    }
    return self;
}


///** 开始支付 */
//- (void)startPayMentWithType:(NNHOrderPayType)payMentType andorderNum:(NSString *)orderNum payCode:(NSString *)paycode payType:(NNHPaymentContentType)paytContentType
//{
//    if (payMentType == NNHOrderPayTypeBalancePay) {
//        // 余额支付
//        [self balancePayWithPayCode:paycode orderNum:orderNum];
//    }else {
//        // 第三方支付
//        [self requestPayDataWithPayContentType:paytContentType orderNum:orderNum paymentType:payMentType];
//    }
//}
//
///** 余额支付 */
//- (void)balancePayWithPayCode:(NSString *)paycode orderNum:(NSString *)orderNum
//{
//    NNHAPIPaymentTool *paymentTool = [[NNHAPIPaymentTool alloc] initWithOrderNum:orderNum paypwd:paycode];
//    [paymentTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        [SVProgressHUD dismiss];
//        if (self.paySuccessBlock) {
//            self.paySuccessBlock();
//        }
//    } failBlock:^(NNHRequestError *error) {
//        [SVProgressHUD dismiss];
//        NSDictionary *data = [error.errorReason jsonValueDecoded];
//        if ([data[@"code"] isEqualToString:@"50000"] || [data[@"code"] isEqualToString:@"50002"]) {
//            if (self.payMissCodeBlock) {
//                self.payMissCodeBlock(data[@"code"]);
//            }
//        }else {
//            if (self.payFailedBlock) {
//                self.payFailedBlock();
//            }
//        }
//    } isCached:NO];
//}
//
///** 第三方支付 */
//- (void)requestPayDataWithPayContentType:(NNHPaymentContentType)paytContentType orderNum:(NSString *)orderNum paymentType:(NNHOrderPayType)paymentType
//{
//    NNHAPIPaymentTool *payMentTool = [[NNHAPIPaymentTool alloc] initWithType:paymentType andOrderNum:orderNum payContentType:paytContentType];
//
//    NNHWeakSelf(self)
//    [payMentTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        [SVProgressHUD dismiss];
//        NNHStrongSelf(self)
//        if (paymentType == NNHOrderPayTypeWeChatPay) {
//
//            [strongself startWeChatPayWithData:responseDic];
//
//        }else if (paymentType == NNHOrderPayTypeAliPay) {
//
//            [strongself startAliPayWithData:responseDic];
//
//        }else if (paymentType == NNHOrderPayTypeyopURL) {
//
//            [strongself yopUrlPayWithData:responseDic];
//
//        }else{
//
//            [strongself quickPayWithData:responseDic];
//        }
//    } failBlock:^(NNHRequestError *error) {
//        [SVProgressHUD dismiss];
//        if (self.payFailedBlock) {
//            self.payFailedBlock();
//        }
//    } isCached:NO];
//}
//
///** 微信支付 */
//- (void)startWeChatPayWithData:(NSDictionary *)responseDic
//{
//    if (responseDic[@"data"]) {
//        PayReq* req             = [[PayReq alloc] init];
//        NSDictionary *dict = responseDic[@"data"];
//        req.openID              = [dict objectForKey:@"appid"];
//        req.partnerId           = [dict objectForKey:@"partnerid"];
//        req.prepayId            = [dict objectForKey:@"prepayid"];
//        req.nonceStr            = [dict objectForKey:@"noncestr"];
//        req.timeStamp           = [[dict objectForKey:@"timestamp"]intValue];
//        req.package             = [dict objectForKey:@"package"];
//        req.sign                = [dict objectForKey:@"sign"];
//        [WXApi sendReq:req];
//    }else {
//        NNHLog(@"支付参数错误");
//    }
//}
//
///** 支付宝支付 */
//- (void)startAliPayWithData:(NSDictionary *)responseDic
//{
//    if (responseDic[@"data"][@"param"]) {
//        [[AlipaySDK defaultService] payOrder:responseDic[@"data"][@"param"] fromScheme:Scheme callback:^(NSDictionary *resultDic) {
//
//            [SVProgressHUD dismiss];
//            NSString *statusCode = resultDic[@"resultStatus"];
//            if (![NSString isEmptyString:statusCode] && [statusCode isEqualToString:@"9000"]) {//支付成功
//                if (self.paySuccessBlock) {
//                    self.paySuccessBlock();
//                }
//                [SVProgressHUD showMessage:@"支付成功"];
//            }else{ //用户取消或者其他未支付状况 不处理
//                if (self.payCancleBlock) {
//                    self.payCancleBlock();
//                }
//            }
//        }];
//    }else {
//        NNHLog(@"支付参数错误");
//    }
//}
//
///** 快捷支付 */
//- (void)quickPayWithData:(NSDictionary *)responseDic
//{
//    NSDictionary *dic = responseDic[@"data"][@"param"];
//    NSString *payCode = [dic jsonStringEncoded];
//
//    UIViewController *currentController = [UIViewController currentViewController];
//    [APay startPay:payCode viewController:currentController delegate:self mode:@"00"];
//}
//
///** 易宝H5支付 */
//- (void)yopUrlPayWithData:(NSDictionary *)responseDic
//{
////    NSString *params = responseDic[@"data"][@"param"];
////
////    NNHBlockViewController *webVC = [[NNHBlockViewController alloc] init];
////    webVC.url = params;
////    UIViewController *currentController = [UIViewController currentViewController];
////    [currentController.navigationController pushViewController:webVC animated:YES];
////
////    NNHWeakSelf(self)
////
////    webVC.payResultBlock = ^(NSString *result) {
////
////        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            if ([result isEqualToString:@"1"] && weakself.payFailedBlock) {
////                weakself.payFailedBlock();
////            }
////            if ([result isEqualToString:@"2"] && weakself.paySuccessBlock) {
////                weakself.paySuccessBlock();
////            }
////        });
////    };
//}
//
//#pragma mark ---------通联支付回调
//- (void)APayResult:(NSString *)result
//{
//    NSArray *parts = [result componentsSeparatedByString:@"="];
//    NSError *error;
//    NSData *data = [[parts lastObject] dataUsingEncoding:NSUTF8StringEncoding];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//    NSInteger payResult = [dic[@"payResult"] integerValue];
//    NSString *format_string = @"支付结果::支付%@";
//    if (payResult == APayResultSuccess) {
//        NSLog(format_string,@"成功");
//        if (self.paySuccessBlock) {
//            self.paySuccessBlock();
//        }
//    } else if (payResult == APayResultFail) {
//        NSLog(format_string,@"失败");
//        if (self.payFailedBlock) {
//            self.payFailedBlock();
//        }
//    } else if (payResult == APayResultCancel) {
//        NSLog(format_string,@"取消");
//        if (self.payCancleBlock) {
//            self.payCancleBlock();
//        }
//    }
//}
//
///** 微信支付回调 */
//-(void) onResp:(BaseResp*)resp
//{
//    if (resp.errCode == -2) { // 你取消支付了
//        [SVProgressHUD showMessage:@"您取消了支付~"];
//        if (self.payCancleBlock) {
//            self.payCancleBlock();
//        }
//    }else if (resp.errCode == -1) {
//        [SVProgressHUD showMessage:@"不好意思，支付失败了"];
//        if (self.payFailedBlock) {
//            self.payFailedBlock();
//        }
//    }else{
//        if (self.paySuccessBlock) {
//            self.paySuccessBlock();
//        }
//        [SVProgressHUD showMessage:@"支付成功"];
//    }
//}
//
///** 支付宝回调 */
//- (void)handleAliPayWithUrl:(NSURL *)url
//{
//
//    [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//        NSString *statusCode = resultDic[@"resultStatus"];
//
//        if (![NSString isEmptyString:statusCode] && [statusCode isEqualToString:@"9000"]) {//支付成功
//            if (self.paySuccessBlock) {
//                self.paySuccessBlock();
//            }
//        }else{ // 用户取消或者其他未支付状况 不处理
//            if (self.payCancleBlock) {
//                self.payCancleBlock();
//            }
//        }
//    }];
//}

@end
