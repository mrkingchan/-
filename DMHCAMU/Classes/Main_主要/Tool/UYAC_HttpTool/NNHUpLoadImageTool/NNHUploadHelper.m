//
//  NNHUploadHelper.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/16.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHUploadHelper.h"
#import "NNHRequestError.h"
#import "NNHUploadImageModel.h"
#import "NNHUploadImageBaseApi.h"
#import "UIImage+NNHExtension.h"

@implementation NNHUploadHelper

+ (void)upLoadWithImage:(UIImage *)Image andImageType:(NNHPostImageType)imageType andSuccessBlock:(void (^)(NSString *upUrl,NSString *wholeUrl))sucBlock failedBlock:(void (^)(NNHRequestError *error))failBlock
{
    NNHAPIImageTool *params = [[NNHAPIImageTool alloc]initWithServiceType:(int)imageType];
    
    // 图片处理
    NNHUploadHelper *helper = [[NNHUploadHelper alloc] init];
    Image = [UIImage imageWithData:[helper resetSizeOfImageData:Image maxSize:300]];    
    
    // 保存图片
//    [helper  loadImageFinished:Image];
    
    [params nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        NNHUploadImageModel *model = [NNHUploadImageModel mj_objectWithKeyValues:responseDic[@"data"]];
        NNHUploadImageBaseApi *api = [[NNHUploadImageBaseApi alloc] initWithModel:model image:Image];
        
        [api image_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
            sucBlock([NSString stringWithFormat:@"%@",responseDic[@"UploadUrl"]],[NSString stringWithFormat:@"%@",responseDic[@"WholeUrl"]]);
        } failBlock:^(NNHRequestError *error){
            failBlock(error);
        }];
        
    } failBlock:^(NNHRequestError *error) {
        
    } isCached:NO];
}

- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NNHLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray complete:(void(^)(NSString *imageString))complete
{
    if (imageArray.count == 0) {
        complete(@"");
    }
    
    if (imageArray.count > 0) { // 获得全局的并发队列
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        __block NSString *multiImageStr = [[NSString alloc] init];
        for (NSInteger i = 0; i < imageArray.count; i++) {
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                
                // 取出当前图片
                UIImage *newImage = imageArray[i];
                
                // 上传图片
                [NNHUploadHelper upLoadWithImage:newImage andImageType:NNHPostImageTypeImageDetail andSuccessBlock:^(NSString *upUrl, NSString *wholeUrl) {
                    
                    multiImageStr = [NSString stringWithFormat:@"%@,%@",multiImageStr,upUrl];

                    dispatch_group_leave(group);
                    
                } failedBlock:^(NNHRequestError *error) {
                    dispatch_group_leave(group);
                }];
            });
        }
        
        dispatch_group_notify(group, queue, ^{
            if (multiImageStr.length > 1) {
                multiImageStr = [multiImageStr substringFromIndex:1];
            }
            if (complete) {
                complete(multiImageStr);
            }
        });
    }
}

+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray complete:(void(^)(NSString *imageString))complete failBlock:(void(^)(NNHRequestError *error))failBlock
{
    if (imageArray.count == 0) {
        complete(@"");
    }
    
    if (imageArray.count > 0){
        // 获得全局的并发队列
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        __block NSString *multiImageStr = [[NSString alloc] init];
        for (NSInteger i = 0; i < imageArray.count; i++) {
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                
                // 取出当前图片
                UIImage *newImage = imageArray[i];
                
                // 上传图片
                [NNHUploadHelper upLoadWithImage:newImage andImageType:NNHPostImageTypeImageDetail andSuccessBlock:^(NSString *upUrl, NSString *wholeUrl) {
                    
                    multiImageStr = [NSString stringWithFormat:@"%@,%@",multiImageStr,upUrl];
                    
                    dispatch_group_leave(group);
                    
                } failedBlock:^(NNHRequestError *error) {
                    if (failBlock) {
                        failBlock(error);
                    }
                }];
            });
        }
        
        dispatch_group_notify(group, queue, ^{
            if (multiImageStr.length > 1) {
                multiImageStr = [multiImageStr substringFromIndex:1];
            }
            if (complete) {
                complete(multiImageStr);
            }
        });
    }
}



