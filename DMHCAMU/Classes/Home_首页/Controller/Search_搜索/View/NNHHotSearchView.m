//
//  NNHHotSearchView.m
//  WBTMall
//
//  Created by 牛牛汇 on 2017/5/18.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHHotSearchView.h"

@interface NNHHotSearchView ()

/** 热门搜索label */
@property (nonatomic, strong) UILabel *searchTitleLabel;
/** <#注释#> */
@property (nonatomic, strong) UIButton *tempButton;

@end

@implementation NNHHotSearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.searchTitleLabel];
        [self.searchTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(NNHMargin_15);
            make.top.equalTo(self);
            make.height.equalTo(@(NNHNormalViewH));
        }];
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        self.hidden = YES;
    }
    return self;
}

- (UILabel *)searchTitleLabel
{
    if (_searchTitleLabel == nil) {
        _searchTitleLabel = [UILabel NNHWithTitle:@"热门搜索" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
    }
    return _searchTitleLabel;
}

- (void)setHotSearchArray:(NSMutableArray *)hotSearchArray
{
    _hotSearchArray = hotSearchArray;
    if (_hotSearchArray.count == 0) {
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 0);
        self.hidden = YES;
    }else {
        self.hidden = NO;
        
        // 创建足够的规格按钮
        while (self.subviews.count - 1 < hotSearchArray.count) {
            UIButton *button = [self createHotWordButton];
            
            [self addSubview:button];
        }
        // 排列规格按钮
        CGFloat btnX = NNHMargin_15;
        CGFloat maxW = SCREEN_WIDTH - btnX - btnX;
        CGFloat btnY = NNHNormalViewH;
        
        for (NSInteger i = 1; i < self.subviews.count; i++) {
            
            UIButton *btn = self.subviews[i];
            
            if (i > hotSearchArray.count) {
                btn.hidden = YES;
            }else{
                btn.hidden = NO;
                btn.tag = i - 1;
                NSString *hotword = hotSearchArray[i-1];
                CGFloat textW = [hotword sizeWithFont:[UIConfigManager fontThemeTextTip] maxW:maxW].width;
                if (btnX > (maxW - textW)){
                    btnX = NNHMargin_15;
                    btnY += (NNHMargin_25 + NNHMargin_15);
                }
                
                [btn setTitle:hotword forState:UIControlStateNormal];
                btn.nnh_x = btnX;
                btn.nnh_y = btnY;
                btn.nnh_width = textW + NNHMargin_20;
                btn.nnh_height = NNHMargin_25;
                [btn addTarget:self action:@selector(touchesButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.selected = NO;
                btnX += textW + NNHMargin_20 + NNHMargin_10;
            }
        }
        
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, [self hotViewHeightWithArray:hotSearchArray]);
        NNHLog(@"self.bounds = %@",NSStringFromCGRect(self.bounds));
    }
}

- (void)clearSubViewstatus
{
    for (NSInteger i = 1; i < self.subviews.count; i++) {
        UIButton *button = self.subviews[i];
        button.selected = NO;
        [self changeButtonLayerWithButton:button selected:NO];
    }
}


- (CGFloat)hotViewHeightWithArray:(NSArray *)array
{
    CGFloat cellMargin = 15;
    CGFloat buttonH = 25;
    CGFloat btnX = cellMargin;
    CGFloat maxW = SCREEN_WIDTH - btnX - btnX;
    // 规格小按钮的最大Y值
    CGFloat btnY =  + buttonH + cellMargin;
    
    for (NSInteger i = 0; i < array.count; i++) {
        NSString *text = array[i];
        CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, NNHMargin_25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIConfigManager fontThemeTextTip]} context:nil];
        CGFloat textW = rect.size.width;
        if (btnX > (maxW - textW)){
            btnX = 15;
            btnY += (25 + 15);
        }
        
        btnX += textW + NNHMargin_20 + NNHMargin_10;
    }
    btnY += (25 + 15);
    return btnY;
}

- (void)touchesButton:(UIButton *)button
{
    if (button != self.tempButton) {
        button.selected = YES;
        [self changeButtonLayerWithButton:button selected:YES];
        self.tempButton.selected = NO;
        [self changeButtonLayerWithButton:self.tempButton selected:NO];
        self.tempButton = button;
    }
    if (self.hotSearchWordClickBlock) {
        self.hotSearchWordClickBlock(button.tag, button.currentTitle);
    }
}

- (UIButton *)createHotWordButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIConfigManager colorThemeDark] forState:UIControlStateNormal];
    [button setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateSelected];
    button.titleLabel.font = [UIConfigManager fontThemeTextTip];
    button.layer.cornerRadius = NNHMargin_25 * 0.5;
    button.clipsToBounds = YES;
    button.layer.borderWidth = NNHLineH;
    button.layer.borderColor = [UIColor akext_colorWithHex:@"#c0c0c0"].CGColor;
    return button;
}

- (void)changeButtonLayerWithButton:(UIButton *)button selected:(BOOL)selected
{
    if (selected) {
        button.layer.borderColor = [UIConfigManager colorThemeRed].CGColor;
    }else {
        button.layer.borderColor = [UIColor akext_colorWithHex:@"#c0c0c0"].CGColor;
    }
}



@end
