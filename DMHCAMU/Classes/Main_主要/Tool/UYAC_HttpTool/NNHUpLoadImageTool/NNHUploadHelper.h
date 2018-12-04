//
//  NNHUploadHelper.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           上传图片
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>
#import "NNHAPIImageTool.h"
@class NNHRequestError;



@interface NNHUploadHelper : NSObject

+ (void)upLoadWithImage:(UIImage *)Image andImageType:(NNHPostImageType)imageType andSuccessBlock:(void (^)(NSString *upUrl,NSString *wholeUrl))sucBlock failedBlock:(void (^)(NNHRequestError *error))failBlock;

/** 上传图片数组 */
+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray complete:(void(^)(NSString *imageString))complete;

/** 上传图片数组 带上传图片失败的回调 */
+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray complete:(void(^)(NSString *imageString))complete failBlock:(void(^)(NNHRequestError *error))failBlock;

/** 返回图片上传数组 */
+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray completeArray:(void(^)(NSArray *imageArray))completeArray;

/** 唯一标识 **/
@property (nonatomic,assign)NSUInteger indentifier;

@end
