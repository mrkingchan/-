//
//  NNHMallGoodsDetailHeaderView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsDetailHeaderView.h"
#import "NNHCycleScrollView.h"
#import "NNHMallGoodsDetailModel.h"


/** 展示类型 */
typedef NS_ENUM(NSUInteger, NNHGoodsInfoShowType) {
    NNHGoodsInfoShowType_video = 0,        // 视频
    NNHGoodsInfoShowType_picture = 1,      // 图片
};

@interface NNHMallGoodsDetailHeaderView ()<SDCycleScrollViewDelegate>
/** 头部内容view */
@property (nonatomic, strong) UIView *contentView;
/** 轮播控件 */
@property (nonatomic, strong) NNHCycleScrollView *cycleScrollView;
/** 商品信息view */
@property (nonatomic, strong) UIView *infoView;
/** 商品标题 */
@property (nonatomic, strong) UILabel *goodsTitleLabel;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;
/** 关注人数 */
@property (nonatomic, strong) UILabel *followCountLabel;
/** 显示分页label */
@property (nonatomic, strong) UILabel *pageLabel;
/** 轮播图片数组 */
@property (nonatomic, strong) NSArray *imageArray;
/** 视频按钮 */
@property (nonatomic, strong) UIButton *videoButton;
/** 图片按钮 */
@property (nonatomic, strong) UIButton *imageButton;
/** 选中按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation NNHMallGoodsDetailHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self setupChildView];
        
    }
    return self;
}

- (void)setupChildView
{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(SCREEN_WIDTH));
    }];
    
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self addSubview:self.infoView];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.left.right.bottom.equalTo(self);
    }];
    
    [self.infoView addSubview:self.goodsTitleLabel];
    [self.infoView addSubview:self.goodsPriceLabel];
    [self.infoView addSubview:self.followCountLabel];
    
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.top.equalTo(self.infoView).offset(NNHMargin_20);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.infoView).offset(NNHNormalViewH);
        make.right.equalTo(self.infoView).offset(-NNHNormalViewH);
        make.top.equalTo(self.goodsPriceLabel.mas_bottom).offset(NNHMargin_15);
    }];

    [self.followCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.infoView);
        make.top.equalTo(self.goodsTitleLabel.mas_bottom).offset(NNHMargin_15);
        make.bottom.equalTo(self.infoView).offset(-NNHMargin_20);
        
    }];
    
    [self.contentView addSubview:self.pageLabel];
    [self.pageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-NNHMargin_20);
        make.bottom.equalTo(self.contentView).offset(-NNHMargin_15);
    }];
    
    [self.contentView addSubview:self.videoButton];
    [self.contentView addSubview:self.imageButton];
    [self.videoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-NNHMargin_20);
        make.right.equalTo(self.contentView.mas_centerX).offset(-NNHMargin_5);
    }];
    [self.imageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-NNHMargin_20);
        make.left.equalTo(self.contentView.mas_centerX).offset(NNHMargin_5);
    }];
    
}

- (void)setGoodsModel:(NNHMallGoodsDetailModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    self.imageArray = [goodsModel.bannerimg valueForKeyPath:@"productpic"];
    self.cycleScrollView.imageURLStringsGroup = self.imageArray;
    
    self.goodsTitleLabel.text = goodsModel.productname;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",goodsModel.prouctprice];
    self.followCountLabel.text = [NSString stringWithFormat:@"%@人关注",goodsModel.follow_num];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_goodsTitleLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_goodsTitleLabel.text length])];
    _goodsTitleLabel.attributedText = attributedString;
    
    [self.goodsPriceLabel nnh_addAttringTextWithText:goodsModel.prouctprice font:[UIFont boldSystemFontOfSize:22] color:[UIConfigManager colorThemeRed]];
    
    if (self.imageArray.count > 1) {
        self.pageLabel.hidden = NO;
        [self cycleScrollView:self.cycleScrollView didScrollToIndex:0];
    }else {
        self.pageLabel.hidden = YES;
    }
    
    [self changeShowStatsAction:self.imageButton];
}

#pragma mark -
#pragma mark --------- SDCycleScrollViewDelegate
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index
{
    self.pageLabel.text = [NSString stringWithFormat:@"%ld / %ld",index + 1, self.imageArray.count];
    NSString *attrString = [NSString stringWithFormat:@"/ %ld", self.imageArray.count];
    [self.pageLabel nnh_addAttringTextWithText:attrString font:[UIFont systemFontOfSize:11] color:[UIColor akext_colorWithHex:@"#000000"]];
}

- (void)changeShowStatsAction:(UIButton *)button
{
    if (!button.selected) {
        self.selectedButton.selected = NO;
        button.selected = YES;
        self.selectedButton = button;
    }
    
    self.pageLabel.hidden = button.tag == NNHGoodsInfoShowType_video;
}

#pragma mark -
#pragma mark ---------Getter && Setter

- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (NNHCycleScrollView *)cycleScrollView
{
    if (_cycleScrollView == nil) {
        _cycleScrollView = [NNHCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:ImageName(@"ic_placeholder_image")];
        _cycleScrollView.showPageControl = NO;
    }
    return _cycleScrollView;
}

- (UIView *)infoView
{
    if (_infoView == nil) {
        _infoView = [[UIView alloc] init];
        _infoView.backgroundColor = [UIConfigManager colorThemeWhite];
        
    }
    return _infoView;
}

- (UILabel *)goodsTitleLabel
{
    if (_goodsTitleLabel == nil) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.text = @"";
        _goodsTitleLabel.font = [UIConfigManager fontThemeTextDefault];
        _goodsTitleLabel.textColor = [UIColor akext_colorWithHex:@"#000000"];
    }
    return _goodsTitleLabel;
}

- (UILabel *)followCountLabel
{
    if (_followCountLabel == nil) {
        _followCountLabel = [[UILabel alloc] init];
        _followCountLabel.font = [UIFont systemFontOfSize:12];
        _followCountLabel.textColor = [UIConfigManager colorTextLightGray];
        _followCountLabel.text = @"";
    }
    return _followCountLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:13];
        _goodsPriceLabel.textColor = [UIConfigManager colorThemeRed];
        _goodsPriceLabel.text = @"";
        _goodsPriceLabel.contentMode = UIViewContentModeCenter;
    }
    return _goodsPriceLabel;
}

- (UILabel *)pageLabel
{
    if (_pageLabel == nil) {
        _pageLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#0000"] font:[UIConfigManager fontThemeTextImportant]];
    }
    return _pageLabel;
}

- (UIButton *)videoButton
{
    if (_videoButton == nil) {
        _videoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _videoButton.adjustsImageWhenHighlighted = NO;
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"tag_video_normal"] forState:UIControlStateNormal];
        [_videoButton setBackgroundImage:[UIImage imageNamed:@"tag_video_pressed"] forState:UIControlStateSelected];
        [_videoButton addTarget:self action:@selector(changeShowStatsAction:) forControlEvents:UIControlEventTouchUpInside];
        _videoButton.tag = NNHGoodsInfoShowType_video;
    }
    return _videoButton;
}

- (UIButton *)imageButton
{
    if (_imageButton == nil) {
        _imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageButton.adjustsImageWhenHighlighted = NO;
        [_imageButton setBackgroundImage:[UIImage imageNamed:@"tag_pic_normal"] forState:UIControlStateNormal];
        [_imageButton setBackgroundImage:[UIImage imageNamed:@"tag_pic_pressed"] forState:UIControlStateSelected];
        [_imageButton addTarget:self action:@selector(changeShowStatsAction:) forControlEvents:UIControlEventTouchUpInside];
        _imageButton.tag = NNHGoodsInfoShowType_picture;
    }
    return _imageButton;
}



@end
