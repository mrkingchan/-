//
//  NNHGoodsModel.h
//  ZTHYMall
//
//  Created by 牛牛 on 2017/3/6.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NNHShareModel : NSObject

/** 分享标题 */
@property (nonatomic, copy) NSString *share_title;
/** 分享内容 */
@property (nonatomic, copy) NSString *share_content;
/** 分享内容 */
@property (nonatomic, copy) NSString *share_image;
/** 分享URL */
@property (nonatomic, copy) NSString *share_url;

@end
