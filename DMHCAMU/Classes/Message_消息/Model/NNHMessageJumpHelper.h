//
//  NNHMessageJumpHelper.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/19.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHMessageJumpHelper : NSObject

/** 根据businessID 开启新的会话 */
+ (void)startConversatonWithGoodsDetailController:(UIViewController *)controller businessID:(NSString *)businessID;

@end
