//
//  NNHDatePickerView.m
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/27.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//


#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "NNHDatePickerView.h"
#import "NSCalendar+NNHExtension.h"

@interface NNHDatePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

/** 类型 */
@property (nonatomic, assign) NNHDatePickerType datePickerType;
/** 当前选中年 */
@property (nonatomic, assign) NSInteger currentSelectedYear;
/** 当前选中月 */
@property (nonatomic, assign) NSInteger currentSelectedMonth;
/** 当前选中日 */
@property (nonatomic, assign) NSInteger currentSelectedDay;
/** 最小年份 */
@property (nonatomic, assign) NSInteger minYear;
/** 最新年 */
@property (nonatomic, assign) NSInteger newYear;
/** 最新月 */
@property (nonatomic, assign) NSInteger newMonth;
/** 最新日 */
@property (nonatomic, assign) NSInteger newDay;
/** 显示年份数量，默认 今年 - 2017 + 1 */
@property (nonatomic, assign) NSInteger yearSum;
/** 容器 **/
@property (nonatomic, strong) UIView *contentView;
/** 顶部 **/
@property (nonatomic, strong) UIView *topView;
/** pickerView **/
@property (nonatomic, strong) UIPickerView *pickerView;
/** 保存选择的时间 **/
@property (nonatomic, copy) NSString *timeString;

@end

@implementation NNHDatePickerView

- (instancetype)initWithDatePickerType:(NNHDatePickerType)type minYear:(NSUInteger)minYear
{
    self = [super init];
    if (self){
        
        // 设置初始值
        _minYear = minYear == 0 ? 2017 : minYear;
        _datePickerType = type ? type : NNHDatePickerTypeDate;
        _newYear = _currentSelectedYear = [NSCalendar currentYear];
        _newMonth = _currentSelectedMonth = [NSCalendar currentMonth];
        _newDay = _currentSelectedDay = [NSCalendar currentDay];
        _yearSum = _newYear - _minYear + 1;
        
        // 初始化UI
        [self setupChlidView];
        
        // 设置默认显示数据
        [self setupDefaultData];
    }
    return self;
}

- (void)setupDefaultData
{
    [self.pickerView selectRow:self.yearSum - 1 inComponent:0 animated:NO];
    if (self.datePickerType != NNHDatePickerTypeYear) [self.pickerView selectRow:self.newMonth - 1 inComponent:1 animated:NO];
    if (self.datePickerType == NNHDatePickerTypeDate) [self.pickerView selectRow:self.newDay - 1 inComponent:2 animated:NO];
}

- (void)setupChlidView
{
    // 遮罩
    UIView *coverView = [[UIView alloc] init];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
    [self addSubview:coverView];
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    
    [self addSubview:self.contentView];
    
    [self.contentView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.height.equalTo(@(44));
    }];
    
    [self.contentView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@(NNHKeyboardHeight));
    }];
}

- (void)toolButtonClick:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 1){
        
        // 拼接时间
        if (self.datePickerType == NNHDatePickerTypeYear) {
            self.timeString = [NSString stringWithFormat:@"%zd",self.currentSelectedYear];
        }else if (self.datePickerType == NNHDatePickerTypeYearAndMonth){
            self.timeString = [NSString stringWithFormat:@"%zd-%02zd",self.currentSelectedYear,self.currentSelectedMonth];
        }else{
            self.timeString = [NSString stringWithFormat:@"%zd-%02zd-%02zd",self.currentSelectedYear,self.currentSelectedMonth,self.currentSelectedDay];
        }
        
        // 回传
        if (self.dateBlock) self.dateBlock(self.timeString);
    }
    
    [self hiddenBottomView];
}

/** 添加到父控件上 */
- (void)showDatePicker
{
    // 获得最上面的窗口
    UIWindow *window = [UIView currentWindow];
    
    // 添加自己到窗口上
    [window addSubview:self];
    
    // 设置尺寸
    self.frame = window.bounds;
    
    [self beginAnimation];
}

