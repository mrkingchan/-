//
//  NNHChooseImageHelper.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHChooseImageHelper.h"

@interface NNHChooseImageHelper ()
<
UIActionSheetDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate
>

/** 回调block */
@property (nonatomic, copy) void(^completeBlock)(UIImage *image);
@property (nonatomic, strong) UIViewController *viewController;
@end

@implementation NNHChooseImageHelper


/** 打开相机 */
- (void)showTakePhotoWithController:(UIViewController *)controller
                       andWithBlock:(void(^)(UIImage *image))block
{
    self.completeBlock = block;
    UIImagePickerController *imagePickr = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
        imagePickr.delegate = self;
        //设置拍照后的图片可被编辑
        imagePickr.allowsEditing = YES;
        imagePickr.sourceType = sourceType;
        [controller presentViewController:imagePickr animated:YES completion:nil];
    }else {
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}

/** 选择相册 */
- (void)showLocalPhotoWithController:(UIViewController *)controller
                        andWithBlock:(void(^)(UIImage *image))block
{
    self.completeBlock = block;
    UIImagePickerController *imagePickr = [[UIImagePickerController alloc] init];
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    imagePickr.delegate = self;
    //设置拍照后的图片可被编辑
    imagePickr.allowsEditing = YES;
    imagePickr.sourceType = sourceType;
    [controller presentViewController:imagePickr animated:YES completion:nil];
}




//- (instancetype)init
//{
//    if (self = [super init]) {
//        
//    }
//    return self;
//}
//
//- (void)selectImageFromViewController:(UIViewController *)controller complete:(void(^)(UIImage *))complete
//{
//    self.completeBlock = complete;
//    self.viewController = controller;
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图像" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
//        UIAlertAction *takeAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            NNHLog(@"拍照");
//            [self createPhotoView];
//        }];
//        [alertController addAction:takeAction];
//    }
//    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        NNHLog(@"从相册选择");
//        [self fromPhotos];
//    }];
//    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        NNHLog(@"取消");
//    }];
//    
//    [alertController addAction:pictureAction];
//    [alertController addAction:cancleAction];
//    
//    [controller presentViewController:alertController animated:YES completion:nil];
//}
//
//#pragma mark - (相机和从相册中选择)
//- (void)fromPhotos {
//    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
//    imagePC.sourceType                = UIImagePickerControllerSourceTypePhotoLibrary;
//    imagePC.delegate                  = self;
//    imagePC.allowsEditing             = YES;
//    [self.viewController presentViewController:imagePC
//                                        animated:YES
//                                      completion:^{
//                                      }];
//}
//
//- (void)createPhotoView {
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
//        imagePC.sourceType                = UIImagePickerControllerSourceTypeCamera;
//        imagePC.delegate                  = self;
//        imagePC.allowsEditing             = YES;
//        [self.viewController presentViewController:imagePC
//                                            animated:YES
//                                          completion:^{
//                                          }];
//    }else {
//        [SVProgressHUD showMessage:@"该设备没有照相机"];
//    }
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    UIImage *newImage = [editingInfo objectForKey:UIImagePickerControllerOriginalImage];
//    self.completeBlock(newImage);
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(nonnull NSDictionary<NSString *,id> *)info
//{
//    [picker dismissViewControllerAnimated:YES completion:^{
//        
//    }];
//    
//    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    self.completeBlock(image);
//}






@end
