//
//  NNHAPIImageTool.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAPIImageTool.h"

@implementation NNHAPIImageTool

- (instancetype)initWithServiceType:(NNHPostImageType)imageType
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"sys.upload.policy";
        self.reAPIName = @"上传图片策略";
    }
    return self;
}

@end
