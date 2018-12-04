//
//  NNHMallGoodsDetailOperationView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHMallGoodsDetailOperationView.h"
#import "UIButton+NNImagePosition.h"
#import "NNHMallGoodsDetailModel.h"
#import "NNHAPICollectionTool.h"

@interface NNHMallGoodsDetailOperationView ()

/** 消息 */
@property (nonatomic, strong) UIButton *messageBtn;
/** 关注 */
@property (nonatomic, strong) UIButton *collectionBtn;
/** 预定 */
@property (nonatomic, strong) UIButton *addShopCarBtn;

@end

@implementation NNHMallGoodsDetailOperationView

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
    // 初始化子控件
    UIView *topLine = [UIView lineView];
    
    [self addSubview:topLine];
    [self addSubview:self.messageBtn];
    [self addSubview:self.collectionBtn];
    [self addSubview:self.addShopCarBtn];
    
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(NNHLineH);
    }];
    
    [self.collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.top.equalTo(self);
        make.width.equalTo(@(NNHOrderDetailOperationViewH));
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionBtn.mas_right);
        make.centerY.equalTo(self);
        make.size.equalTo(self.collectionBtn);
    }];
    
    [self.addShopCarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageBtn.mas_right).offset(NNHMargin_10);
        make.height.equalTo(@(36));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-NNHMargin_10);
    }];
}

- (void)setGoodsModel:(NNHMallGoodsDetailModel *)goodsModel
{
    _goodsModel = goodsModel;
    
    self.collectionBtn.selected = [goodsModel.iscollect isEqualToString:@"1"];
    
    self.addShopCarBtn.enabled = [goodsModel.is_cat isEqualToString:@"0"];
}

- (UIButton *)messageBtn
{
    if (_messageBtn == nil) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setImage:ImageName(@"ic_tab_service") forState:UIControlStateNormal];
        [_messageBtn setTitle:@"咨询" forState:UIControlStateNormal];
        [_messageBtn setTitleColor:[UIConfigManager colorThemeDarkGray] forState:UIControlStateNormal];
        [_messageBtn.titleLabel setFont:[UIConfigManager fontThemeTextMinTip]];
        [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
        _messageBtn.adjustsImageWhenHighlighted = NO;
        [_messageBtn nn_setImagePosition:NNImagePositionTop spacing:5.0];
    }
    return _messageBtn;
}

- (UIButton *)collectionBtn
{
    if (_collectionBtn == nil) {
        _collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_collectionBtn setImage:ImageName(@"ic_tab_heart_default") forState:UIControlStateNormal];
        [_collectionBtn setImage:ImageName(@"ic_tab_heart_pressed") forState:UIControlStateSelected];
        [_collectionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_collectionBtn setTitleColor:[UIConfigManager colorThemeDarkGray] forState:UIControlStateNormal];
        [_collectionBtn.titleLabel setFont:[UIConfigManager fontThemeTextMinTip]];
        [_collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
        _collectionBtn.adjustsImageWhenHighlighted = NO;
        [_collectionBtn nn_setImagePosition:NNImagePositionTop spacing:5.0];
    }
    return _collectionBtn;
}

- (UIButton *)addShopCarBtn
{
    if (_addShopCarBtn == nil) {
        _addShopCarBtn = [self buttonWithBgColor:[UIConfigManager colorThemeRed] title:@"预定" titleColor:[UIColor whiteColor] action:@selector(addShopCarAction)];
        [_addShopCarBtn setTitle:@"已出售" forState:UIControlStateDisabled];
        [_addShopCarBtn setBackgroundImage:[UIImage nnh_imageWithColor:[UIConfigManager colorThemeDisable]] forState:UIControlStateDisabled];
    }
    return _addShopCarBtn;
}


- (UIButton *)buttonWithBgColor:(UIColor *)bgColor title:(NSString *)title titleColor:(UIColor *)titleColor action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage nnh_imageWithColor:bgColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIConfigManager fontThemeTextMain];
    btn.layer.cornerRadius = 18;
    btn.layer.masksToBounds = YES;
    btn.adjustsImageWhenHighlighted = NO;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (void)messageAction
{
    if (self.operationViewJumpBlock) self.operationViewJumpBlock(NNHMallGoodsDetailBottomOperationType_message);
}

- (void)collectionAction:(UIButton *)btn
{
    if (![[NNHProjectControlCenter sharedControlCenter] loginStatus:YES]) return;
    if (self.operationViewJumpBlock){
        [self changeGoodsCollectionStatusOperationWithCollection:!btn.selected];
    }
}

- (void)addShopCarAction
{
    if (![[NNHProjectControlCenter sharedControlCenter] loginStatus:YES]) return;
    if (self.operationViewJumpBlock) self.operationViewJumpBlock(NNHMallGoodsDetailBottomOperationType_addCart);
}

/** 修改实体店收藏状态 */
- (void)changeGoodsCollectionStatusOperationWithCollection:(BOOL)isCollection
{
    if (self.goodsModel.goodsID.length == 0) return;
    
    NNHWeakSelf(self)
    NNHAPICollectionTool *collectionTool = [[NNHAPICollectionTool alloc] initWithUserCollectionOperationWithCollectionObjectID:self.goodsModel.goodsID collectiontype:0 isCollection:isCollection];

    [collectionTool nnh_StartRequestWithSucBlock:^(NSDictionary *responseDic) {
        if (isCollection) {
            [SVProgressHUD showMessage:@"收藏成功"];
        }else {
            [SVProgressHUD showMessage:@"取消收藏成功"];
        }
        weakself.collectionBtn.selected = isCollection;

    } failBlock:^(NNHRequestError *error) {

    } isCached:NO];
}


@end
