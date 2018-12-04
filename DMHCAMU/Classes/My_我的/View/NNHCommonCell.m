//
//  NNHCommonCell.m
//  ZTHYMall
//
//  Created by 牛牛 on 2017/2/28.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHCommonCell.h"
#import "NNHMyItem.h"
#import "NNHCountDownButton.h"

@interface NNHCommonCell () <UITextFieldDelegate>

/** icon */
@property (nonatomic, strong) UIImageView *iconImageView;
/** titleLabel */
@property (nonatomic, strong) UILabel *titleLabel;

/** ⚠️ detailLabel 与 textField只可以存在一个 */
@property (nonatomic, strong) UILabel *detailLabel;
/** textField */
@property (nonatomic, strong) UITextField *textField;

// 右边类型
/** 标签 */
@property (nonatomic, strong) UILabel *rightLabel;
/** 箭头 */
@property (nonatomic, strong) UIImageView *rightArrow;
/** 箭头➕文字 / 箭头➕图片 */
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIImageView *rightIconView;
@property (nonatomic, strong) UILabel *rightViewLabel;

@end

@implementation NNHCommonCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(NNHMargin_15);
    }];
    
    [self.contentView addSubview:self.detailLabel];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(NNHMargin_15);
    }];
    
    [self.contentView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 80));
    }];
}

- (void)setMyItem:(NNHMyItem *)myItem
{
    _myItem = myItem;
    
    // 设置基本数据
    if (myItem.icon) {
        self.iconImageView.hidden = NO;
        self.iconImageView.image = [UIImage imageNamed:myItem.icon];
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.iconImageView.mas_right).offset(NNHMargin_15);
        }];
    }else{
        self.iconImageView.hidden = YES;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(NNHMargin_15);
        }];
    }
    
    self.titleLabel.text = myItem.title;
    self.detailLabel.text = myItem.detailTitle;
    self.detailLabel.textColor = myItem.detailColor ? myItem.detailColor : [UIConfigManager colorThemeDarkGray];
    self.detailLabel.hidden = [NSString isEmptyString:myItem.detailTitle];
    
    // textfield相关数据
    if ([NSString isEmptyString:myItem.placeholder] && [NSString isEmptyString:myItem.currentTextFieldText]) {
        self.textField.hidden = YES;
    }else{
        self.textField.hidden = NO;
        self.textField.placeholder = myItem.placeholder;
        self.textField.text = myItem.currentTextFieldText;
        self.textField.keyboardType = myItem.currentKeyboardType;
        // 计算textField的最大宽度
        CGFloat maxW = [myItem.title sizeWithFont:[UIConfigManager fontThemeTextMain]].width;
        [self.textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SCREEN_WIDTH - 45 - maxW));
        }];
    }
    
    if (myItem.type == NNHItemAccessoryViewTypeArrow) {
        self.accessoryView = self.rightArrow;
    }else if (myItem.type == NNHItemAccessoryViewTypeRightLabel) {
        self.rightLabel.text = myItem.rightTitle;
        // 根据文字计算尺寸
        NSMutableDictionary *fontAttrs = [NSMutableDictionary dictionary];
        fontAttrs[NSFontAttributeName] = self.rightLabel.font;
        self.rightLabel.nnh_size = [myItem.rightTitle sizeWithAttributes:fontAttrs];
        if (self.rightLabel.nnh_width > SCREEN_WIDTH - 140) self.rightLabel.nnh_width = SCREEN_WIDTH - 140;
        self.accessoryView = self.rightLabel;
    }else if (myItem.type == NNHItemAccessoryViewTypeRightView) {
        self.rightIconView.hidden = !myItem.rightIcon;
        self.rightViewLabel.hidden = !myItem.rightTitle;
        self.rightIconView.image = ImageName(myItem.rightIcon);
        self.rightViewLabel.text = myItem.rightTitle;
        if (myItem.rightTitleColor) {
            self.rightViewLabel.textColor = myItem.rightTitleColor;
        }else{
            self.rightViewLabel.textColor = [UIConfigManager colorTextLightGray];
        }
        self.accessoryView = self.rightView;
    }else if (myItem.type == NNHItemAccessoryViewTypeCustomView) {
        self.accessoryView = myItem.customRightView;
    }else { // 取消右边的内容
        self.accessoryView = nil;
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    self.myItem.currentTextFieldText = textField.text;
    
    if (self.textFieldValueChangedBlock) self.textFieldValueChangedBlock(textField.text,self.myItem);
    if (!self.myItem.limitLength) return;
    NSString *toBeString = textField.text;
    NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) { // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (toBeString.length > self.myItem.limitLength) {
                textField.text = [toBeString substringToIndex:self.myItem.limitLength];
            }
        }else{ // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
        }
    }else{ // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        if (toBeString.length > self.myItem.limitLength) {
            textField.text = [toBeString substringToIndex:self.myItem.limitLength];
        }  
    }
    
    // 针对字数限制重新赋值
    self.myItem.currentTextFieldText = textField.text;
}

- (UIImageView *)iconImageView
{
    if (_iconImageView == nil) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDark] font:[UIConfigManager fontThemeTextMain]];
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        _detailLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _detailLabel.backgroundColor = [UIColor whiteColor];
        _detailLabel.hidden = YES;
    }
    return _detailLabel;
}

- (UITextField *)textField
{
    if (_textField == nil) {
        _textField = [[UITextField alloc] init];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.font = [UIFont systemFontOfSize:13];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.textColor = [UIConfigManager colorThemeDarkGray];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        _textField.hidden = YES;
    }
    return _textField;
}

- (UIImageView *)rightArrow
{
    if (_rightArrow == nil) {
        _rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _rightArrow;
}

- (UILabel *)rightLabel
{
    if (_rightLabel == nil) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIConfigManager colorTextLightGray];
        _rightLabel.font = [UIFont systemFontOfSize:13];
        _rightLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    }
    return _rightLabel;
}

- (UIView *)rightView
{
    if (_rightView == nil) {
        _rightView = [[UIView alloc] init];
        
        UIImageView *rightArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
        [_rightView addSubview:self.rightViewLabel];
        [_rightView addSubview:rightArrow];
        [_rightView addSubview:self.rightIconView];
        
        [rightArrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_rightView);
            make.centerY.equalTo(_rightView);
        }];
        [self.rightIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightArrow.mas_left).offset(-NNHMargin_5);
            make.centerY.equalTo(_rightView);
        }];
        [self.rightViewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(rightArrow.mas_left).offset(-NNHMargin_5);
            make.centerY.equalTo(_rightView);
        }];
    }
    return _rightView;
}

- (UILabel *)rightViewLabel
{
    if (_rightViewLabel == nil) {
        _rightViewLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorTextLightGray] font:[UIFont systemFontOfSize:13]];
        _rightViewLabel.hidden = YES;
    }
    return _rightViewLabel;
}

- (UIImageView *)rightIconView
{
    if (_rightIconView == nil) {
        _rightIconView = [[UIImageView alloc] init];
        _rightIconView.hidden = YES;
    }
    return _rightIconView;
}

@end
