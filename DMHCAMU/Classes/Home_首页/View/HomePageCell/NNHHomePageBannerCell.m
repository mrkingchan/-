//
//  NNHHomePageBannerCell.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomePageBannerCell.h"
#import "NNHCycleScrollView.h"
#import "NNHHomePageBannerModel.h"

@interface NNHHomePageBannerCell ()<SDCycleScrollViewDelegate>

/** 轮播控件 */
@property (nonatomic, strong) NNHCycleScrollView *cycleScrollView;

@end

@implementation NNHHomePageBannerCell


- (void)setupChildView
{
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 30));
        make.top.height.equalTo(self);
    }];
}

- (void)setBaseModel:(NNHHomePageBaseModel *)baseModel
{
    NNHHomePageBannerModel *bannerModel = (NNHHomePageBannerModel *)baseModel;
    
    NSMutableArray *array = [bannerModel.bannerArray mutableArrayValueForKey:@"bannerThumb"];
    self.cycleScrollView.imageURLStringsGroup = array;
}


#pragma mark -
#pragma mark ---------SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    if (self.didSelectedItemBlock) {
        self.didSelectedItemBlock(index);
    }
}

#pragma mark -
#pragma mark ---------Getter && Setter
- (NNHCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [NNHCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:ImageName(@"ic_placeholder_image")];
        _cycleScrollView.layer.cornerRadius = NNHMargin_5;
        _cycleScrollView.layer.masksToBounds = YES;
    }
    return _cycleScrollView;
}

@end
