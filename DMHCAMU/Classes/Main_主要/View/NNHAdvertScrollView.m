//
//  NNHAdvertScrollView.m
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/8/29.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHAdvertScrollView.h"

#pragma mark - 单行文字的cell

static NSInteger const advertScrollViewTitleFont = 13;

@interface NNHAdvertScrollViewOneCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *signImageView;

@property (nonatomic, strong) UILabel *messageLabel;

@end

@implementation NNHAdvertScrollViewOneCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.signImageView];
        [self.contentView addSubview:self.messageLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat spacing = 5;
    
    CGFloat signImageViewW = self.signImageView.image.size.width;
    CGFloat signImageViewH = self.signImageView.image.size.height;
    CGFloat signImageViewX = 0;
    CGFloat signImageViewY = 0;
    self.signImageView.frame = CGRectMake(signImageViewX, signImageViewY, signImageViewW, signImageViewH);
    
    CGFloat labelX = 0;
    if (self.signImageView.image == nil) {
        labelX = 0;
    } else {
        labelX = CGRectGetMaxX(self.signImageView.frame) + 0.5 * spacing;
    }
    CGFloat labelY = 0;
    CGFloat labelW = self.frame.size.width - labelX;
    CGFloat labelH = self.frame.size.height;
    self.messageLabel.frame = CGRectMake(labelX, labelY, labelW, labelH);
    
    CGPoint topPoint = self.signImageView.center;
    topPoint.y = _messageLabel.center.y;
    _signImageView.center = topPoint;
}

- (UIImageView *)signImageView {
    if (!_signImageView) {
        _signImageView = [[UIImageView alloc] init];
    }
    return _signImageView;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.textColor = [UIColor blackColor];
        _messageLabel.font = [UIFont systemFontOfSize:advertScrollViewTitleFont];
    }
    return _messageLabel;
}

@end

#pragma mark - 两行文字的cell

@interface SGAdvertScrollViewTwoCell : UICollectionViewCell

//@property (nonatomic, strong) UIImageView *topSignImageView;

@property (nonatomic, strong) UILabel *topLabel;

//@property (nonatomic, strong) UIImageView *bottomSignImageView;

@property (nonatomic, strong) UILabel *bottomLabel;

/** <#注释#> */
@property (nonatomic, strong) UIButton *topTipButton;

/** <#注释#> */
@property (nonatomic, strong) UIButton *bottomTipButton;
@end

@implementation SGAdvertScrollViewTwoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.topTipButton];
        [self.contentView addSubview:self.bottomTipButton];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat spacing = 5;
    
    CGFloat topTipButtonW = 30;
    CGFloat topTipButtonH = 15;
    CGFloat topTipButtonX = spacing;
    CGFloat topTipButtonY = spacing;
    self.topTipButton.frame = CGRectMake(topTipButtonX, topTipButtonY, topTipButtonW, topTipButtonH);
    
    CGFloat topLabelX = 0;
    if (self.topTipButton.titleLabel.text.length == 0) {
        topLabelX = 0;
    } else {
        topLabelX = CGRectGetMaxX(self.topTipButton.frame) + spacing;
    }
    CGFloat topLabelY = topTipButtonY;
    CGFloat topLabelW = self.frame.size.width - topLabelX;
    CGFloat topLabelH = 0.5 * (self.frame.size.height - 2 * topLabelY);
    self.topLabel.frame = CGRectMake(topLabelX, topLabelY, topLabelW, topLabelH);
    
    CGPoint topPoint = self.topTipButton.center;
    topPoint.y = _topLabel.center.y;
    self.topTipButton.center = topPoint;
    
    CGFloat bottomTipButtonW = 30;
    CGFloat bottomTipButtonH = 15;
    CGFloat bottomTipButtonX = spacing;
    CGFloat bottomTipButtonY = CGRectGetMaxY(self.topLabel.frame);
    self.bottomTipButton.frame = CGRectMake(bottomTipButtonX, bottomTipButtonY, bottomTipButtonW, bottomTipButtonH);
    
    CGFloat bottomLabelX = 0;
    if (self.bottomTipButton.titleLabel.text.length == 0) {
        bottomLabelX = 0;
    } else {
        bottomLabelX = CGRectGetMaxX(self.bottomTipButton.frame) + spacing;
    }
    CGFloat bottomLabelY = CGRectGetMaxY(self.topLabel.frame);
    CGFloat bottomLabelW = self.frame.size.width - bottomLabelX;
    CGFloat bottomLabelH = topLabelH;
    self.bottomLabel.frame = CGRectMake(bottomLabelX, bottomLabelY, bottomLabelW, bottomLabelH);
    
    CGPoint bottomPoint = self.bottomTipButton.center;
    bottomPoint.y = _bottomLabel.center.y;
    _bottomTipButton.center = bottomPoint;
    
}

