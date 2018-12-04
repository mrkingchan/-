//
//  NNHVoiceSynthesisHelper.h
//  ZTHYMall
//
//  Created by 来旭磊 on 2017/7/14.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           科大讯飞语音帮助类
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <Foundation/Foundation.h>

@interface NNHVoiceSynthesisHelper : NSObject
NNHSingletonH

/** 文字转发音 */
- (void)speechText:(NSString *)text;

@end
