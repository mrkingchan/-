//
//  NNHUploadImageModel.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHUploadImageDetailModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *status;
/** <#注释#> */
@property (nonatomic, copy) NSString *AccessKeyId;
/** <#注释#> */
@property (nonatomic, copy) NSString *AccessKeySecret;
/** <#注释#> */
@property (nonatomic, copy) NSString *Expiration;
/** <#注释#> */
@property (nonatomic, copy) NSString *SecurityToken;
@end

@interface NNHUploadImageModel : NSObject

/** <#注释#> */
@property (nonatomic, copy) NSString *accessid;
/** <#注释#> */
@property (nonatomic, copy) NSString *host;
/** <#注释#> */
@property (nonatomic, copy) NSString *policy ;
/** <#注释#> */
@property (nonatomic, copy) NSString *signature;
/** <#注释#> */
@property (nonatomic, copy) NSString *expire;
/** <#注释#> */
@property (nonatomic, copy) NSString *dir;
/** <#注释#> */
@property (nonatomic, copy) NSString *success_action_status;
/** <#注释#> */
@property (nonatomic, copy) NSString *ImgServerName;
/** <#注释#> */
@property (nonatomic, copy) NSString *bucketName;

@end
