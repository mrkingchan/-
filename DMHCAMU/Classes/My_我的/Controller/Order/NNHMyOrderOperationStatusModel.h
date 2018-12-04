//
//  NNHMyOrderOperationStatusModel.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/7.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHMyOrderOperationStatusModel : NSObject

/** 1表示操作按钮2显示文字 */
@property (nonatomic, copy) NSString *act;
/** 按钮名 */
@property (nonatomic, copy) NSString *actname;
/** 按钮类型 */
@property (nonatomic, copy) NSString *acttype;

@end
