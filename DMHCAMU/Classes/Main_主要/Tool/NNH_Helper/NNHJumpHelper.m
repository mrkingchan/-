//
//  NNHJumpHelper.m
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/4/13.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHJumpHelper.h"
//#import "NNHGoodsDetailViewController.h"
//#import "NNHPhysicalStoreDetailViewController.h"
//#import "NNHWebViewController.h"
//#import "NNHShopHomeController.h"
//#import "NNHMyOrderDetailViewController.h"
//#import "NNHMallCategoryViewController.h"
//#import "NNHStoreListController.h"
//#import "NNHStorePaymentController.h"
//#import "NNHMoneyWithdrawResultController.h"
//#import "NNHLoginViewController.h"
//#import "NNHPrefectureController.h"
//#import "NNHTakeOutCustomerOrderListHomeController.h"
//#import "NNHTakeOutBusinessOrderListHomeController.h"
//#import "NNHTakeOutCustomerOrderDetailController.h"
//#import "NNHTakeOutBusinessOrderDetailController.h"
//#import "NNHNSSaleManagementViewController.h"
//#import "NNHNSEvaluateManagerViewController.h"
//#import "NNHNSOrderStatisticsViewController.h"
//#import "NNHStoreDetailCategoryController.h"
//#import "NNHMallGoodsListController.h"
//
//#import "NNHStorePayCodeModel.h"
#import "NNHBannerModel.h"

@interface NNHJumpHelper ()

@end

@implementation NNHJumpHelper
NNHSingletonM

