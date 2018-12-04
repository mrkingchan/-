//
//  NNHMallGoodsListSortView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/23.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsListSortView.h"


@interface NNHMallGoodsListSortView ()

/** 选中按钮 */
@property (nonatomic, weak) UIButton *selectedButton;

/** 判断价格排序是升序还是降序 默认降序 0降序1升序 **/
@property (nonatomic, assign) NSInteger  selectFlag;


@end

@implementation NNHMallGoodsListSortView

- (void)dealloc
{
    NNHLog(@"dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    NSArray *titles = @[@"最新", @"关注", @"价格"];
    CGFloat btnWidth = SCREEN_WIDTH / titles.count;
    for (int i=0; i<titles.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = [UIConfigManager fontThemeTextMain];
        [btn setTitleColor:[UIConfigManager colorThemeBlack] forState:UIControlStateNormal];
        [btn setTitleColor:[UIConfigManager colorThemeRed] forState:UIControlStateSelected];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sortBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 2) {
            [btn setImage:[UIImage imageNamed:@"ic_filtrate_default"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"ic_filtrate_down"] forState:UIControlStateSelected];
            
            CGRect rect = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, NNHNormalViewH) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIConfigManager fontThemeTextMain]} context:nil];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, rect.size.width + 20, 0, -20);
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 20);
        }
        
        
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, NNHNormalViewH);
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = i;
        btn.adjustsImageWhenHighlighted = NO;
        
        [self addSubview:btn];
        
    }
    
    UIView *lineView = [UIView lineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(NNHLineH));
    }];
}

- (void)sortBtnDidClicked:(UIButton *)button
{
    if (button != self.selectedButton) {
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
        
        if (button.tag == 2) {
            [self configPriceButtonStatusWithButton:button];
        }else {
            NSString *sortString = @"desc";

            if (self.didSelectedSortButtonBlock) {
                self.didSelectedSortButtonBlock(sortString, self.selectedButton.tag);
            }
        }
    }else {
        if (button.tag == 2) {
            [self configPriceButtonStatusWithButton:button];
        }
    }
}

- (void)configPriceButtonStatusWithButton:(UIButton *)button
{
    if (self.selectFlag != 0) {
        [button setImage:ImageName(@"ic_filtrate_up") forState:UIControlStateSelected];
        [button setImage:ImageName(@"ic_filtrate_default") forState:UIControlStateNormal];
        self.selectFlag = 0;
    }else {
        [button setImage:ImageName(@"ic_filtrate_down") forState:UIControlStateSelected];
        [button setImage:ImageName(@"ic_filtrate_default") forState:UIControlStateNormal];
        self.selectFlag = 1;
    }
    
    NSString *sortString = @"";
    if (self.selectFlag == 0) {
        sortString = @"asc";
    }else {
        sortString = @"desc";
    }
    
    if (self.didSelectedSortButtonBlock) {
        self.didSelectedSortButtonBlock(sortString, self.selectedButton.tag);
    }
}


@end
