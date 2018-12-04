//
//  NNHMessageSystemCell.m
//  WBTMall
//
//  Created by 来旭磊 on 2017/4/15.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHMessageSystemCell.h"
#import "NSDictionary+NNHExtension.h"

@interface NNHMessageSystemCell ()

/** <#注释#> */
@property (nonatomic, strong) UIView *whitContentView;
/** 消息标题 */
@property (nonatomic, strong) UILabel *messageTitleLabel;
/** 纯文字消息内容 */
@property (nonatomic, strong) UILabel *messageContentLabel;
/** 图文消息内容 */
@property (nonatomic, strong) UILabel *messageSubContentLabel;
/** 消息图片 */
@property (nonatomic, strong) UIImageView *messageImageView;
/** 消息时间 */
@property (nonatomic, strong) UILabel *messageTimeLabel;
@end

@implementation NNHMessageSystemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIConfigManager colorThemeColorForVCBackground];
        [self setupChildView];
    }
    return self;
}

- (void)setupChildView
{
    [self.contentView addSubview:self.messageTimeLabel];
    [self.messageTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView.mas_top).offset(NNHMargin_25);
        make.height.equalTo(@25);
        make.width.equalTo(@120);
    }];
    
    [self.contentView addSubview:self.whitContentView];
    [self.whitContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(NNHMargin_15);
        make.right.equalTo(self.contentView).offset(-NNHMargin_15);
        make.top.equalTo(self.contentView).offset(50);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.messageTitleLabel];
    [self.whitContentView addSubview:self.messageContentLabel];
    [self.whitContentView addSubview:self.messageSubContentLabel];
    [self.whitContentView addSubview:self.messageImageView];
    
    [self.messageTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whitContentView).offset(NNHMargin_10);
        make.right.equalTo(self.whitContentView).offset(-NNHMargin_10);
        make.top.equalTo(self.whitContentView).offset(NNHMargin_10);
        
    }];
    [self.messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whitContentView).offset(NNHMargin_10);
        make.right.equalTo(self.whitContentView).offset(-NNHMargin_10);
        make.top.equalTo(self.messageTitleLabel.mas_bottom).offset(NNHMargin_10);
        
    }];
    [self.messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whitContentView).offset(NNHMargin_10);
        make.bottom.equalTo(self.whitContentView).offset(-NNHMargin_10);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    [self.messageSubContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.messageImageView.mas_right).offset(NNHMargin_10);
        make.top.equalTo(self.messageImageView.mas_top);
        make.width.equalTo(@(SCREEN_WIDTH - 50 - NNHMargin_10 - 70));
    }];
}

- (void)setRcMessageModel:(RCMessage *)rcMessageModel
{
    _rcMessageModel = rcMessageModel;
    
    NSString *stamp = [NSString stringWithFormat:@"%zd",rcMessageModel.sentTime];
    self.messageTimeLabel.text = [NSString dateStringWithTimeStamp:stamp];

    //文字消息
    if ([rcMessageModel.content isKindOfClass:[RCTextMessage class]]) {
        RCTextMessage *textMessage = (RCTextMessage *)rcMessageModel.content;
#warning 改了解码方法
        NSDictionary *orderDict = [textMessage.extra jsonValueDecoded];
        self.messageTitleLabel.text = orderDict[@"title"];
        self.messageContentLabel.text = textMessage.content;
        self.messageImageView.hidden = self.messageSubContentLabel.hidden = YES;
        self.messageContentLabel.hidden = NO;
    }

    //图文消息
    if ([rcMessageModel.content isKindOfClass:[RCRichContentMessage class]]) {
        self.messageImageView.hidden = self.messageSubContentLabel.hidden = NO;
        self.messageContentLabel.hidden = YES;
        RCRichContentMessage *richMessage = (RCRichContentMessage *)rcMessageModel.content;
        self.messageTitleLabel.text = richMessage.title;
        [self.messageImageView sd_setImageWithURL:[NSURL URLWithString:richMessage.imageURL] placeholderImage:ImageName([UIConfigManager NNH_placeHolder_product])];
        
        if (richMessage.extra) {
#warning 改了解码方法
            NSDictionary *orderDict = [richMessage.extra jsonValueDecoded];
            self.messageSubContentLabel.text = orderDict[@"content"];
        }
    }
}

#pragma mark -
#pragma mark ---------Getter && Setter

- (UILabel *)messageTitleLabel
{
    if (_messageTitleLabel == nil) {
        _messageTitleLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeBlack] font:[UIConfigManager fontThemeTextImportant]];
        
        _messageTitleLabel.numberOfLines = 2;
    }
    return _messageTitleLabel;
}

- (UILabel *)messageContentLabel
{
    if (_messageContentLabel == nil) {
        _messageContentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _messageContentLabel.numberOfLines = 0;
    }
    return _messageContentLabel;
}

- (UILabel *)messageSubContentLabel
{
    if (_messageSubContentLabel == nil) {
        _messageSubContentLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _messageSubContentLabel.numberOfLines = 4;
    }
    return _messageSubContentLabel;
}

- (UILabel *)messageTimeLabel
{
    if (_messageTimeLabel == nil) {
        _messageTimeLabel = [UILabel NNHWithTitle:@"" titleColor:[UIConfigManager colorThemeDarkGray] font:[UIConfigManager fontThemeTextDefault]];
        _messageTimeLabel.textColor = [UIConfigManager colorThemeWhite];
        _messageTimeLabel.textAlignment = NSTextAlignmentCenter;
        _messageTimeLabel.backgroundColor = [UIConfigManager colorTextLightGray];
        _messageTimeLabel.layer.cornerRadius = NNHMargin_5;
        _messageTimeLabel.clipsToBounds = YES;
    }
    return _messageTimeLabel;
}

- (UIView *)whitContentView
{
    if (_whitContentView == nil) {
        _whitContentView = [[UIView alloc] init];
        _whitContentView.backgroundColor = [UIConfigManager colorThemeWhite];
        _whitContentView.layer.cornerRadius = NNHMargin_5;
        _whitContentView.clipsToBounds = YES;
    }
    return _whitContentView;
}

- (UIImageView *)messageImageView
{
    if (_messageImageView == nil) {
        _messageImageView = [[UIImageView alloc] init];
        _messageImageView.hidden = YES;
    }
    return _messageImageView;
}


@end
