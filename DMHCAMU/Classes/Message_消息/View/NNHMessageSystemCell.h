//
//  NNHMessageSystemCell.h
//  WBTMall
//
//  Created by 来旭磊 on 2017/4/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

/*****************************************************
 
 @Author             来旭磊
 
 @CreateTime      TimeForever
 
 @ function           系统消息列表cell
 
 @Remarks          <#注释#>
 
 *****************************************************/

#import <UIKit/UIKit.h>
#import <RongIMKit/RongIMKit.h>

@interface NNHMessageSystemCell : UITableViewCell

/** 消息模型 */
@property (nonatomic, strong) RCMessage *rcMessageModel;

@end
