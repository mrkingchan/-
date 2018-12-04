//
//  NNHChooseImageHelper.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           从系统相册选择图片工具类
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

@interface NNHChooseImageHelper : NSObject

///** 选择单张图片 */
//- (void)selectImageFromViewController:(UIViewController *)controller complete:(void(^)(UIImage *))complete;


/** 打开相机 */
- (void)showTakePhotoWithController:(UIViewController *)controller
                       andWithBlock:(void(^)(UIImage *image))block;

/** 选择相册 */
- (void)showLocalPhotoWithController:(UIViewController *)controller
                        andWithBlock:(void(^)(UIImage *image))block;
@end
