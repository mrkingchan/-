//
//  NNHGuideViewController.m
//  DMHCAMU
//
//  Created by 来旭磊 on 2017/6/26.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHGuideViewController.h"
#import "NNHTabBarController.h"

@interface NNHGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end


static NSInteger const UYACGuidePageCount = 2;
@implementation NNHGuideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化scrollView
    [self setScrollView];
    
}

- (void)setScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    // 添加图片
    CGFloat scrollW = scrollView.nnh_width;
    CGFloat scrollH = scrollView.nnh_height;
    for (int i = 0; i < UYACGuidePageCount; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.nnh_width = scrollW;
        imageV.nnh_height = scrollH;
        imageV.nnh_y = 0;
        imageV.nnh_x = i * scrollW;
        NSString *img = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"P%d",i + 1] ofType:@"png"];
        imageV.image = [UIImage imageWithContentsOfFile:img];
        [scrollView addSubview:imageV];
        
        // 如果是最后一个imageView，就往里面添加其他内容
        if (i == UYACGuidePageCount - 1) {
            [self setupLastImageView:imageV];
        }
    }
    
    // 设置0，表示这个方向不可以滚动
    scrollView.contentSize = CGSizeMake(UYACGuidePageCount * scrollView.nnh_width, 0);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 添加pageControl(注意：一个控件的父控件尺寸为0，子控件照样可以显示出来，只不过没点击效果)
//    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.numberOfPages = UYACGuidePageCount;
//    pageControl.nnh_centerX = scrollW * 0.5;
//    pageControl.nnh_centerY = scrollH - 50;
//    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
//    pageControl.currentPageIndicatorTintColor = [UIConfigManager colorThemeRed];
//    [self.view addSubview:pageControl];
//    self.pageControl = pageControl;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.nnh_width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

/**
 *  初始化最后一个imageView
 *
 *  @param imageView 最后一个imageView
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 开启交互功能
    imageView.userInteractionEnabled = YES;
    
    CGFloat btnW = 300;
    CGFloat btnH = 100;
    
    // 进入主页
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.nnh_centerX = SCREEN_WIDTH * 0.5 - btnW * 0.5;
    startBtn.nnh_centerY = SCREEN_HEIGHT - 100;
    startBtn.nnh_size = CGSizeMake(btnW, btnH);
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
}

- (void)startClick
{
    // 切换到HWTabBarController
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[NNHTabBarController alloc] init];
}

@end