+ (void)uploadImageArray:(NSArray <UIImage *>*)imageArray completeArray:(void(^)(NSArray *imageArray))completeArray
{
    if (imageArray.count == 0) {
        completeArray(@[]);
    }
    
    if (imageArray.count > 0) { // 获得全局的并发队列
        dispatch_group_t group = dispatch_group_create();
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        __block NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < imageArray.count; i++) {
            dispatch_group_enter(group);
            dispatch_group_async(group, queue, ^{
                
                // 取出当前图片
                UIImage *newImage = imageArray[i];
                
                // 上传图片
                [NNHUploadHelper upLoadWithImage:newImage andImageType:NNHPostImageTypeImageDetail andSuccessBlock:^(NSString *upUrl, NSString *wholeUrl) {
                    
                    [array addObject:wholeUrl];
                    
                    dispatch_group_leave(group);
                    
                } failedBlock:^(NNHRequestError *error) {
                    
                }];
            });
        }
        
        dispatch_group_notify(group, queue, ^{
            if (completeArray) {
                completeArray([array copy]);
            }
        });
    }
}


/**
 *  图片压缩
 */
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(source_image,1.0);
    NSUInteger sizeOrigin   = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    
    if (sizeOriginKB <= maxSize) {
        return finallImageData;
    }
    
    //先调整分辨率 http://www.pmcaff.com/article?id=2000000000007505
    CGSize defaultSize = CGSizeMake(1280, 1280);
    UIImage *newImage = [self newSizeImage:defaultSize image:source_image];
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    
    //保存压缩系数
    //    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    //    CGFloat avg   = 1.0/250;
    //    CGFloat value = avg;
    //    for (NSInteger i = 250; i >= 1; i--) {
    //        value = i*avg;
    //        if (value < 0.6) break;
    //        [compressionQualityArr addObject:@(value)];
    //    }
    
    /*
     调整大小
     说明：压缩系数数组@[@0.8,@0.7,@0.6,@0.55]
     */
    //思路：使用二分法搜索
    finallImageData = [self halfFuntion:@[@0.8,@0.7,@0.6,@0.55] image:newImage sourceData:finallImageData maxSize:maxSize];
    
    return finallImageData;
}

#pragma mark 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)source_image {
    
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = source_image.size.height / size.height;
    CGFloat tempWidth = source_image.size.width / size.width;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    
    for (NSInteger i = 0; i < arr.count; i++) { // 当最小压缩系数还是大于规定maxSize时 以最小系数上传
        finallImageData = UIImageJPEGRepresentation(image,[arr[i] floatValue]);
        NSUInteger sizeOriginKB = finallImageData.length / 1024;
        NNHLog(@"当前降到的质量：%ld -----当前系数：%.2f", (unsigned long)sizeOriginKB,[arr[i] floatValue]);
        if (sizeOriginKB < maxSize) {
            return finallImageData;
        }
    }
    
    return finallImageData;
    
    //    NSData *tempData = [NSData data];
    //    NSUInteger start = 0;
    //    NSUInteger end = arr.count - 1;
    //    NSUInteger index = 0;
    //
    //    NSUInteger difference = NSIntegerMax;
    //    while(start <= end) {
    //        index = start + (end - start)/2;
    //
    //        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
    //
    //        NSUInteger sizeOrigin = finallImageData.length;
    //        NSUInteger sizeOriginKB = sizeOrigin / 1024;
    //        NNHLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
    //        NNHLog(@"%lu----%lf", (unsigned long)index, [arr[index] floatValue]);
    //
    //        if (sizeOriginKB > maxSize) {
    //            start = index + 1;
    //        } else if (sizeOriginKB < maxSize) {
    //            if (maxSize-sizeOriginKB < difference) {
    //                difference = maxSize-sizeOriginKB;
    //                tempData = finallImageData;
    //            }
    //            end = index - 1;
    //        } else {
    //            break;
    //        }
    //    }
    //    return tempData;
    
}


@end
