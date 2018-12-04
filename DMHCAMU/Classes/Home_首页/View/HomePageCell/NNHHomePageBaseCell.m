//
//  NNHHomePageBaseCell.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageBaseCell.h"
#import "NNHHomePageBaseModel.h"

@implementation NNHHomePageBaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupChildView];
    }
    return self;
}


/** 设置子控件 */
- (void)setupChildView
{
    NNHLog(@"没有设置子控件");
}

- (void)setBaseModel:(NNHHomePageBaseModel *)baseModel
{
    _baseModel = baseModel;
}

@end
