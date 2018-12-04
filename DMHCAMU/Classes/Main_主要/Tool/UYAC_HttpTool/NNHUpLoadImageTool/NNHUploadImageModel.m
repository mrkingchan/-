//
//  NNHUploadImageModel.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHUploadImageModel.h"

@implementation NNHUploadImageDetailModel 

@end

@implementation NNHUploadImageModel

- (NSString *)bucketName
{
    if (_bucketName == nil) {
        _bucketName = @"bucketName";
    }
    return _bucketName;
}

@end
