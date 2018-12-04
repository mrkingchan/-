//
//  NNHScoreShowView.m
//  DMHCAMU
//
//  Created by 牛牛 on 2017/4/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHScoreShowView.h"

@interface NNHScoreShowView ()

@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, assign) CGFloat storeImageViewWH;

@end

CGFloat scoreTotal = 5;
@implementation NNHScoreShowView

- (instancetype)initWithStarsW:(CGFloat)starsW
{
    if (self = [super init]) {

        _storeImageViewWH = starsW;
        
        [self childView];
    }
    return self;
}

- (void)childView
{
    UIImageView *lastView;
    for (NSInteger i = 0; i < scoreTotal; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:ImageName(@"ic_star_grey")];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(i*(_storeImageViewWH + 5));
            make.height.mas_equalTo(self.storeImageViewWH);
            make.width.mas_equalTo(self.storeImageViewWH);
        }];
        
        if (i == scoreTotal - 1) lastView = imageView;
    }
    
    [self addSubview:self.scoreLabel];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(lastView.mas_right).offset(10);
    }];
}

- (void)setScore:(CGFloat)score
{
    _score = score;
    
    // 处理特殊情况
    if (score <= 0) score = 5.0;
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%.1f分",score];
    
    //满星的个数
    NSInteger fullStars = score;
    
    BOOL halfStar = (score - fullStars > 0) ? YES : NO;
    
    for(NSInteger i = 0; i < scoreTotal; i++) {
        UIImageView *imageView = [self.subviews objectAtIndex:i];
        if(i < fullStars) {
            imageView.image = [UIImage imageNamed:@"ic_star_red"];
        }else if(halfStar == YES && i == fullStars) {
            imageView.image = [UIImage imageNamed:@"ic_star_half"];
        }else{
            imageView.image = [UIImage imageNamed:@"ic_star_grey"];
        }
    }
}

- (UILabel *)scoreLabel
{
    if (_scoreLabel == nil) {
        _scoreLabel = [UILabel NNHWithTitle:@"5.0分" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextDefault]];
    }
    return _scoreLabel;
}

@end
