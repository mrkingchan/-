//
//  NNHMyOrder.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/1.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMyOrder.h"

@implementation NNHMyOrderStatusModel


@end


@implementation NNHMyOrderAdressModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"receive_user" : @"realname",
             @"receive_mobile" : @"mobile"
             };
}

- (NSString *)receive_address
{
    return [NSString stringWithFormat:@"%@%@",_city,_address];
}

@end



@implementation NNHMyOrder
{
    CGFloat _headerViewHeight;
    CGFloat _sectionFooterViewHeight;
    CGFloat _receivingInformationViewH;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
                 @"ID" : @"id",
                 @"orderID" : @"order_id",
                 @"orderTime" : @"addtime",
                 @"orderStatus" : @"orderstatus",
                 @"orderGoods" : @"orderitem",
                 @"orderOperationButtons" : @"orderact",
                 @"adressModel" : @"receipt_address",
                 @"logisticsModel" : @"logistics",
                 @"businessServices" : @"business_tel",
                 @"orderStatusModel" : @"orderstatusstr"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"orderGoods" : @"NNHMyOrderItem", @"orderOperationButtons" : @"NNHMyOrderOperationStatusModel"};
}

- (NSString *)orderStatusText
{
    if ([self.orderStatus integerValue] == NNHOrderStatus_notSend){
        return @"商家未发货";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_notReceiving){
        return @"商家已发货";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_notPaying){
        return @"待付款";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_sureReceiving){
        return @"确认收货";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_completion){
        return @"交易成功";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_cancel){
        return @"交易关闭";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_refundInAudit){
        return @"退款审核中";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_refundIn){
        return @"退款中";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_refundAuditFailure){
        return @"退款审核失败";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_refundSuccess){
        return @"退款成功";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_returnOfAudit){
        return @"退货/退款审核中";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_returnOfGoods){
        return @"退货/退款中";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_returnAuditFailure){
        return @"退货/退款审核失败";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_returnSuccess){
        return @"退货/退款成功";
    }else if ([self.orderStatus integerValue] == NNHOrderStatus_cancelRefund){
        return @"用户取消退货/退款";
    }else{
        return @"";
    }
}

- (CGFloat)headerViewHeight
{
    if (!_headerViewHeight) {
        CGFloat promptViewH = NNHOrderDetailPromptViewH;
        CGFloat logisticsViewH = 60.00;
        if ([NSString isEmptyString:self.adressModel.express_no]) {
            _headerViewHeight = promptViewH + self.receivingInformationViewH + NNHMargin_10;
        }else{
            _headerViewHeight = promptViewH + logisticsViewH + NNHMargin_10 + self.receivingInformationViewH + NNHMargin_10;
        }
        if (self.nbtctitle.length != 0) {
            _headerViewHeight += 60 + NNHMargin_10;
        }
    }
    return _headerViewHeight;
}

- (CGFloat)receivingInformationViewH
{
    if (!_receivingInformationViewH) {
        if ([NSString isEmptyString:self.adressModel.idnumber]) {
            _receivingInformationViewH = NNHOrderDetailPromptViewH;
        }else{ // 多一个身份证号码显示
            _receivingInformationViewH = NNHOrderDetailPromptViewH + 40;
        }
    }
    return _receivingInformationViewH;
}

- (CGFloat)sectionFooterViewHeight
{
    if (!_sectionFooterViewHeight) {
        
        CGFloat amountInformationViewH = 102; // 商品基本信息高度
        CGFloat payViewH = 44.00; // 付款信息高度
        CGFloat serviceViewH = 44.00; // 电话
        CGFloat margin = 0.00;
        
        if ([self.orderStatus integerValue] == NNHOrderStatus_cancel) {
            payViewH = 0.00;
        }
        
        _sectionFooterViewHeight = amountInformationViewH + payViewH + serviceViewH + margin;
    }
    return _sectionFooterViewHeight;
}

@end

