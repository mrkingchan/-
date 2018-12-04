//
//  NNCommonViewController.h
//  DMHCAMU
//
//  Created by 牛牛 on 2018/10/18.
//  Copyright © 2018年 牛牛. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyGroup;

@interface NNCommonViewController : UITableViewController

/** 数据源 */
@property (nonatomic, strong) NSMutableArray <NNHMyGroup *> *groups;

@end
