//
//  NNHTextField.m
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/26.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHTextField.h"

@interface NNHTextField ()

@end

@implementation NNHTextField

- (instancetype)init
{
    if (self = [super init]){
        self.backgroundColor = [UIColor whiteColor];
        self.textColor = [UIConfigManager colorThemeDark];
        self.font = [UIConfigManager fontThemeTextMain];
    }
    return self;
}

- (void)setPlaceholder:(NSString *)placeholder
{
    [super setPlaceholder:placeholder];
    UIColor *color = [UIConfigManager colorTextLightGray];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:color}];
}

//控制文本所在的的位置，左右缩 10
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 15 , 0 );
}

//控制编辑文本时所在的位置，左右缩 10
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset( bounds , 15 , 0 );
}

@end
