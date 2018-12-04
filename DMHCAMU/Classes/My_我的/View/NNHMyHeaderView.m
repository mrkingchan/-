//
//  NNHMyHeaderView.m
//  ElegantTrade
//
//  Created by 牛牛 on 16/10/23.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#import "NNHMyHeaderView.h"
#import "NNHMineModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+NNImagePosition.h"

@interface NNHMyHeaderView ()

/** 头像 */
@property (nonatomic, strong) UIImageView *iconView;
/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation NNHMyHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    // 资料
    UIButton *profileButton = [UIButton NNHBtnTitle:@"进入我的资料" titileFont:[UIConfigManager fontThemeTextDefault] backGround:[UIColor whiteColor] titleColor:[UIConfigManager colorTextLightGray]];
    [profileButton setImage:ImageName(@"common_icon_arrow") forState:UIControlStateNormal];
    [profileButton nn_setImagePosition:NNImagePositionRight spacing:10];
    [profileButton addTarget:self action:@selector(jumpMyProfile) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:profileButton];
    [profileButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-20);
        make.left.equalTo(self).offset(NNHMargin_15);
        make.width.equalTo(@100);
    }];
    
    // 昵称
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(profileButton.mas_top).offset(-20);
        make.left.equalTo(profileButton);
    }];

    // 头像
    CGFloat iconViewWH = 60;
    [self addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.top.equalTo(self.nameLabel);
        make.size.mas_equalTo(CGSizeMake(iconViewWH, iconViewWH));
    }];
}

- (void)setMineModel:(NNHMineModel *)mineModel
{
    _mineModel = mineModel;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:mineModel.userModel.headerpic] placeholderImage:ImageName(@"ic_user_default")];
    self.nameLabel.text = mineModel.userModel.nickname;
}

- (void)jumpMyProfile
{
    if (![[NNHProjectControlCenter sharedControlCenter] loginStatus:YES]) return;
    if (self.headerViewJumpBlock) self.headerViewJumpBlock(NNHMyHeaderViewJumpTypeMyProfile);
}

- (UIImageView *)iconView
{
    if (_iconView == nil) {
        _iconView = [[UIImageView alloc] init];
        _iconView.image = ImageName(@"ic_user_default");
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
        _iconView.userInteractionEnabled = YES;
        [_iconView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(jumpMyProfile)]];
        NNHViewBorderRadius(_iconView, 60 *0.5, 2.0, [UIColor whiteColor]);
    }
    return _iconView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIFont boldSystemFontOfSize:24]];
    }
    return _nameLabel;
}

@end
