//
//  NNHMyCollectionCell.h
//  ZTHYMall
//
//  Created by 牛牛汇 on 2017/5/20.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHMyCollectionModel;

@interface NNHMyCollectionCell : UITableViewCell

/** 收藏模型 */
@property (nonatomic, strong) NNHMyCollectionModel *collectionModel;

@end
