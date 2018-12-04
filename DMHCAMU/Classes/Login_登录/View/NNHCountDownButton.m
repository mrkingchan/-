//
//  NNHCountDownButton.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHCountDownButton.h"


@interface NNHCountDownButton ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) UILabel *lbTitle;

/** 开始计时前显示title **/
@property (nonatomic, copy) NSString *titleBeforeCounting;
/** 第一次计时结束之后显示title **/
@property (nonatomic, copy) NSString *titleAfterCounting;
/** 数字之后跟着的titles **/
@property (nonatomic, copy) NSString *titleCoutingExceptSecs;

@property (nonatomic, copy) void(^blockClicked)(NNHCountDownButton *countBtn);

@property (nonatomic, strong) UIActivityIndicatorView *loadingView;

@end

@implementation NNHCountDownButton
{
    BOOL _isCounting;
}

- (void)dealloc
{
    NNHLog(@"countDownButtonRelease");
}

- (instancetype)initWithTotalTime:(NSUInteger)totalTime titleBefre:(NSString *)titleBefore titleConting:(NSString *)titleCounting titleAfterCounting:(NSString *)titleAfter clickAction:(void(^)(NNHCountDownButton *countBtn))clickAction
{
    if (self = [super init]) {
        
        _titleBeforeCounting = titleBefore;
        _titleCoutingExceptSecs = titleCounting;
        _titleAfterCounting = titleAfter;
        _totalSec = totalTime;
        _blockClicked = clickAction;
        
        // 背景色
        [self setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateNormal];
        // 不可点击状态
        [self setBackgroundColor:[UIConfigManager colorThemeWhite] forState:UIControlStateDisabled];
        
        // 点击获取验证码后的文字颜色
        _lbCountingColor = [UIConfigManager colorThemeRed];
        // 文字颜色
        _lbNormalColor = [UIConfigManager colorThemeRed];
        
        [self buildUI];
    }
    return self;
}

- (void)setBgNormalColor:(UIColor *)bgNormalColor
{
    _bgNormalColor = bgNormalColor;
    [self setBackgroundColor:bgNormalColor forState:UIControlStateNormal];
}

- (void)setBgCountingColor:(UIColor *)bgCountingColor
{
    _bgCountingColor = bgCountingColor;
    [self setBackgroundColor:bgCountingColor forState:UIControlStateDisabled];
}

- (void)setLbNormalColor:(UIColor *)lbNormalColor
{
    _lbNormalColor = lbNormalColor;
    self.lbTitle.textColor = lbNormalColor;
}

- (void)buildUI
{
    UILabel *lbtitle = [[UILabel alloc] init];
    lbtitle.backgroundColor = [UIColor clearColor];
    lbtitle.textAlignment = NSTextAlignmentCenter;
    lbtitle.textColor = _lbNormalColor;
    lbtitle.font = [UIConfigManager fontThemeTextTip];
    [self addSubview:lbtitle];
    self.lbTitle = lbtitle;
    
    _curSec = _totalSec;
    self.lbTitle.text = _titleBeforeCounting;
    
    [lbtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self addTarget:self action:@selector(actionClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionClicked:(NNHCountDownButton *)sender
{
    // 正在获取验证码
    if (_isCounting) return;
    
    if (_loadingView == nil) {
        [self addSubview:self.loadingView];
        [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@30);
            make.height.equalTo(@30);
        }];
    }
    [self.loadingView startAnimating];
    self.lbTitle.hidden = YES;
    if (self.blockClicked) {
        self.blockClicked(self);
    }
}

- (void)startCounting
{
    if (_isCounting) return;
    
    if (_loadingView) {
        [self.loadingView stopAnimating];
    }
    
    _lbTitle.hidden = NO;
    _isCounting = YES;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(actionOnTimer) userInfo:nil repeats:YES];
    [[NSRunLoop  currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
    
    self.backgroundColor = self.bgCountingColor;
    self.lbTitle.textColor = self.lbCountingColor;
    self.enabled = NO;
    
}

- (void)actionOnTimer
{
    _curSec--;
    if (_curSec == 0) {
        [self resetButton];
        return;
    }
    
    self.lbTitle.text = [NSString stringWithFormat:@"%lus",(unsigned long)_curSec];
}

- (void)resetButton
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (_loadingView) {
        [_loadingView stopAnimating];
        [_loadingView removeFromSuperview];
        _loadingView = nil;
    }
    
    _isCounting = NO;
    self.enabled = YES;
    _lbTitle.hidden = NO;
    _curSec = _totalSec;
    
    self.lbTitle.text = _titleAfterCounting;
    self.lbTitle.textColor = self.lbNormalColor;
    self.backgroundColor = self.bgNormalColor;
}

- (UIActivityIndicatorView *)loadingView
{
    if (_loadingView == nil) {
        _loadingView = [[UIActivityIndicatorView alloc] init];
        _loadingView.color = [UIConfigManager colorThemeRed];
        _loadingView.hidesWhenStopped = YES;
    }
    return _loadingView;
}

@end
