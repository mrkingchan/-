//
//  NNHAddressPickerView.m
//  ElegantTrade
//
//  Created by 来旭磊 on 16/10/27.
//  Copyright © 2016年 牛牛汇. All rights reserved.
//

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#import "NNHCityPickerView.h"

@interface NNHCityPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

/** 省 **/
@property (nonatomic, strong) NSArray *provinceArray;

/** 市 **/
@property (nonatomic, strong) NSArray *cityArray;

/** 区 **/
@property (nonatomic, strong) NSArray *areasArray;

/** 当前显示省 **/
@property (nonatomic, copy) NSString *currentProvince;

/** 当前显示城市 **/
@property (nonatomic, copy) NSString *currentCity;

/** 当前显示区域 **/
@property (nonatomic, copy) NSString *currentDistrict;

/** <#code#> **/
@property (nonatomic, strong) UIView *wholeView;

/** <#code#> **/
@property (nonatomic, strong) UIView *topView;

/** <#code#> **/
@property (nonatomic, strong) UIPickerView *pickerView;

@end

@implementation NNHCityPickerView

+ (id)shareInstance
{
    static NNHCityPickerView *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[NNHCityPickerView alloc] init];
    });
    
    return shareInstance;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenBottomView)];
        [self addGestureRecognizer:tap];
        
        self.currentProvince = [[NSString alloc] init];
        self.currentCity = [[NSString alloc] init];
        self.currentDistrict = [[NSString alloc] init];
        
        [self createData];
        [self setupChlidView];
    }
    return self;
}

- (void)createData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSArray *data = [[NSArray alloc]initWithContentsOfFile:plistPath];
    
    self.provinceArray = data;
    
    // 第一个省分对应的全部市
    self.cityArray = [[self.provinceArray objectAtIndex:0] objectForKey:@"cities"];
    
    // 第一个省份对应的第一个市对应的第一个区
    self.areasArray = [[self.cityArray objectAtIndex:0] objectForKey:@"areas"];
    
    // 第一个省份
    _currentProvince = [[self.provinceArray objectAtIndex:0] objectForKey:@"state"];
    // 第一个省份对应的第一个市
    _currentCity = [[self.cityArray objectAtIndex:0] objectForKey:@"city"];

    if (self.areasArray.count > 0) {
        _currentDistrict = [self.areasArray objectAtIndex:0];
    } else {
        _currentDistrict = @"";
    }
    
}

- (void)setupChlidView
{
    // 弹出的整个视图
    self.wholeView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, self.nnh_width, 250)];
    [self addSubview:self.wholeView];
    
    // 头部按钮视图
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.nnh_width, 50)];
    _topView.backgroundColor = [UIColor whiteColor];
    [self.wholeView addSubview:_topView];
    
    // 防止点击事件触发
    UITapGestureRecognizer *topTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
    [_topView addGestureRecognizer:topTap];
    
    UIButton *cancleButton = [UIButton NNHBorderBtnTitle:@"取消" borderColor:[UIConfigManager colorTextLightGray] titleColor:[UIConfigManager colorTextLightGray]];
    [_topView addSubview:cancleButton];
    cancleButton.tag = 0;
    [cancleButton addTarget:self action:@selector(toolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topView).offset(NNHMargin_10);
        make.top.equalTo(_topView).offset(NNHMargin_5);
        make.size.mas_equalTo(CGSizeMake(70, NNHTopToolbarH));
    }];
    
    UIButton *sureButton = [UIButton NNHBorderBtnTitle:@"确定" borderColor:[UIColor redColor] titleColor:[UIColor redColor]];
    [_topView addSubview:sureButton];
    sureButton.tag = 1;
    [sureButton addTarget:self action:@selector(toolButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_topView).offset(-NNHMargin_10);
        make.top.equalTo(_topView).offset(NNHMargin_5);
        make.size.mas_equalTo(CGSizeMake(70, NNHTopToolbarH));
    }];
    
    // pickerView
    self.pickerView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 50, self.nnh_width, 250-50)];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    [self.wholeView addSubview:self.pickerView];
}

- (void)toolButtonClick:(UIButton *)button
{
    // 点击确定回调block
    if (button.tag == 1)
    {
        if (self.addressPickerBlock) {
            self.addressPickerBlock(self.currentProvince, self.currentCity, self.currentDistrict);
        }
    }
    [self hiddenBottomView];
}

/** 添加到父控件上 */
+ (instancetype)showInSuperView:(UIView *)superView complete:(AddressPickerBlock )addressPickerBlock
{
    NNHCityPickerView *pickerView = [[NNHCityPickerView alloc] initWithFrame:superView.bounds];
    [superView addSubview:pickerView];
    [pickerView showBottomView];
    pickerView.addressPickerBlock = addressPickerBlock;
    return pickerView;
}

