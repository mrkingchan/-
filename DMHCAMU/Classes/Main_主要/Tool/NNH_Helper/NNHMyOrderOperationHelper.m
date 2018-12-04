//
//  NNHMyOrderOperationHelper.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/8.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrderOperationHelper.h"
//#import "NNHMyOrderViewController.h"
//#import "NNHMyOrderSuccessViewController.h"
//#import "NNHCheckLogisticsViewController.h"
//#import "NNHProductEvaluationViewController.h"
//#import "NNHApplyRefundInSaleController.h"
//#import "NNHMyOrderRefundDetailViewController.h"
//#import "NNHMyOrderRefundServiceViewController.h"
//#import "NNHMyOrderRefundSuccessDetailViewController.h"
//#import "NNHApplyRefundController.h"
//#import "NNHMyOrder.h"
//#import "NNHMyOrderItem.h"
//#import "NNHMyOrderRefundDetailModel.h"
//#import "NNHMyOrderOperationStatusModel.h"
//#import "NNHAlertTool.h"
//#import "NNHPickerVeiw.h"
//#import "NNHAPIMyOrderTool.h"
//#import "NNHAPIRefundTool.h"
//#import "NNHPayViewController.h"

@interface NNHMyOrderOperationHelper ()

//@property (nonatomic, strong) NSArray *cancelOrderReasons;
///** 取消原因 */
//@property (nonatomic, strong) NNHPickerVeiw *pickView;
///** 订单模型 */
//@property (nonatomic, strong) NNHMyOrder *myOrderModel;
///** 当前 */
//@property (nonatomic, strong) UIViewController *currentController;

@end

@implementation NNHMyOrderOperationHelper

