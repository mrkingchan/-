//
//  NNHSearchTextField.m
//  DMHCAMU
//
//  Created by leiliao lai on 17/3/2.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHSearchTextField.h"

@interface NNHSearchTextField ()

///** 输入框左边文字偏移的距离 默认10 **/
//@property (nonatomic, assign) CGFloat separationDistance;

/** <#注释#> */
@property (nonatomic, strong) UIImageView *iconImage;

/** <#注释#> */
@property (nonatomic, assign) NNHSearchTextFieldUIStyle style;

@end

@implementation NNHSearchTextField

- (instancetype)initWithFrame:(CGRect)frame placeHold:(NSString *)placeHold uiStyle:(NNHSearchTextFieldUIStyle)style
{
    if (self = [super init]) {
        [self setupChildView];
        self.frame = frame;
        self.textField.placeholder = placeHold;
        _style = style;
    }
    return self;
}

- (instancetype)initWithPlaceHold:(NSString *)placeHold uiStyle:(NNHSearchTextFieldUIStyle)style
{
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, [NNHUIConfigManager widthCompareWithStandardScreenWidth:240], 26);
        self.textField.placeholder = placeHold;
        _style = style;
        [self setupChildView];
    }
    return self;
}

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, [NNHUIConfigManager widthCompareWithStandardScreenWidth:240], 26)];
    if (self) {
        self.textField.placeholder = @"商品名称或分类";
        self.style = NNHSearchTextFieldUIStyle_Gray;
        [self setupChildView];
    }
    return self;
}

- (void)setRightView:(UIView *)rightView
{
    _rightView = rightView;
    self.textField.rightView = rightView;
    self.textField.rightViewMode = UITextFieldViewModeAlways;
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake([NNHUIConfigManager widthCompareWithStandardScreenWidth:320], 26);
}

- (void)setupChildView
{
    UIColor *color = [UIConfigManager colorThemeWhite];
    if (self.style == NNHSearchTextFieldUIStyle_White) {

    }else {
        color = [UIConfigManager colorThemeDarkGray];
    }
    if (self.textField.placeholder.length) {
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:color}];
        self.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
        if (SCREEN_WIDTH == 320.f) {
            [self.textField setValue:[UIConfigManager fontThemeTextTip] forKeyPath:@"_placeholderLabel.font"];
            
        }
    }


    self.layer.cornerRadius = self.nnh_height * 0.5;
    self.layer.masksToBounds = YES;

    [self addSubview:self.iconImage];
    
    CGFloat imageWH = NNHMargin_20;

    [self.iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self).offset(NNHMargin_5);
        make.size.mas_equalTo(CGSizeMake(imageWH, imageWH));
    }];

    [self addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(1);
        make.left.equalTo(self.iconImage.mas_right).offset(NNHMargin_5);
        make.right.equalTo(self);
    }];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)setPlaceHoldString:(NSString *)placeHoldString
{
    _placeHoldString = placeHoldString;
    self.textField.placeholder = placeHoldString;
    UIColor *color = [UIConfigManager colorThemeWhite];
    if (self.style == NNHSearchTextFieldUIStyle_White) {
        
    }else {
        color = [UIConfigManager colorThemeDarkGray];
    }
    if (self.textField.placeholder.length) {
        self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.textField.placeholder attributes:@{NSForegroundColorAttributeName:color}];
        self.backgroundColor = [UIConfigManager colorThemeSeperatorLightGray];
        if (SCREEN_WIDTH == 320.f) {
            [self.textField setValue:[UIConfigManager fontThemeTextTip] forKeyPath:@"_placeholderLabel.font"];
            
        }
    }
}

- (void)textFieldDidChangeText
{
    UITextRange *range = [self.textField markedTextRange];
    NSString *markStr = [self.textField textInRange:range];
    
    if (markStr.length > 0) {
        return;
    }
    if ([self.tfDelegate respondsToSelector:@selector(textFieldOfCurrentText:)]) {
        [self.tfDelegate textFieldOfCurrentText:self];
    }
}

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        [_textField setValue:[UIConfigManager fontThemeTextDefault] forKeyPath:@"_placeholderLabel.font"];
        [_textField setValue:[UIConfigManager colorThemeSeperatorDarkGray] forKeyPath:@"_placeholderLabel.textColor"];
        [_textField addTarget:self action:@selector(textFieldDidChangeText) forControlEvents:UIControlEventEditingChanged];
        _textField.textColor = [UIConfigManager colorThemeBlack];
        _textField.font = [UIConfigManager fontThemeTextDefault];
        _textField.returnKeyType = UIReturnKeySearch;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.spellCheckingType = UITextSpellCheckingTypeNo;
    }
    return _textField;
}

- (UIImageView *)iconImage
{
    if (_iconImage == nil) {
        _iconImage = [[UIImageView alloc] init];
        if (self.style == NNHSearchTextFieldUIStyle_White) {
            _iconImage.image = [UIImage imageNamed:@"ic_home_search"];
        }else {
            _iconImage.image = [UIImage imageNamed:@"ic_search_white_bg"];
        }
    }
    return _iconImage;
}



@end