//- (UIImageView *)topSignImageView {
//    if (!_topSignImageView) {
//        _topSignImageView = [[UIImageView alloc] init];
//    }
//    return _topSignImageView;
//}

- (UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.font = [UIFont systemFontOfSize:advertScrollViewTitleFont];
    }
    return _topLabel;
}

//- (UIImageView *)bottomSignImageView {
//    if (!_bottomSignImageView) {
//        _bottomSignImageView = [[UIImageView alloc] init];
//    }
//    return _bottomSignImageView;
//}

- (UILabel *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc] init];
        _bottomLabel.textColor = [UIColor blackColor];
        _bottomLabel.font = [UIFont systemFontOfSize:advertScrollViewTitleFont];
    }
    return _bottomLabel;
}

- (UIButton *)topTipButton
{
    if (_topTipButton == nil) {
        _topTipButton = [UIButton NNHBorderBtnTitle:@"" borderColor:[UIConfigManager colorThemeRed] titleColor:[UIConfigManager colorThemeWhite]];
        _topTipButton.userInteractionEnabled = NO;
        _topTipButton.titleLabel.font = [UIConfigManager fontThemeTextTip];
        _topTipButton.backgroundColor = [UIConfigManager colorThemeRed];
    }
    return _topTipButton;
}

- (UIButton *)bottomTipButton
{
    if (_bottomTipButton == nil) {
        _bottomTipButton = [UIButton NNHBorderBtnTitle:@"" borderColor:[UIConfigManager colorThemeRed] titleColor:[UIConfigManager colorThemeWhite]];
        _bottomTipButton.userInteractionEnabled = NO;
        _bottomTipButton.titleLabel.font = [UIConfigManager fontThemeTextTip];
        _bottomTipButton.backgroundColor = [UIConfigManager colorThemeRed];
    }
    return _bottomTipButton;
}




@end




@interface NNHAdvertScrollView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *imageArr;
@property (nonatomic, strong) NSArray *bottomImageArr;
@property (nonatomic, strong) NSArray *bottomTitleArr;

@end


@implementation NNHAdvertScrollView

static NSInteger const advertScrollViewMaxSections = 100;
static NSString *const advertScrollViewOneCell = @"SGAdvertScrollViewOneCell";
static NSString *const advertScrollViewTwoCell = @"SGAdvertScrollViewTwoCell";

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialization];
    [self setupSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initialization];
        [self setupSubviews];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self removeTimer];
    }
}

- (void)dealloc {
    _collectionView.delegate = nil;
    _collectionView.dataSource = nil;
}

- (void)initialization {
    _scrollTimeInterval = 3.0;
    
    [self addTimer];
    _advertScrollViewStyle = NNHAdvertScrollViewStyleNormal;
}

- (void)setupSubviews {
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    
    [self addSubview:self.collectionView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:_flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.scrollEnabled = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[NNHAdvertScrollViewOneCell class] forCellWithReuseIdentifier:advertScrollViewOneCell];
    }
    return _collectionView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _flowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    _collectionView.frame = self.bounds;
    
    if (self.titleArr.count > 1) {
        [self defaultSelectedScetion];
    }
}

- (void)defaultSelectedScetion {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0.5 * advertScrollViewMaxSections] atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
}

#pragma mark - - - UICollectionView 的 dataSource、delegate方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return advertScrollViewMaxSections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.advertScrollViewStyle == NNHAdvertScrollViewStyleMore) {
        SGAdvertScrollViewTwoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:advertScrollViewTwoCell forIndexPath:indexPath];
        NSString *topImagePath = self.imageArr[indexPath.item];