- (void)showBottomView
{
    [UIView animateWithDuration:0.3 animations:^
     {
         _wholeView.frame = CGRectMake(0, ScreenHeight-250, ScreenWidth, 250);
         
     } completion:^(BOOL finished) {}];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if ([defaults objectForKey:@"address"]) {
//        [self refreshPickerView:[defaults objectForKey:@"address"]];
//    }
}

- (void)hiddenBottomView
{
    [UIView animateWithDuration:0.3 animations:^
     {
         _wholeView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 250);
         
     } completion:^(BOOL finished) {
         [self removeFromSuperview];
     }];
}

//- (void)refreshPickerView:(NSString *)address
//{
//    
//    NSArray *addressArray = [address componentsSeparatedByString:@" "];
//    NSString *provinceStr = addressArray[0];
//    NSString *cityStr = addressArray[1];
//    NSString *districtStr = addressArray[2];
//    
//    int oneColumn=0, twoColumn=0, threeColum=0;
//    
//    // 省份
//    for (int i=0; i<self.provinceArray.count; i++)
//    {
//        if ([provinceStr isEqualToString:[self.provinceArray[i] objectForKey:@"state"]]) {
//            oneColumn = i;
//        }
//    }
//    
//    // 用来记录是某个省下的所有市
//    NSArray *tempArray = [self.provinceArray[oneColumn] objectForKey:@"cities"];
//    // 市
//    for  (int j=0; j<[tempArray count]; j++)
//    {
//        if ([cityStr isEqualToString:[tempArray[j] objectForKey:@"city"]])
//        {
//            twoColumn = j;
//            break;
//        }
//    }
//    
//    // 区
//    for (int k=0; k<[[tempArray[twoColumn] objectForKey:@"areas"] count]; k++)
//    {
//        if ([districtStr isEqualToString:[tempArray[twoColumn] objectForKey:@"areas"][k]])
//        {
//            threeColum = k;
//            break;
//        }
//    }
//    
//    [self pickerView:_pickerView didSelectRow:oneColumn inComponent:0];
//    [self pickerView:_pickerView didSelectRow:twoColumn inComponent:1];
//    [self pickerView:_pickerView didSelectRow:threeColum inComponent:2];
//}

#pragma mark - UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [self.provinceArray count];
            break;
        case 1:
            return [self.cityArray count];
            break;
        case 2:
            
            return [self.areasArray count];
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return NNHNormalViewH;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component)
    {
        case 0:
            return [[self.provinceArray objectAtIndex:row] objectForKey:@"state"];
            break;
        case 1:
            return [[self.cityArray objectAtIndex:row] objectForKey:@"city"];
            break;
        case 2:
            if ([self.areasArray count] > 0) {
                return [self.areasArray objectAtIndex:row];
                break;
            }
        default:
            return  @"";
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [pickerView selectRow:row inComponent:component animated:YES];
    
    switch (component)
    {
        case 0:
            self.cityArray = [[self.provinceArray objectAtIndex:row] objectForKey:@"cities"];
            [_pickerView selectRow:0 inComponent:1 animated:YES];
            [_pickerView reloadComponent:1];
            
            self.areasArray = [[self.cityArray objectAtIndex:0] objectForKey:@"areas"];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            [_pickerView reloadComponent:2];
            
            _currentProvince = [[self.provinceArray objectAtIndex:row] objectForKey:@"state"];
            _currentCity = [[self.cityArray objectAtIndex:0] objectForKey:@"city"];
            if ([self.areasArray count] > 0) {
                _currentDistrict = [self.areasArray objectAtIndex:0];
            } else{
                _currentDistrict = @"";
            }
            break;
            
        case 1:
            self.areasArray = [[self.cityArray objectAtIndex:row] objectForKey:@"areas"];
            [_pickerView selectRow:0 inComponent:2 animated:YES];
            [_pickerView reloadComponent:2];
            
            _currentCity = [[self.cityArray objectAtIndex:row] objectForKey:@"city"];
            if ([self.areasArray count] > 0) {
                _currentDistrict = [self.areasArray objectAtIndex:0];
            } else {
                _currentDistrict = @"";
            }
            break;
            
        case 2:
            
            if ([self.areasArray count] > 0) {
                _currentDistrict = [self.areasArray objectAtIndex:row];
            } else{
                _currentDistrict = @"";
            }
            break;
            
        default:
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel)
    {
        pickerLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextImportant]];
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    return pickerLabel;
}

#pragma mark - Getter && Setter

- (NSArray *)provinceArray
{
    if (_provinceArray == nil) {
        _provinceArray = [NSArray array];
    }
    return _provinceArray;
}

- (NSArray *)cityArray
{
    if (_cityArray == nil) {
        _cityArray = [NSArray array];
    }
    return _cityArray;
}

- (NSArray *)areasArray
{
    if (_areasArray == nil) {
        _areasArray = [NSArray array];
    }
    return _areasArray;
}

@end
