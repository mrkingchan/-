//
//  NNHMessageFactoryModel.m
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMessageFactoryModel.h"
#import "NSDictionary+NNHExtension.h"


@implementation NNHMessageFactoryModel

+ (CGFloat)tableViewCellWithMessage:(RCMessage *)messageModel cellType:(NNHMessageShowType)showType
{
    CGFloat cellHeight = 0;
    
    //系统消息 或者是 订单处理消息
    if (showType == NNHMessageShowType_System || showType == NNHMessageShowType_OrderHandle) {
        
        if ([messageModel.content isKindOfClass:[RCTextMessage class]]) {
            //文字消息
            RCTextMessage *textMessage = (RCTextMessage *)messageModel.content;
#warning 改了解码方法
            NSDictionary *orderDict = [textMessage.extra jsonValueDecoded];
            
            CGSize titleSize = [orderDict[@"title"] sizeWithFont:[UIConfigManager fontThemeTextImportant] maxW:(SCREEN_WIDTH - 50)];
            
            CGSize contentSize = [textMessage.content sizeWithFont:[UIConfigManager fontThemeTextDefault] maxW:(SCREEN_WIDTH - 50)];
            
            cellHeight =  50 + +NNHMargin_10 + titleSize.height + NNHMargin_10 + contentSize.height + NNHMargin_10;
            return cellHeight;
        }
    
        if ([messageModel.content isKindOfClass:[RCRichContentMessage class]]) {
            //图文消息
            RCRichContentMessage *richMessage = (RCRichContentMessage *)messageModel.content;
            CGSize titleSize = [richMessage.title sizeWithFont:[UIConfigManager fontThemeTextImportant] maxW:(SCREEN_WIDTH - 50)];
            cellHeight =  50 + +NNHMargin_10 + titleSize.height + NNHMargin_10 + 70 + NNHMargin_10;
            return cellHeight;
        }
    }else if (showType == NNHMessageShowType_Recharge){  //加油提现消息
        //文字消息
        if ([messageModel.content isKindOfClass:[RCTextMessage class]]) {
            
            RCTextMessage *textMessage = (RCTextMessage *)messageModel.content;
#warning 改了解码方法
            NSDictionary *orderDict = [textMessage.extra jsonValueDecoded];

            CGSize titleSize = [orderDict[@"title"] sizeWithFont:[UIConfigManager fontThemeTextImportant] maxW:(SCREEN_WIDTH - 50)];
            
            CGSize contentSize = [textMessage.content sizeWithFont:[UIConfigManager fontThemeTextDefault] maxW:(SCREEN_WIDTH - 50)];
            
            cellHeight =  50 + +NNHMargin_10 + titleSize.height + NNHMargin_20 + contentSize.height + NNHMargin_10;
            return cellHeight;
        }
    }else if (showType == NNHMessageShowType_Income){
        //充值提现消息
        if ([messageModel.content isKindOfClass:[RCTextMessage class]]) {
            //文字消息
            RCTextMessage *textMessage = (RCTextMessage *)messageModel.content;
            
            CGSize titleSize = [@"分润收益" sizeWithFont:[UIConfigManager fontThemeTextImportant] maxW:(SCREEN_WIDTH - 50)];
            
            CGSize contentSize = [textMessage.content sizeWithFont:[UIConfigManager fontThemeTextDefault] maxW:(SCREEN_WIDTH - 50)];
            
            cellHeight =  50 + +NNHMargin_10 + titleSize.height + NNHMargin_10 + contentSize.height + NNHMargin_10;
            return cellHeight;
        }
    }
    
    return cellHeight;
}

@end
