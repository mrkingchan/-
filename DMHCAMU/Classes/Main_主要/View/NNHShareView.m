//
//  NNHShareView.m
//  ElegantLife
//
//  Created by 牛牛 on 16/5/6.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import "NNHShareView.h"
#import "NNHShareHelper.h"

@interface NNHShareView ()

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *sperateLine;
@property (nonatomic, strong) UIView *contentView;

@end

static CGFloat const shareItemMargin = 25;
static CGFloat const shareItemW = 60;
static CGFloat const shareItemH = 120;
static CGFloat const shareLabelH = 20;
static CGFloat const shareCloseButtonH = 44;
static CGFloat const contentviewH = 204;
@implementation NNHShareView

+ (instancetype)shareView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0/255. green:0/255. blue:0/255. alpha:0.5];
        [self setupChildView];
        
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    }
    return self;
}

- (void)setupChildView
{
    CGFloat contentW = self.bounds.size.width;
    
    NSMutableArray *shareTypes = [NSMutableArray array];
    if ([[NNHShareHelper sharedInstance] isInstalledWeChat]) {
        [shareTypes addObject:@(NNHShareWeiXin)];
        [shareTypes addObject:@(NNHShareWeiXinFriend)];
    }
    if ([[NNHShareHelper sharedInstance] isInstalledQQ]) {
        [shareTypes addObject:@(NNHShareQQ)];
//        [shareTypes addObject:@(NNHShareQQSpace)];
    }
//    [shareTypes addObject:@(NNHShareSMS)];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(shareTypes.count * shareItemW + (shareTypes.count + 1) * shareItemMargin, 0);
    
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:scrollView];
    [self.contentView addSubview:self.sperateLine];
    [self.contentView addSubview:self.closeButton];
    
    self.contentView.frame = CGRectMake(0, self.bounds.size.height, contentW, contentviewH);
    self.titleLabel.frame = CGRectMake(0, 20, contentW, shareLabelH);
    scrollView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), contentW, shareItemH);
    self.sperateLine.frame = CGRectMake(0, CGRectGetMaxY(scrollView.frame), contentW, 0.5);
    self.closeButton.frame = CGRectMake(0, CGRectGetMaxY(self.sperateLine.frame), contentW, shareCloseButtonH);
    
    NSString *buttonTitle = @"";
    NSString *buttonImage = @"";
    NSInteger buttonIndex = 0;
    for (NSInteger i = 0; i < shareTypes.count; i++) {
        NSInteger type = [shareTypes[i] integerValue];
        switch (type) {
            case NNHShareQQ:
                buttonTitle = @"QQ好友";
                buttonImage = @"ic_share_QQ";
                buttonIndex = NNHShareQQ;
                break;
            case NNHShareQQSpace:
                buttonTitle = @"QQ空间";
                buttonImage = @"ic_share_Qzone";
                buttonIndex = NNHShareQQSpace;
                break;
            case NNHShareWeiXin:
                buttonTitle = @"微信好友";
                buttonImage = @"ic_share_wechat";
                buttonIndex = NNHShareWeiXin;
                break;
            case NNHShareWeiXinFriend:
                buttonTitle = @"朋友圈";
                buttonImage = @"ic_share_friend_circle";
                buttonIndex = NNHShareWeiXinFriend;
                break;
            case NNHShareSMS:
                buttonTitle = @"短信";
                buttonImage = @"ic_share_message";
                buttonIndex = NNHShareSMS;
                break;
        }
        
        UIButton *btn = [self buttonWithTitle:buttonTitle image:buttonImage buttonIndex:buttonIndex];
        btn.nnh_x = shareItemMargin + (shareItemW + shareItemMargin) *i;
        btn.nnh_y = 0;
        btn.nnh_width = shareItemW;
        btn.nnh_height = shareItemH;
        [scrollView addSubview:btn];
    }
}

- (void)chooseShare:(UIButton *)button
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareView:didSelectedShareType:)]) {
        [self.delegate shareView:self didSelectedShareType:button.tag];
    }
    
    // 关闭分享界面
    [self hide];
}

- (void)show
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT - contentviewH - (NNHBottomSafeHeight), self.contentView.frame.size.width, contentviewH);
    }];
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^(void){
        self.contentView.frame = CGRectMake(0, SCREEN_HEIGHT, self.contentView.frame.size.width, contentviewH);
    } completion:^(BOOL finished){
        [self removeFromSuperview];
    }];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitle:@"取消" forState:UIControlStateNormal];
        [_closeButton setTitleColor:[UIConfigManager colorThemeBlack] forState:UIControlStateNormal];
        [_closeButton.titleLabel setFont:[UIConfigManager fontThemeTextMain]];
        [_closeButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIConfigManager colorThemeBlack];
        _titleLabel.font = [UIConfigManager fontThemeTextMain];
        _titleLabel.text = @"分享至";
    }
    return _titleLabel;
}

- (UIView *)sperateLine
{
    if (!_sperateLine) {
        _sperateLine = [[UIView alloc] init];
        _sperateLine.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
    }
    return _sperateLine;
}

- (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image buttonIndex:(NSInteger)index
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = index;
    [btn setTitleColor:[UIConfigManager colorThemeDarkGray] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(chooseShare:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(70, -shareItemW, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-20, 0, 0, 0)];
    
    return btn;
}

@end
