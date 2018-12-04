//
//  NNHHomeMallGoodsReserveViewController.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomeMallGoodsReserveViewController.h"
#import "NNHEnterPasswordView.h"
#import "NNHMallPaySuccessViewController.h"
#import "NNHMallGoodsDetailModel.h"

@interface NNHHomeMallGoodsReserveViewController ()<UITextFieldDelegate>

/** 商品图片 */
@property (nonatomic, strong) UIImageView *goodsImageView;
/** 商品价格 */
@property (nonatomic, strong) UILabel *goodsPriceLabel;
/** 商品标题 */
@property (nonatomic, strong) UILabel *goodsTitleLabel;

/** 购买数量 */
@property (nonatomic, strong) UITextField *countTextField;
/** 输入密码控件 */
@property (nonatomic, strong) NNHEnterPasswordView *enterView;
/** 确定按钮 */
@property (nonatomic, strong) UIButton *ensureButton;

@end

@implementation NNHHomeMallGoodsReserveViewController

#pragma mark - Life Cycle Methods
- (void)dealloc
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"预定";
    self.view.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
    
    [self setupChildView];
    
    [self configGoodsData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

#pragma mark - Initial Methods
- (void)setupChildView
{
    UIView *goodsInfoView = [[UIView alloc] init];
    goodsInfoView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:goodsInfoView];
    [goodsInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(NNHNavBarViewHeight);
        make.left.right.equalTo(self.view);
    }];
    
    [goodsInfoView addSubview:self.goodsImageView];
    [goodsInfoView addSubview:self.goodsTitleLabel];
    [goodsInfoView addSubview:self.goodsPriceLabel];
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(goodsInfoView).offset(NNHMargin_20);
        make.centerX.equalTo(goodsInfoView);
        make.height.equalTo(@(250));
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsImageView.mas_bottom).offset(NNHMargin_20);
        make.centerX.equalTo(self.goodsImageView);
    }];
    
    [self.goodsTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(goodsInfoView).offset(NNHNormalViewH);
        make.width.equalTo(@(SCREEN_WIDTH - NNHNormalViewH * 2));
        make.top.equalTo(self.goodsPriceLabel.mas_bottom).offset(NNHMargin_15);
        make.bottom.equalTo(goodsInfoView).offset(-NNHMargin_20);
    }];

    UIView *countView = [[UIView alloc] init];
    countView.backgroundColor = [UIConfigManager colorThemeWhite];
    [self.view addSubview:countView];
    [countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(NNHNormalViewH));
        make.top.equalTo(goodsInfoView.mas_bottom).offset(NNHMargin_10);
    }];
    
    UILabel *titleLabel = [UILabel NNHWithTitle:@"预付金额" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextMain]];
    [countView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(countView).offset(NNHMargin_15);
        make.centerY.equalTo(countView);
    }];
    
    [countView addSubview:self.countTextField];
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(NNHMargin_15);
        make.width.equalTo(@(SCREEN_WIDTH - 100));
        make.centerY.equalTo(countView);
        make.height.equalTo(@(40));
    }];
    
    [self.view addSubview:self.ensureButton];
    [self.ensureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(NNHMargin_15);
        make.right.equalTo(self.view).offset(-NNHMargin_15);
        make.height.equalTo(@(NNHNormalViewH));
        make.bottom.equalTo(self.view).offset(-NNHNormalViewH -(NNHBottomSafeHeight));
    }];
}

#pragma mark - Network Methods

#pragma mark - UITextFieldDelegate

- (void)textFieldDidChange:(UITextField *)textField
{
    self.ensureButton.enabled = textField.text.length;
}

#pragma mark - Target Methods


/** 点击确定按钮 */
- (void)clickEnsureButtonAction
{
    NNHMallPaySuccessViewController *successVC = [[NNHMallPaySuccessViewController alloc] init];
    [self.navigationController pushViewController:successVC animated:YES];
    
    return;
    
    if ([self.countTextField.text floatValue] == 0) {
        [SVProgressHUD showMessage:@"购买数量不能为零"];
        return;
    }
    [self.enterView showInFatherView:self.view];
}

/** 输入密码 */
- (void)enterPassword:(NSString *)password
{
//    NNHWeakSelf(self)
//    NNHAPIStockRightTool *networkTool = [[NNHAPIStockRightTool alloc] initTakeStockRightOrderWithNumber:self.countTextField.text password:password];
//    [networkTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
//        [weakself.enterView dissmissWithCompletion:nil];
//        [SVProgressHUD showMessage:@"购买成功"];
//        [weakself requestStockRightData];
//    } failBlock:^(NNHRequestError *error) {
//        [weakself.enterView resetStatus];
//    } isCached:NO];
}

#pragma mark - Public Methods

