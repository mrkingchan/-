//
//  NNHAPIImageTool.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

typedef NS_ENUM(NSInteger,NNHPostImageType)
{
    NNHPostImageTypeImageDetail = 0,         /** 默认 */
    NNHPostImageTypeImageUser = 1,         /** 用户头像 */
};

@interface NNHAPIImageTool : NNHBaseRequest

- (instancetype)initWithServiceType:(NNHPostImageType)imageType;

@end
