//
//  NNHMyGroup.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/23.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHMyGroup.h"

@implementation NNHMyGroup
{
    CGFloat _sectionHeight;
}

+ (instancetype)group
{
    return [[self alloc] init];
}

- (CGFloat)sectionHeight
{
//    if (!_sectionHeight) {
//        // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
//        
//        // 计算每行最大item数
//        NSInteger count = self.maxCol ? self.maxCol : self.items.count;
//        
//        // 计算最大列数
//        NSInteger maxRow = self.items.count > 0 ? (self.items.count + count - 1) / count : 0.0;
//        
//        if (self.lineEable) {
//            self.lineWidth = 0.0;
//        }
//        
//        // 计算当前item的高度 (当当前屏幕宽度为320时 高度以375为标准计算)
//        // 当前item的宽度
//        CGFloat itemWidth = (SCREEN_WIDTH < 375 ? 375 : SCREEN_WIDTH - (count - 1) * self.lineWidth) / count;
//        CGFloat itemHeight = self.scale ? itemWidth * self.scale : itemWidth;
//        
//        _sectionHeight = maxRow * itemHeight;
//    }
    
    // 总页数 == (总个数 + 每页的最大数 - 1) / 每页最大数
    
    // 计算每行最大item数
    NSInteger count = self.maxCol ? self.maxCol : self.items.count;
    
    // 计算最大列数
    NSInteger maxRow = self.items.count > 0 ? (self.items.count + count - 1) / count : 0.0;
    
    if (self.lineEable) {
        self.lineWidth = 0.0;
    }
    
    // 计算当前item的高度 (当当前屏幕宽度为320时 高度以375为标准计算)
    // 当前item的宽度
    CGFloat itemWidth = (SCREEN_WIDTH < 375 ? 375 : SCREEN_WIDTH - (count - 1) * self.lineWidth) / count;
    CGFloat itemHeight = self.scale ? itemWidth * self.scale : itemWidth;
    
    _sectionHeight = maxRow * itemHeight;
    
    return _sectionHeight;
}

@end