- (void)configGoodsData
{
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.goodsModel.thumb]];
    
    self.goodsTitleLabel.text = self.goodsModel.productname;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.goodsModel.prouctprice];
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_goodsTitleLabel.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 设置文字居中
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_goodsTitleLabel.text length])];
    self.goodsTitleLabel.attributedText = attributedString;
    
    [self.goodsPriceLabel nnh_addAttringTextWithText:self.goodsModel.prouctprice font:[UIFont boldSystemFontOfSize:22] color:[UIConfigManager colorThemeRed]];

}

#pragma mark - Private Methods

#pragma mark - Lazy Loads



- (UIImageView *)goodsImageView
{
    if (_goodsImageView == nil) {
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
        _goodsImageView.backgroundColor = [UIConfigManager colorThemeWhite];
    }
    return _goodsImageView;
}

- (UILabel *)goodsTitleLabel
{
    if (_goodsTitleLabel == nil) {
        _goodsTitleLabel = [[UILabel alloc] init];
        _goodsTitleLabel.numberOfLines = 2;
        _goodsTitleLabel.text = @"商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称商品名称";
        _goodsTitleLabel.font = [UIConfigManager fontThemeTextMain];
        _goodsTitleLabel.textColor = [UIColor akext_colorWithHex:@"#000000"];
    }
    return _goodsTitleLabel;
}

- (UILabel *)goodsPriceLabel
{
    if (_goodsPriceLabel == nil) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.font = [UIFont systemFontOfSize:14];
        _goodsPriceLabel.textColor = [UIConfigManager colorThemeRed];
        _goodsPriceLabel.text = @"￥0";
    }
    return _goodsPriceLabel;
}

- (UITextField *)countTextField
{
    if (_countTextField == nil) {
        _countTextField = [[UITextField alloc] init];
        _countTextField.placeholder = @"请输入预付金额，最低预付10000元";
        _countTextField.font = [UIConfigManager fontThemeTextMain];
        _countTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _countTextField.delegate = self;
        [_countTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _countTextField;
}

- (UIButton *)ensureButton
{
    if (_ensureButton == nil) {
        _ensureButton = [UIButton NNHOperationBtnWithTitle:@"确认预定" target:self action:@selector(clickEnsureButtonAction) operationButtonType:NNHOperationButtonTypeRed isAddCornerRadius:YES];
        _ensureButton.enabled = NO;
        _ensureButton.layer.cornerRadius = NNHNormalViewH * 0.5;
        _ensureButton.nn_acceptEventInterval = NNHAcceptEventInterval;
    }
    return _ensureButton;
}

- (NNHEnterPasswordView *)enterView
{
    if (_enterView == nil) {
        _enterView = [[NNHEnterPasswordView alloc] init];
        NNHWeakSelf(self)
        _enterView.didEnterCodeBlock = ^(NSString *password){
            NNHStrongSelf(self)
            [strongself enterPassword:password];
        };
    }
    return _enterView;
}

#pragma mark - NSObject  Methods

#define myDotNumbers     @"0123456789.\n"
#define myNumbers          @"0123456789\n"

#pragma mark -
#pragma mark --------- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // 判断是否输入内容，或者用户点击的是键盘的删除按钮
    if (![string isEqualToString:@""]) {
        NSCharacterSet *cs;
        // 小数点在字符串中的位置 第一个数字从0位置开始
        NSInteger dotLocation = [textField.text rangeOfString:@"."].location;
        // 判断字符串中是否有小数点，并且小数点不在第一位
        // NSNotFound 表示请求操作的某个内容或者item没有发现，或者不存在
        // range.location 表示的是当前输入的内容在整个字符串中的位置，位置编号从0开始
        if (dotLocation == NSNotFound && range.location != 0) {
            // 取只包含“myDotNumbers”中包含的内容，其余内容都被去掉
            /* [NSCharacterSet characterSetWithCharactersInString:myDotNumbers]的作用是去掉"myDotNumbers"中包含的所有内容，只要字符串中有内容与"myDotNumbers"中的部分内容相同都会被舍去在上述方法的末尾加上invertedSet就会使作用颠倒，只取与“myDotNumbers”中内容相同的字符
             */
            cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers] invertedSet];
            if (range.location >= 9) {
                NNHLog(@"单笔金额不能超过亿位");
                if ([string isEqualToString:@"."] && range.location == 9) {
                    return YES;
                }
                return NO;
            }
        }else {
            cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers] invertedSet];
        }
        // 按cs分离出数组,数组按@""分离出字符串
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        BOOL basicTest = [string isEqualToString:filtered];
        if (!basicTest) {
            NNHLog(@"只能输入数字和小数点");
            return NO;
        }
        if (dotLocation != NSNotFound && range.location > dotLocation + 2) {
            NNHLog(@"小数点后最多两位");
            return NO;
        }
        if (textField.text.length > 11) {
            return NO;
        }
    }
    return YES;
}

@end
