//
//  NNHUploadImageBaseApi.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "YTKRequest.h"
@class NNHRequestError;
@class NNHUploadImageModel;

@interface NNHUploadImageBaseApi : YTKRequest

- (instancetype)initWithModel:(NNHUploadImageModel *)upLoadImageModel image:(UIImage *)image;
- (void)image_StartRequestWithSucBlock:(void(^)(NSDictionary *responseDic))sucBlock
                             failBlock:(void(^)(NNHRequestError *error))failBlock;

@end
