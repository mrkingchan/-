//
//  NNHFlowLabel.h
//  NNHPlatform
//
//  Created by 来旭磊 on 17/3/13.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           上下自动滚动的label 通知label
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>

@interface NNHFlowLabel : UIView

@property (nonatomic, copy) NSString *defaultText;

@property (nonatomic, copy) NSArray *notiStrings;

- (void)setNotiStrings:(NSArray *)notiStrings withStartIndex:(NSInteger) index;

@property (nonatomic, assign) NSInteger curIndex;

@property (nonatomic, copy) void(^blockTap)(NNHFlowLabel *view, NSInteger curIndex);

/** Showing Label **/
@property (nonatomic, readonly,strong) UILabel *theLabel;

- (void)reset;

@end