//- (void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
//
//- (instancetype)init
//{
//    if (self = [super init]) {
//
//    }
//    return self;
//}
//
//- (void)jumpWithOrderModel:(NNHMyOrder *)orderModel
//      operationStatusModel:(NNHMyOrderOperationStatusModel *)operationStatusModel
//            viewController:(UIViewController *)vc
//{
//    self.myOrderModel = orderModel;
//    self.currentController = vc;
//    NSInteger status = [operationStatusModel.acttype integerValue];
//    switch (status) {
//        case NNHOrderOperationStatus_cancelOrder: // 取消订单
//            [self cancelOrder:vc];
//            break;
//        case NNHOrderOperationStatus_pay: // 付款
//            [self payOrderController:vc];
//            break;
//        case NNHOrderOperationStatus_notSend: // 提醒发货
//            [self remindDeliveryWithOperationStatusModel:operationStatusModel];
//            break;
//        case NNHOrderOperationStatus_refundApply: // 申请退款
//            [self refundApply:vc];
//            break;
//        case NNHOrderOperationStatus_cancelRefund: // 取消退款(无效)
//            
//            break;
//        case NNHOrderOperationStatus_extendReceiving: // 延长收货
//            [self extendReceivingWithOperationStatusModel:operationStatusModel viewController:vc];
//            break;
//        case NNHOrderOperationStatus_logistics: // 查看物流
//            [self orderLogistics:vc];
//            break;
//        case NNHOrderOperationStatus_sureReceiving: // 确认收货
//            [self sureReceiving:vc];
//            break;
//        case NNHOrderOperationStatus_comments: // 评价
//            [self orderComments:vc];
//            break;
//        case NNHOrderOperationStatus_afterSales: // 售后
//            [self productSales:vc];
//            break;
//        case NNHOrderOperationStatus_deleteOrder: // 删除订单
//            [self deleteOrder:vc];
//            break;
//        case NNHOrderOperationStatus_refund_cancel: // 退款详情-取消退款
//            [self cancelRefund:vc];
//            break;
//        case NNHOrderOperationStatus_refund_changeApply: // 退款详情-修改申请
//            [self changeRefundApply:vc];
//            break;
//        case NNHOrderOperationStatus_refund_cancelApply: // 退款详情-撤销申请
//            [self cancelRefund:vc];
//            break;
//        case NNHOrderOperationStatus_refunding: // 订单详情-退款中
//            [self productRefunding:vc];
//            break;
//        case NNHOrderOperationStatus_refundSuccess: // 订单详情-已退款
//            [self productRefunded:vc];
//            break;
//        case NNHOrderOperationStatus_refundDetailSubmitLogistics: // 订单详情-已退款
//            [self refundDetailSubmitLogistics];
//            break;
//    }
//}
//
//- (void)cancelOrder:(UIViewController *)vc
//{
//    [self.pickView showWithAnimation:YES fatherView:vc.navigationController.view];
//}
//
//- (void)payOrderController:(UIViewController *)vc
//{
//    NNHPayViewController *payVc = [[NNHPayViewController alloc] initWithOrderNum:self.myOrderModel.orderno priceAmount:self.myOrderModel.totalamount bullAmount:self.myOrderModel.bullamount payContentType:NNHPaymentContentType_Normal];
//    [vc.navigationController pushViewController:payVc animated:YES];
//    NNHWeakSelf(self)
//    NNHWeakSelf(vc)
//    payVc.canclePayBlock = ^(BOOL hasCreateOrder){
//        [weakvc.navigationController popViewControllerAnimated:YES];
//    };
//    payVc.failedPayBlock = ^(){
//        [weakvc.navigationController popViewControllerAnimated:YES];
//    };
//    payVc.successPayBlock = ^(){
//        NNHStrongSelf(self)
//        if (strongself.reloadDataSourceBlock) {
//            strongself.reloadDataSourceBlock();
//        }
//        [weakvc.navigationController popViewControllerAnimated:YES];
//    };
//}
//
//- (void)cancelRefund:(UIViewController *)vc
//{
//    NNHWeakSelf(self)
//    [[NNHAlertTool shareAlertTool] showAlertView:vc title:@"取消退款申请，本次退款将关闭，确定继续吗？" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
//        NNHStrongSelf(self)
//        NNHAPIRefundTool *refundTool = [[NNHAPIRefundTool alloc] initCancleRefundWithOrdernum:strongself.myOrderModel.orderno productid:strongself.orderItemModel.orderItemID skuid:strongself.orderItemModel.orderItemSpecID];
//        [refundTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//            [vc.navigationController popViewControllerAnimated:YES];
//        } failBlock:^(NNHRequestError *error) {
//            
//        } isCached:NO];
//    } cancle:^{
//        
//    }];
//}
//
//- (void)remindDeliveryWithOperationStatusModel:(NNHMyOrderOperationStatusModel *)operationStatusModel
//{
//    NNHWeakSelf(self)
//    NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initWithRemindShoppingOrderNumber:self.myOrderModel.orderno];
//    [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        [SVProgressHUD showMessage:@"提醒卖家发货成功"];
//        if (weakself.reloadOperationStatusBlock) {
//            weakself.reloadOperationStatusBlock();
//        }
//    } failBlock:^(NNHRequestError *error) {
//        
//    } isCached:NO];
//}
//
///** 申请售中退款 */
//- (void)refundApply:(UIViewController *)vc
//{
//    NNHApplyRefundInSaleController *applyRefundInSaleVC = [[NNHApplyRefundInSaleController alloc] initWithOrderNum:self.myOrderModel.orderno franking:self.myOrderModel.actualfreight OrderItem:self.orderItemModel ];
//    NNHWeakSelf(self)
//    applyRefundInSaleVC.successSubmitOrderBlock = ^(){
//        NNHStrongSelf(self)
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [strongself productRefunding:strongself.currentController];
//        });
//    };
//    [vc.navigationController pushViewController:applyRefundInSaleVC animated:YES];
//}
//
//- (void)changeRefundApply:(UIViewController *)vc
//{
//    if ([self.myOrderModel.orderStatus integerValue] == NNHOrderStatus_notSend) {
//        [self refundApply:vc];
//    }else if ([self.myOrderModel.orderStatus integerValue] == NNHOrderStatus_notReceiving){
//        NNHApplyRefundController *applyRefundVC = [[NNHApplyRefundController alloc] initWithOrderNum:self.myOrderModel.orderno refundType:NNHApplyRefundTypeChargeBack orderItem:self.orderItemModel];
//        [vc.navigationController pushViewController:applyRefundVC animated:YES];
//    }
//}
//
//- (void)extendReceivingWithOperationStatusModel:(NNHMyOrderOperationStatusModel *)operationStatusModel viewController:(UIViewController *)vc
//{
//    NNHWeakSelf(self)
//    [[NNHAlertTool shareAlertTool] showAlertView:vc title:@"确定延长收货时间？" message:@"每笔订单只能延迟一次哦" cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
//        NNHStrongSelf(self)
//        NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initWithExtendedReceiptOrderNumber:strongself.myOrderModel.orderno];
//        [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) { // 手动改变按钮状态
//            operationStatusModel.act = @"2";
//            if (strongself.reloadOperationStatusBlock) {
//                strongself.reloadOperationStatusBlock();
//            }
//        } failBlock:^(NNHRequestError *error) {
//            
//        } isCached:NO];
//    } cancle:^{
//        
//    }];
//}
//
//- (void)deleteOrder:(UIViewController *)vc
//{
//    NNHWeakSelf(self)
//    [[NNHAlertTool shareAlertTool] showAlertView:vc title:@"确定删除订单？" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
//        NNHStrongSelf(self)
//        NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initWithDeleteOrderNumber:strongself.myOrderModel.orderno];
//        [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//            if (strongself.delegateOrderBlock) strongself.delegateOrderBlock();
//        } failBlock:^(NNHRequestError *error) {
//            
//        } isCached:NO];
//    } cancle:^{
//        
//    }];
//}
//
//- (void)sureReceiving:(UIViewController *)vc
//{
//    NNHWeakSelf(self)
//    [[NNHAlertTool shareAlertTool] showAlertView:vc title:@"请收到货后，再确认收货！\n否则您可能钱货两空！" message:nil cancelButtonTitle:@"取消" otherButtonTitle:@"确定" confirm:^{
//        NNHStrongSelf(self)
//        NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initWithSureReceivingOrderNumber:strongself.myOrderModel.orderno];
//        [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//            NNHMyOrderSuccessViewController *orderSuccess = [[NNHMyOrderSuccessViewController alloc] initWithOrderNo:strongself.myOrderModel.orderno];
//            [vc.navigationController pushViewController:orderSuccess animated:YES];
//        } failBlock:^(NNHRequestError *error) {
//            
//        } isCached:NO];
//    } cancle:^{
//        
//    }];
//}
//
//- (void)productSales:(UIViewController *)vc
//{
//    NNHMyOrderRefundServiceViewController *orderRefundServiceVC = [[NNHMyOrderRefundServiceViewController alloc] init];
//    orderRefundServiceVC.myOrderItemModel = self.orderItemModel;
//    orderRefundServiceVC.orderNum = self.myOrderModel.orderno;
//    [vc.navigationController pushViewController:orderRefundServiceVC animated:YES];
//}
//
//- (void)orderLogistics:(UIViewController *)vc
//{
//    NSString *imageStr = self.myOrderModel.orderGoods.count > 0 ? self.myOrderModel.orderGoods[0].orderItemIcon : @"";
//    NNHCheckLogisticsViewController *logisticsSuccess = [[NNHCheckLogisticsViewController alloc] initWithExpressNumber:self.myOrderModel.adressModel.express_no expressCompany:self.myOrderModel.adressModel.express_name productImage:imageStr];
//    [vc.navigationController pushViewController:logisticsSuccess animated:YES];
//}
//
//- (void)orderComments:(UIViewController *)vc
//{
//    NNHProductEvaluationViewController *evaluationVC = [[NNHProductEvaluationViewController alloc] init];
//    evaluationVC.businessName = self.myOrderModel.businessname;
//    evaluationVC.storeID = self.myOrderModel.businessid;
//    evaluationVC.orderno = self.myOrderModel.orderno;
//    evaluationVC.orderItemModel = self.orderItemModel;
//    [vc.navigationController pushViewController:evaluationVC animated:YES];
//}
//
//- (void)productRefunding:(UIViewController *)vc
//{
//    if ([vc isKindOfClass:[NNHMyOrderRefundDetailViewController class]]) { //避免退款详情页进入售中退款，成功后再次进退款详情页
//        NNHMyOrderRefundDetailViewController *refundVc = (NNHMyOrderRefundDetailViewController *)vc;
//        [refundVc updateRefundData];
//    }else {
//        NNHMyOrderRefundDetailViewController *orderRefundDetailVC = [[NNHMyOrderRefundDetailViewController alloc] initWithOrderNum:self.myOrderModel.orderno orderItemModel:self.orderItemModel];
//        [vc.navigationController pushViewController:orderRefundDetailVC animated:YES];
//    }
//}
//
//- (void)productRefunded:(UIViewController *)vc
//{
//    NNHMyOrderRefundSuccessDetailViewController *orderRefundSuccessDetailVC = [[NNHMyOrderRefundSuccessDetailViewController alloc] initWithDetailVcOrderno:self.myOrderModel.orderno productid:self.orderItemModel.orderItemID skuid:self.orderItemModel.orderItemSpecID title:nil];
//    [vc.navigationController pushViewController:orderRefundSuccessDetailVC animated:YES];
//}
//
//- (void)refundDetailSubmitLogistics
//{
//    if ([NSString isEmptyString:self.refundDetailModel.express_name]) {
//        [SVProgressHUD showMessage:@"物流公司不能为空"];
//        return;
//    }
//    if ([NSString isEmptyString:self.refundDetailModel.express_no]) {
//        [SVProgressHUD showMessage:@"物流单号不能为空"];
//        return;
//    }
//    NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initSubmitRefundLogisticsWithOrderID:self.refundDetailModel.returnid expressCompany:self.refundDetailModel.express_name expressNo:self.refundDetailModel.express_no];
//    NNHWeakSelf(self)
//    [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        if (weakself.reloadDataSourceBlock) weakself.reloadDataSourceBlock();
//    } failBlock:^(NNHRequestError *error) {
//        
//    } isCached:NO];
//}
//
//- (NSArray *)cancelOrderReasons
//{
//    if (_cancelOrderReasons == nil) {
//        _cancelOrderReasons = @[@"我不想买了",@"信息填写错误，重新拍",@"卖家缺货",@"同城见面交易",@"其他原因"];
//    }
//    return _cancelOrderReasons;
//}
//
//- (NNHPickerVeiw *)pickView
//{
//    if (_pickView == nil) {
//        _pickView = [[NNHPickerVeiw alloc]init];
//        NNHWeakSelf(self);
//        _pickView.numberOfComponents = ^NSUInteger{
//            return 1;
//        };
//        _pickView.numberOfRows = ^NSUInteger (NSInteger Components){
//            return weakself.cancelOrderReasons.count;
//        };
//        _pickView.widthForComponent = ^CGFloat ((NSInteger Component)){
//            return  SCREEN_WIDTH;
//        };
//        _pickView.viewForRowAndComponent = ^ UIView *(NSInteger Component,NSInteger Row,UIView *resuseView){
//            NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:weakself.cancelOrderReasons[Row]
//                                                                               attributes:@{NSForegroundColorAttributeName:[UIConfigManager colorThemeDark],NSFontAttributeName:[UIConfigManager fontThemeTextMain]
//                                      }];
//            UILabel *label;
//            if (resuseView == nil) {
//                label = [[UILabel alloc]init];
//                label.attributedText = attributeStr;
//                label.textAlignment = NSTextAlignmentCenter;
//            }else{
//                label.attributedText = attributeStr;
//            }
//            return label;
//        };
//        
//        _pickView.didSelectedRowAndComponent = ^(NSInteger Component,NSInteger Row){
//            NNHStrongSelf(self)
//            NNHAPIMyOrderTool *myOrderTool = [[NNHAPIMyOrderTool alloc] initWithCancelOrderNumber:strongself.myOrderModel.orderno cancelReasons:strongself.cancelOrderReasons[Row]];
//            [myOrderTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//                if (strongself.reloadDataSourceBlock) strongself.reloadDataSourceBlock();
//            } failBlock:^(NNHRequestError *error) {
//                
//            } isCached:NO];
//        };
//    }
//    return _pickView;
//}



@end