- (void)jumpToDifferenceViewControllerWithBannerModel:(NNHBannerModel *)model viewController:(UIViewController *)vc
{
//    switch ([model.bannerUrltype integerValue]) {
//        case NNHJumpType_Banner_GoodsDetail:        //1 商品详情
//        {
//            NNHGoodsDetailViewController *goodsVc = [[NNHGoodsDetailViewController alloc] init];
//            goodsVc.goodsID = model.bannerUrl;
//            [vc.navigationController pushViewController:goodsVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_ExternalUrl:        //2 外部H5连接
//        {
//            NNHWebViewController *webVc = [[NNHWebViewController alloc] init];
//            webVc.url = model.bannerUrl;
//            webVc.navTitle = model.bannerName;
//            [vc.navigationController pushViewController:webVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_StoreDetail:        //3 实体店详情
//        {
//            NNHPhysicalStoreDetailViewController *storeVc = [[NNHPhysicalStoreDetailViewController alloc] initWithStoreID:model.bannerUrl];
//            [vc.navigationController pushViewController:storeVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_BusinessDetail:       //4 实体店详情
//        {
//            NNHShopHomeController *shopVc = [[NNHShopHomeController alloc] initWithBusinessid:model.bannerUrl];
//            [vc.navigationController pushViewController:shopVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_GoodsOrderDeatil:        //5 订单详情（各种状态订单的详情页）
//        {
//            NNHMyOrderDetailViewController *orderDetailVc = [[NNHMyOrderDetailViewController alloc] init];
//            orderDetailVc.orderNumberString = model.bannerUrl;
//            [vc.navigationController pushViewController:orderDetailVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_GoodsCategory:        //6 商城分类页面
//        {
//            NNHMallCategoryViewController *categoryVc = [[NNHMallCategoryViewController alloc] init];
//            [vc.navigationController pushViewController:categoryVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_StoreList:        //7 实体店列表页面
//        {
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            NSString *cityID = [userDefaults objectForKey:NNH_User_CurrentLocation_cityID];
//            if (cityID) {
//                NNHStoreListController *shopVc = [[NNHStoreListController alloc] initWithCitycode:cityID keyword:nil categoryID:model.bannerUrl categoryName:nil];
//                [vc.navigationController pushViewController:shopVc animated:YES];
//            }
//        }
//            break;
//        case NNHJumpType_Banner_StorePayment:        //8 实体店优惠付款
//        {
//            NNHStorePayCodeModel *codeModel = [[NNHStorePayCodeModel alloc] init];
//            codeModel.business_code = model.bannerUrl;
//            codeModel.managerid = @"";
//            NNHStorePaymentController *shopVc = [[NNHStorePaymentController alloc] initWithPayCodeModel:codeModel];
//            [vc.navigationController pushViewController:shopVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_UserWithdrawDetail:        //10 提现详情
//        {
//            if (![[NNHProjectControlCenter sharedControlCenter] loginStatus:NO]) return;
//            
//            NNHMoneyWithdrawResultController *widthVc = [[NNHMoneyWithdrawResultController alloc] initWithdrawDetailData:model.bannerUrl];
//            [vc.navigationController pushViewController:widthVc animated:YES];
//        }
//            break;
//        case NNHJumpType_Banner_UserLoginRegister:        //11 登录注册
//        {
//            [NNHLoginViewController presentInViewController:[UIApplication sharedApplication].keyWindow.rootViewController withAniamtion:YES andCompletion:^{
//                
//            }];
//        }
//            break;
//            
//        case NNHJumpType_Banner_GoodsPrefectureMoney:        //12 商城专区 现金
//        {
//            NNHPrefectureController *prefectureVc = [[NNHPrefectureController alloc] initWithType:NNHPrefectureType_money];
//            [vc.navigationController pushViewController:prefectureVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_GoodsPrefectureAll:        //13 商城专区 现金+牛豆
//        {
//            NNHPrefectureController *prefectureVc = [[NNHPrefectureController alloc] initWithType:NNHPrefectureType_all];
//            [vc.navigationController pushViewController:prefectureVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_GoodsPrefectureBull:        //14 商城专区 牛豆
//        {
//            NNHPrefectureController *prefectureVc = [[NNHPrefectureController alloc] initWithType:NNHPrefectureType_bull];
//            [vc.navigationController pushViewController:prefectureVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_UserTakeOutOrder:        //15 用户外卖订单列表
//        {
//            NNHTakeOutCustomerOrderListHomeController *listVc = [[NNHTakeOutCustomerOrderListHomeController alloc] init];
//            [vc.navigationController pushViewController:listVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_UserTakeOutOrderDetail:        //16 外卖订单详情--用户实体店的各种状态订单的详情页
//        {
//            NNHTakeOutCustomerOrderDetailController *listVc = [[NNHTakeOutCustomerOrderDetailController alloc] initWithOrderNum:model.bannerUrl];
//            [vc.navigationController pushViewController:listVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_NZGTakeOutOrderList:           //17 实体店待接单列表
//        {
//            NNHTakeOutBusinessOrderListHomeController *listVc = [[NNHTakeOutBusinessOrderListHomeController alloc] init];
//            [vc.navigationController pushViewController:listVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_NZGRefundOrderDetail:        //18 实体店退款订单详情
//        {
//            NNHTakeOutBusinessOrderDetailController *listVc = [[NNHTakeOutBusinessOrderDetailController alloc] initWithOrderNum:model.bannerUrl];
//            [vc.navigationController pushViewController:listVc animated:YES];
//        }
//            break;
//         
//        case NNHJumpType_Banner_NSEvaluateManager:        //19 商家评价管理列表
//        {
//            NNHNSEvaluateManagerViewController *evaluateVc = [[NNHNSEvaluateManagerViewController alloc] init];
//            [vc.navigationController pushViewController:evaluateVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_NSWaitSendOrderList:        //20 商家待发货列表
//        {
//            NNHNSOrderStatisticsViewController *listVc = [[NNHNSOrderStatisticsViewController alloc] initWithNSOrderStatisticsStatus:NNHNSOrderStatisticsToobarStatus_notSend];
//            [vc.navigationController pushViewController:listVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_NSSaleOrderList:        //21 商家售后管理列表
//        {
//            NNHNSSaleManagementViewController *manageVc = [[NNHNSSaleManagementViewController alloc] init];
//            [vc.navigationController pushViewController:manageVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_StoreGoodsCategory:        //25 实体店店铺外卖商品列表
//        {
//            NNHStoreDetailCategoryController *storeVc = [[NNHStoreDetailCategoryController alloc] initWithStoreBusinessID:model.bannerUrl oneMoreGoodsArray:@[]];
//            [vc.navigationController pushViewController:storeVc animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_SecondGoodsCategory:
//        {
//            NNHMallGoodsListController *listVC = [[NNHMallGoodsListController alloc] initListVcWithkeywords:nil cid:model.bannerUrl prefeatureType:nil busniessID:nil];
//            listVC.navigationItem.title = model.bannerName;
//            [vc.navigationController pushViewController:listVC animated:YES];
//        }
//            break;
//            
//        case NNHJumpType_Banner_MallGoodsList:
//        {
//            NNHMallGoodsListController *listVC = [[NNHMallGoodsListController alloc] initListVcWithkeywords:model.bannerUrl cid:nil prefeatureType:nil busniessID:nil];
//            [vc.navigationController pushViewController:listVC animated:YES];
//        }
//
//        default:
//            break;
//    }
}

@end
