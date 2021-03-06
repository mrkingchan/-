//
//  NNHRequestError.h
//  DMHCAMU
//
//  Created by 牛牛 on 2017/3/3.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import <Foundation/Foundation.h>

// 这个枚举与服务端的错误码一一对应,下面是那个是所有服务端错误的编码
typedef NS_ENUM(NSInteger ,NNHErrorCode){
    //'200'=>'操作成功',
    NNHRequestSucess = 200,
    //'201'=>'操作失败',
    NNHRequestFailed = 201,
    //'101'=>'传入参数错误',
    NNHRequestParamsError = 101,
    
};

@interface NNHRequestError : NSObject

/** 错误编码 **/
@property (nonatomic, assign) NNHErrorCode errorCode;
/** 错误reason **/
@property (nonatomic, copy) NSString *errorReason;
/** ApiName **/
@property (nonatomic, copy) NSString *errorApiName;
/** 转化成错误码之前的NSError **/
@property (nonatomic, strong)  NSError *errrorOringin;

/** 错误描述 **/
- (NSString *)printErrorInfo;

@end



//'200'=>'操作成功',
//'201'=>'操作失败',
//'101'=>'传入参数错误',
//'102'=>'订单总金额错误',
//'103'=>'传入商品规格错误',
//'104'=>'{reason}，请重新登录',
//'105'=>'未获取到该商品信息',
//'106'=>'未查询到订单信息',
//'107'=>'订单信息有误',
//'108'=>'该商品已下架',
//'109'=>'您不能删除该购物车商品信息',
//'110'=>'该购物车商品信息不存在或已被删除',
//'111'=>'插入数据失败',
//'112'=>'修改数据失败',
//'113'=>'您不能修改该购物车商品信息',
//'114'=>'订单状态异常，不能支付',
//'115'=>'添加会员用户失败',
//'116'=>'商品金额错误',
//'117'=>'订单金额错误',
//'118'=>'商品不可销售，{reason}',//
//'119'=>'未找到套餐信息 ',//
//'120'=>'商家不能使用套餐',
//'121'=>'退货数量错误',
//'122'=>'未添加退货信息',
//'123'=>'代金券不可用',
//'124'=>'未获取到代金券',
//'125'=>'代金券不在使用时间范围内',//
//'126'=>'用户名或密码错误',
//'127'=>'密码不能为空',
//'128'=>'用户名或密码错误',
//'129'=>'未获取到该商品规格信息',
//
//
//
//
//
//'130'=>'会员用户名已存在',//
//'131'=>'添加会员用户关系失败',
//'132'=>'会员用户名不能为空',
//'133'=>'会员用户名不能修改',
//'134'=>'该数据不属于当前会员用户',
//'135'=>'退货数量错误',
//'136'=>'优惠券使用错误',
//'137'=>'未指明查询表',
//'138'=>'未获取到用户',
//'139'=>'用户手机号码不能为空',
//'140'=>'验证码错误',
//'141'=>'发送验证码失败',
//'142'=>'验证结果已失效，请重新获取验证码',
//
//"150"=>'管理员用户id不能为空',
//"151"=>'反馈内容不能为空',
//"152"=>'反馈id不能为空',
//"153"=>'回复反馈内容不能为空',
//
////base
//"210"=>'校验数组为空，请引入CodeArray内校验数组或传入校验数组',
//"211"=>'执行数组为空，请构建执行数组',
//
//
////自动分单
//"220"=>'该订单已存在于自动分单缓冲池，请勿重复添加',
//"221"=>'订单号不存在，请勿传入空订单',
//"223"=>'没有未分配的发货订单',
//
////收藏功能
//"281"=>'收藏类型不能为空',
//"282"=>'收藏id不能为空',
//"283"=>'请勿重复收藏',
//"284"=>'删除id不能为空',
//
////支付
//'301'=>'系统不支持该支付方式',
//'302'=>'该订单不存在',
//'303'=>'该api文件不存在',
//'304'=>'请勿提交非法参数',
//'305'=>'验证失败',
//'306'=>'参数验证失败',
//'307'=>'该订单已支付',
//'308'=>'提交的支付金额和必须支付的实际金额不同',
//
////第三方登录
//'601'=> '不能进行跨站请求',
//'602'=> '授权失败',
//'603'=> '没有该第三方登录方式',
//'604'=> '该第三方登录没有开启',
//
//'501' => '文章信息不存在',
//'502' => '文章id不能为空',
//'503' => '分类信息不存在',
//'504' => '没有数据了',
//'505' => '分类id不能为空',
//'506' => '评论id不能为空',
//'507' => '评论内容不能为空',
//'508' => '用户id不能为空',
//'509' => '回复内容不能为空',
//'510' => '搜索标题不能为空',
//'511' => '省份code不能为空',
//'512' => '城市code不能为空',
//
//
////搜索
//'3001'=>'关键词不能为空',
//'3999'=>'',
//
////站内消息
//'4001'=>'',
//'4999'=>'',
//
///发送
//'5001'=>"邮箱不能为空",
//'5999'=>"",
//
////优惠券
//'7001'=>"该优惠券您已经领取过",
//'7002'=>"该优惠券已经领取完了",
//'7003'=>"该优惠券还不能领取",
//);
