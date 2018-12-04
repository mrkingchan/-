//
//  NNHShareView.h
//  ElegantLife
//
//  Created by 牛牛 on 16/5/6.
//  Copyright © 2016年 NNH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NNHShareView;

typedef NS_ENUM(NSInteger, NNHShareType) {
    NNHShareWeiXin      = 0  ,   //微信好友
    NNHShareWeiXinFriend     ,   //微信朋友圈
    NNHShareQQ               ,   //QQ分享
    NNHShareQQSpace          ,   //QQ空间分享
    NNHShareSMS              ,   //短信分享
};

@protocol NNHShareViewDelegate <NSObject>

- (void)shareView:(NNHShareView *)shareView didSelectedShareType:(NNHShareType)type;

@end

@interface NNHShareView : UIView

@property (nonatomic, weak) id <NNHShareViewDelegate> delegate;

// 默认分享类型
+ (instancetype)shareView;

// 显示分享视图
- (void)show;

@end