//        if ([topImagePath hasPrefix:@"http"]) {
//            [cell.topSignImageView sd_setImageWithURL:[NSURL URLWithString:topImagePath]];
//        } else {
//            cell.topSignImageView.image = [UIImage imageNamed:topImagePath];
//        }
        [cell.topTipButton setTitle:topImagePath forState:UIControlStateNormal];
        cell.topLabel.text = self.titleArr[indexPath.item];
        
        NSString *imagePath = self.bottomImageArr[indexPath.item];
        [cell.bottomTipButton setTitle:imagePath forState:UIControlStateNormal];
        cell.bottomLabel.text = self.bottomTitleArr[indexPath.item];
        
        if (self.titleFont) {
            cell.topLabel.font = self.titleFont;
            cell.bottomLabel.font = self.titleFont;
        }
        
        if (self.topTitleColor) {
            cell.topLabel.textColor = self.topTitleColor;
        }
        if (self.bottomTitleColor) {
            cell.bottomLabel.textColor = self.bottomTitleColor;
        }
        return cell;
        
    } else {
        NNHAdvertScrollViewOneCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:advertScrollViewOneCell forIndexPath:indexPath];
        NSString *imagePath = self.imageArr[indexPath.item];
        if ([imagePath hasPrefix:@"http"]) {
            [cell.signImageView sd_setImageWithURL:[NSURL URLWithString:imagePath]];
        } else {
            cell.signImageView.image = [UIImage imageNamed:imagePath];
        }
        
        cell.messageLabel.text = self.titleArr[indexPath.item];
        if (self.textAlignment) {
            cell.messageLabel.textAlignment = self.textAlignment;
        }
        if (self.titleFont) {
            cell.messageLabel.font = self.titleFont;
        }
        if (self.titleColor) {
            cell.messageLabel.textColor = self.titleColor;
        }
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(advertScrollView:didSelectedItemAtIndex:)]) {
        [self.delegate advertScrollView:self didSelectedItemAtIndex:indexPath.item];
    }
}

#pragma mark - - - NSTimer
- (void)addTimer {
    [self removeTimer];
    
    self.timer = [NSTimer timerWithTimeInterval:self.scrollTimeInterval target:self selector:@selector(beginUpdateUI) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer {
    [_timer invalidate];
    _timer = nil;
}

- (void)beginUpdateUI {
    if (self.titleArr.count == 0) return;
    
    // 1、当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    
    // 马上显示回最中间那组的数据
    NSIndexPath *resetCurrentIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:0.5 * advertScrollViewMaxSections];
    [self.collectionView scrollToItemAtIndexPath:resetCurrentIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:NO];
    
    // 2、计算出下一个需要展示的位置
    NSInteger nextItem = resetCurrentIndexPath.item + 1;
    NSInteger nextSection = resetCurrentIndexPath.section;
    if (nextItem == self.titleArr.count) {
        nextItem = 0;
        nextSection++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 3、通过动画滚动到下一个位置
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionBottom animated:YES];
}

#pragma mark - - - setting
- (void)setAdvertScrollViewStyle:(NNHAdvertScrollViewStyle)advertScrollViewStyle {
    _advertScrollViewStyle = advertScrollViewStyle;
    if (advertScrollViewStyle == NNHAdvertScrollViewStyleMore) {
        _advertScrollViewStyle = NNHAdvertScrollViewStyleMore;
        [_collectionView registerClass:[SGAdvertScrollViewTwoCell class] forCellWithReuseIdentifier:advertScrollViewTwoCell];
    }
}

- (void)setSignImages:(NSArray *)signImages {
    _signImages = signImages;
    if (signImages) {
        self.imageArr = [NSArray arrayWithArray:signImages];
    }
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (titles.count > 1) {
        [self addTimer];
    } else {
        [self removeTimer];
    }
    
    self.titleArr = [NSArray arrayWithArray:titles];
    [self.collectionView reloadData];
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    _textAlignment = textAlignment;
}

- (void)setTopSignImages:(NSArray *)topSignImages {
    _topSignImages = topSignImages;
    if (topSignImages) {
        self.imageArr = [NSArray arrayWithArray:topSignImages];
    }
}

- (void)setTopTitles:(NSArray *)topTitles {
    _topTitles = topTitles;
    if (topTitles.count > 1) {
        [self addTimer];
    } else {
        [self removeTimer];
    }
    
    self.titleArr = [NSArray arrayWithArray:topTitles];
    [self.collectionView reloadData];
}

- (void)setBottomSignImages:(NSArray *)bottomSignImages {
    _bottomSignImages = bottomSignImages;
    if (bottomSignImages) {
        self.bottomImageArr = [NSArray arrayWithArray:bottomSignImages];
    }
}

- (void)setBottomTitles:(NSArray *)bottomTitles {
    _bottomTitles = bottomTitles;
    if (bottomTitles) {
        self.bottomTitleArr = [NSArray arrayWithArray:bottomTitles];
    }
}

- (void)setScrollTimeInterval:(CFTimeInterval)scrollTimeInterval {
    _scrollTimeInterval = scrollTimeInterval;
    if (scrollTimeInterval) {
        [self addTimer];
    }
}


@end
