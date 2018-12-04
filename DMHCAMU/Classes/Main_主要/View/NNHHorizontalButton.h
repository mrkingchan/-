//
//  ZPHorizontalButton.h
//  ElegantLife
//
//  Created by 牛牛 on 16/3/21.
//  Copyright © 2016年 NNH. All rights reserved.
//

/*****************************************************
 @Function          右➡️图片 左⬅️文字
 @Remarks           备注
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNHHorizontalButton : UIButton

- (instancetype)initWithTitle:(NSString *)title
                        image:(NSString *)image
                    titleFont:(UIFont *)font
                   titleColor:(UIColor *)color;

@end
