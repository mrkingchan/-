//
//  NNHMessageUser.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/4/19.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHMessageUser : NSObject

/** 用户id */
@property (nonatomic, copy) NSString *userid;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *portraitUri;

@end