- (void)beginAnimation
{
    CGFloat height = 44 + NNHKeyboardHeight;
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(height));
    }];
    
    [self setNeedsDisplay];
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(@(height));
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hiddenBottomView
{
    [UIView animateWithDuration:0.5 animations:^{
        [self.pickerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.mas_bottom);
            make.height.equalTo(@(NNHKeyboardHeight));
        }];
        
        [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.right.equalTo(self);
        }];
        
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.yearSum;
    }else if (component == 1){
        return 12;
    }else{
        return [NSCalendar getDaysWithYear:self.currentSelectedYear month:self.currentSelectedMonth];
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.datePickerType == NNHDatePickerTypeDate) {
        return 3;
    }else if (self.datePickerType == NNHDatePickerTypeYearAndMonth) {
        return 2;
    }else{
        return 1;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return NNHNormalViewH;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *text;
    if (component == 0) {
        text = [NSString stringWithFormat:@"%ld 年", row + self.minYear];
    }else if (component == 1){
        text = [NSString stringWithFormat:@"%ld 月", row + 1];
    }else{
        text = [NSString stringWithFormat:@"%ld 日" , row + 1];
    }
    return text;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    // 日期处理
    switch (component) {
        case 0:
            // 当前选中年份
            self.currentSelectedYear  = row + self.minYear;
            
            // 重置月份／日
            if (self.datePickerType != NNHDatePickerTypeYear) {
                self.currentSelectedMonth = 1;
               [pickerView selectRow:0 inComponent:1 animated:YES];
            }
            if (self.datePickerType == NNHDatePickerTypeDate) {
                self.currentSelectedDay = 1;
                [pickerView reloadComponent:2];
                [pickerView selectRow:0 inComponent:2 animated:YES];
            }
            break;
        case 1:
            
            // 当前选中月
            self.currentSelectedMonth = row + 1;
            
            // 选择将来月份时，让其重置到当前最新月份
            if (row > self.newMonth - 1 && self.currentSelectedYear >= self.newYear && self.newMonth > 1) {
                self.currentSelectedMonth = self.newMonth - 1;
                [pickerView selectRow:self.newMonth - 1 inComponent:component animated:YES];
            }else{
                if (self.datePickerType == NNHDatePickerTypeDate) {  // 重置日
                    self.currentSelectedDay = 1;
                    [pickerView reloadComponent:2];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                }
            }
            
            break;
        case 2:
            
            // 当前选中天
            self.currentSelectedDay = row + 1;
            
            // 选择将来日时，让其重置到当前最新天
            if (self.currentSelectedYear >= self.newYear && self.currentSelectedMonth >= self.newMonth && self.currentSelectedDay >= self.newDay) {
                if (self.newDay > 1 && row > self.newDay - 1) {
                    self.currentSelectedDay = self.newDay - 1;
                    [pickerView selectRow:self.newDay - 1 inComponent:component animated:YES];
                }
            }
            
            break;
    }
}

#pragma mark - Getter && Setter
- (UIView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UIPickerView *)pickerView
{
    if (_pickerView == nil) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}

- (UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        
        UIButton *cancleButton = [UIButton NNHBtnTitle:@"取消" titileFont:[UIConfigManager fontThemeTextMain] backGround:[UIConfigManager colorThemeColorForVCBackground] titleColor:[UIColor akext_colorWithHex:@"268aec"]];
        [_topView addSubview:cancleButton];
        cancleButton.tag = 0;
        [cancleButton addTarget:self action:@selector(toolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_topView).offset(NNHMargin_15);
            make.top.equalTo(_topView);
            make.size.mas_equalTo(CGSizeMake(70, 44));
        }];
        
        UIButton *sureButton = [UIButton NNHBtnTitle:@"确定" titileFont:[UIConfigManager fontThemeTextMain] backGround:[UIConfigManager colorThemeColorForVCBackground] titleColor:[UIColor akext_colorWithHex:@"268aec"]];
        [_topView addSubview:sureButton];
        sureButton.tag = 1;
        [sureButton addTarget:self action:@selector(toolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_topView).offset(-NNHMargin_15);
            make.top.equalTo(_topView);
            make.size.equalTo(cancleButton);
        }];
    }
    return _topView;
}

@end
