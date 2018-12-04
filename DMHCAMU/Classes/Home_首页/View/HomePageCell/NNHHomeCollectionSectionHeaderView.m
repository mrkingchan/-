//
//  NNHHomeCollectionSectionHeaderView.m
//  DMHCAMU
//
//  Created by 牛牛汇 on 2018/10/18.
//  Copyright © 2018 牛牛. All rights reserved.
//

#import "NNHHomeCollectionSectionHeaderView.h"
#import "NNHHomePageBaseModel.h"

@interface NNHHomeCollectionSectionHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation NNHHomeCollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(NNHMargin_15);
            make.baseline.equalTo(self).offset(-NNHMargin_15);
        }];
        
        UIImageView *arrowImageView = [[UIImageView alloc] init];
        [self addSubview:arrowImageView];
        arrowImageView.image = [UIImage imageNamed:@"mine_order_arrow"];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.mas_right).offset(NNHMargin_5);
        }];
    }
    return self;
}

- (void)setBaseModel:(NNHHomePageBaseModel *)baseModel
{
    _baseModel = baseModel;
    self.titleLabel.text = baseModel.modulename;
}


#pragma mark -
#pragma mark ---------Getter && Setter

#pragma mark -
#pragma mark ---------Getter && Setter

-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIColor akext_colorWithHex:@"#000000"] font:[UIFont boldSystemFontOfSize:22]];
    }
    return _titleLabel;
}

@end
