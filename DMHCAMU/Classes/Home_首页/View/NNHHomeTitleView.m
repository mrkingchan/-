//
//  NNHHomeTitleView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomeTitleView.h"
#import "NNHSearchTextField.h"

@interface NNHHomeTitleView ()<UITextFieldDelegate>

/** 导航栏中间搜索textField */
@property (nonatomic, strong) NNHSearchTextField *searchField;
/** 返回按钮 */
@property (nonatomic, strong) UIButton *backButton;
@end

@implementation NNHHomeTitleView

#pragma mark -
#pragma mark ---------init

- (instancetype)init
{
    if (self = [super init]) {
        [self setupChildView];
    }
    return self;
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
    [self addSubview:self.searchField];
    [self.searchField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(NNHMargin_15);
        make.right.equalTo(self).offset(-NNHMargin_15);
        make.bottom.equalTo(self);
        make.height.equalTo(@(36));
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"首页" titleColor:[UIConfigManager colorThemeBlack] font:[UIFont systemFontOfSize:24]];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchField);
        make.bottom.equalTo(self.searchField.mas_top).offset(-NNHMargin_10);
    }];
}

- (void)setTextFieldGroundColor:(UIColor *)textFieldGroundColor
{
    _textFieldGroundColor = textFieldGroundColor;
    self.searchField.backgroundColor = textFieldGroundColor;
}

- (void)setKeywords:(NSString *)keywords
{
    _keywords = keywords;
    self.searchField.textField.text = keywords;
}

- (void)rightItemAction
{
    if (self.canInputText) {
        if (self.didClickSearchBlock) {
            self.didClickSearchBlock(self.searchField.textField.text);
        }
    }else {
        if (self.rightItemActionBlock) self.rightItemActionBlock();
    }
}

#pragma mark -
#pragma mark ---------UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.canInputText) {
        return YES;
    }
    if (self.didBeginEditSearchBlock) {
        self.didBeginEditSearchBlock();
        return NO;
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.didClickSearchBlock) {
        self.didClickSearchBlock(textField.text);
    }
    return YES;
}

#pragma mark -
#pragma mark ---------Getter && Setter
- (NNHSearchTextField *)searchField
{
    if (_searchField == nil) {
        _searchField = [[NNHSearchTextField alloc] init];
        _searchField.textField.delegate = self;
        _searchField.layer.cornerRadius = NNHMargin_5;
        _searchField.placeHoldString = @"搜索艺术品";
    }
    return _searchField;
}

@end
