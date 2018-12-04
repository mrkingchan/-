//
//  NNHBannerModel.h
//  ZTHYMall
//
//  Created by leiliao lai on 17/3/10.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           所有banner的model
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

@interface NNHBannerModel : NSObject

/** 自增长ID */
@property (nonatomic, copy) NSString *bannerID;
/** banner名称 */
@property (nonatomic, copy) NSString *bannerName;
/** banner显示图片 */
@property (nonatomic, copy) NSString *bannerThumb;
/** banner跳转类型 */
@property (nonatomic, copy) NSString *bannerUrltype;
/** banner跳转参数 */
@property (nonatomic, copy) NSString *bannerUrl;
/** banner添加时间 */
@property (nonatomic, copy) NSString *bannerAddtime;
/** banner-Sort 暂时没用 */
@property (nonatomic, copy) NSString *bannerSort;

// 广告专用
/** 倒计时 */
@property (nonatomic, copy) NSString *time;
/** 广告展示方式 1 每次都启动  2 一天启动一次 */
@property (nonatomic, copy) NSString *banner_type;

@end
