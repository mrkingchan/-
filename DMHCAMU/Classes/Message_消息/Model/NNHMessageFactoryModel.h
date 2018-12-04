//
//  NNHMessageFactoryModel.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RongIMKit/RongIMKit.h>

typedef NS_ENUM(NSInteger, NNHMessageShowType){
    NNHMessageShowType_System = 0,              // 系统消息
    NNHMessageShowType_OrderHandle = 1,         // 订单处理消息
    NNHMessageShowType_Recharge = 2,            //加油提现消息
    NNHMessageShowType_Income = 3,              //分润收益消息
};


@interface NNHMessageFactoryModel : NSObject


/**
 根据消息模型计算显示消息cell的的高度

 @param messageModel 消息模型
 @param showType 显示消息类型
 @return cell高度
 */
+ (CGFloat)tableViewCellWithMessage:(RCMessage *)messageModel cellType:(NNHMessageShowType)showType;

@end
