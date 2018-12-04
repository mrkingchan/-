//
//  NNHDropDownMenu.m
//  ElegantLife
//
//  Created by 牛牛 on 16/9/24.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import "NNHDropDownMenu.h"

@interface NNHDropDownMenu ()

@property (nonatomic, weak) UIImageView *containerView;
@end

@implementation NNHDropDownMenu

// 懒加载一般用强指针，如果用weak，除非先添加[self addSubview:containerView]
- (UIImageView *)containerView
{
    if (!_containerView) {
        // 添加内容容器
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"pop_bg"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        _containerView = containerView;
    }
    return _containerView;
}

+ (instancetype)menu
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)showFrom:(UIView *)from
{
    // 获得最上面的窗口
    UIWindow *window = [UIView currentWindow];
    
    // 添加自己到窗口上
    [window addSubview:self];
    
    // 设置尺寸
    self.frame = window.bounds;
    
    // 调整灰色背景的位置  默认情况下from的位置是以父控件的左上角为原点
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    self.containerView.nnh_y = CGRectGetMaxY(newFrame);
    self.containerView.nnh_centerX = CGRectGetMaxX(newFrame) - 51;
}

- (void)dismiss
{
    [self removeFromSuperview];
}

- (void)setContent:(UIView *)content
{
    _content = content;
    
    // 调整内容的位置
    content.nnh_x = 0;
    content.nnh_y = 10;
    
    // 设置灰色的高度
    self.containerView.nnh_height = CGRectGetMaxY(content.frame);
    // 设置灰色的宽度
    self.containerView.nnh_width = CGRectGetMaxX(content.frame);
    
    // 添加内容到灰色图片中
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}

@end
