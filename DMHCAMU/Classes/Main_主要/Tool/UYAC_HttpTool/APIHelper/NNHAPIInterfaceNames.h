//
//  NNHAPIInterfaceNames.h
//  ElegantTrade
//
//  Created by 张佩 on 16/10/24.
//  Copyright © 2016年 雅活荟. All rights reserved.
//

#ifndef NNHAPIInterfaceNames_h
#define NNHAPIInterfaceNames_h


/* -------------------------------------------------------------------------------- */
#pragma mark - 用户相关  用户资料、登录注册
/** 获取手机号验证码 **/
static NSString *const NNH_API_Login_GetLoginCode = @"user.login.send";
/** 手机号验证码登陆 **/
static NSString *const NNH_API_NormalLogin = @"user.login.login";
/** 退出登录 **/
static NSString *const NNH_API_NormalLogout = @"user.login.signout";
/** 有订单数据的页面 **/
static NSString *const NNH_API_User_Index = @"user.index.main";
/** 我的资料页面数据 **/
static NSString *const NNH_API_User_MyInfo = @"user.user.index";
/** 我的资料设置 **/
static NSString *const NNH_API_User_UpdateInfo = @"user.user.updateInfo";
/** 获取修改手机的短信验证码 **/
static NSString *const NNH_API_User_GetChangeMobile = @"user.user.send";
/** 修改手机号 **/
static NSString *const NNH_API_User_UpdatePhone = @"user.user.updatePhone";
/** 修改支付密码 **/
static NSString *const NNH_API_SetupPayCode = @"user.user.updatePayPwd";
/** 设置支付密码 **/
static NSString *const NNH_API_SetPayCode = @"user.user.setPay";

/** 收货地址列表 **/
static NSString *const NNH_API_User_LogisticsList = @"user.logistics.logisticsList";
/** 设置默认收货地址 **/
static NSString *const NNH_API_User_SetDefaultlogistic = @"user.logistics.setDefaultlogistic";
/** 添加收货地址 **/
static NSString *const NNH_API_User_AddCustomerLogistic = @"user.logistics.addCustomerLogistic";
/** 编辑收货地址 **/
static NSString *const NNH_API_User_UpdateCustomerLogistic = @"user.logistics.updateCustomerLogistic";
/** 删除收货地址 **/
static NSString *const NNH_API_User_DelCustomerLogistic = @"user.logistics.delCustomerLogistic";
/* -------------------------------------------------------------------------------- */

#pragma mark - 实体店
/** 实体店首页数据 **/
static NSString *const NNH_API_Store_Index = @"stobusiness.index.index";
/** 切换城市 **/
static NSString *const NNH_API_Store_Index_GetCity = @"stobusiness.index.getCity";
/** 商家收款页面 **/
static NSString *const NNH_API_Store_Index_BusinessGathering = @"stobusiness.index.businessGathering";
/** 设置收款金额--商家收款 **/
static NSString *const NNH_API_Store_Index_SetGatherMonet = @"stobusiness.index.setGatherMonet";
/** 获取付款二维码--设置金额弹出二维码 **/
static NSString *const NNH_API_Store_Index_GetStoPayCode = @"stobusiness.index.getStoPayCode";
/** 设置付款金额--用户付款 **/
static NSString *const NNH_API_Store_Index_SetPayment = @"stobusiness.index.setPayMonet";



/** 实体店列表页获取商品列表 **/
static NSString *const NNH_API_Store_Search_Index = @"stobusiness.search.index";
/** 实体店列表页获取banner **/
static NSString *const NNH_API_Store_Search_BannerList = @"stobusiness.search.bannerList";
/** 实体店列表页获取分类 **/
static NSString *const NNH_API_Store_Search_CategoryList = @"stobusiness.search.categoryList";
/** 实体店列表页城市列表 **/
static NSString *const NNH_API_Store_Search_Getlocalcity = @"stobusiness.search.getlocalcity";
/** 实体店详情页 **/
static NSString *const NNH_API_Store_PhysicalShop_ShopDetails = @"stobusiness.physicalShop.shopDetails";
/** 实体店获取评论列表 **/
static NSString *const NNH_API_Store_PhysicalShop_CommentList = @"stobusiness.physicalShop.commentList";
/** 用户投诉 **/
static NSString *const NNH_API_Store_PhysicalShop_WriteComment = @"stobusiness.physicalShop.writeComment";
/** 用户评论 **/
static NSString *const NNH_API_Store_PhysicalShop_WriteProposal = @"stobusiness.physicalShop.writeProposal";
/** 用户下单支付 **/
static NSString *const NNH_API_Store_Addpayfollow = @"stobusiness.index.addpayfollow";
/** 用户支付结果订单详情 **/
static NSString *const NNH_API_Store_StoreOrderDetail = @"stobusiness.index.stoOrderDetail";

/* -------------------------------------------------------------------------------- */
#pragma mark - 商城首页
/** 获取商城首页商品列表  **/
static NSString *const NNH_API_Mall_indexGoodslist = @"mall.index.indexGoodslist";
/** 商城所有分类列表  **/
static NSString *const NNH_API_Mall_indexCategory = @"mall.index.indexCategory";
/** 商城首页获取banner图片和快捷方式 **/
static NSString *const NNH_API_Mall_indexBannerAndSaleway = @"mall.index.indexBannerAndSaleway";
/** 商城首页获取公告和活动 **/
static NSString *const NNH_API_Mall_indexAnnounAndActive = @"mall.index.indexAnnounAndActive";
/** 分类下商品列表 **/
static NSString *const NNH_API_Mall_CategoryGoodsList = @"mall.index.categoryGoodsList";
/* -------------------------------------------------------------------------------- */
#pragma mark - 商品模块
/** 获取商品评价信息  **/
static NSString *const NNH_API_Product_Evaluate = @"product.index.goodsEvaluate";
/** 商品搜索  **/
static NSString *const NNH_API_Product_Search = @"product.search.index";
/** 商品详情  **/
static NSString *const NNH_API_Product_GoodsDetail = @"product.index.goodsDetail";

/* -------------------------------------------------------------------------------- */
#pragma mark - 订单
/** 获取订单列表  **/
static NSString *const NNH_API_Order_List = @"order.index.orderlist";
/** 提交订单前的预览订单  **/
static NSString *const NNH_API_Order_showOrder = @"order.index.showorder";
/** 提交订单  **/
static NSString *const NNH_API_Order_addOrder = @"order.index.addorder";
/** 订单详情  **/
static NSString *const NNH_API_Order_orderDetail= @"order.index.orderdetail";
/** 取消订单  **/
static NSString *const NNH_API_Order_cancleOrder = @"order.index.cancelsorder";
/** 确认收货  **/
static NSString *const NNH_API_Order_confirmOrder = @"order.index.confirmorder";
/** 订单延长收货  **/
static NSString *const NNH_API_Order_extendedreceipt = @"order.index.extendedreceipt";
/** 提醒商家发货  **/
static NSString *const NNH_API_Order_remindshipping = @"order.index.remindshipping";
/** 删除订单  **/
static NSString *const NNH_API_Order_deleteorder = @"order.index.deleteorder";
/** 评价订单详情  **/
static NSString *const NNH_API_Order_evaluateOrderInfo = @"order.evaluateorder.EvaluateOrderInfo";
/** 添加订单评价  **/
static NSString *const NNH_API_Order_addEvaluateOrder = @"order.evaluateorder.addEvaluateOrder";
/** 查询最新的一条快递信息  **/
static NSString *const NNH_API_Order_getExpress = @"order.express.getExpress";
/** 获得快递信息列表  **/
static NSString *const NNH_API_Order_getExpressList = @"order.express.getExpressList";

/* -------------------------------------------------------------------------------- */
#pragma mark - 支付
/** 余额支付判断账户余额是否足够  **/
static NSString *const NNH_API_Pay_Checkbalance = @"pay.pay.checkbalance";
/** 余额支付  **/
static NSString *const NNH_API_Pay_Balancepay = @"pay.pay.balancepay";



/* -------------------------------------------------------------------------------- */
#pragma mark - 退款相关
/** 退款/退货申请  **/
static NSString *const NNH_API_Order_refundsalerefund = @"order.refund.refersaleapply";
/** 退款/退货详情  **/
static NSString *const NNH_API_Order_refundinfo = @"order.refund.refundinfo";
/** 用户取消退款/退货申请操作 **/
static NSString *const NNH_API_Order_refundcancleapply = @"order.refund.cancleapply";
/** 协商历史 **/
static NSString *const NNH_API_Order_refundconsulelog = @"order.refund.consulelog";
/** 退款/退货列表 **/
static NSString *const NNH_API_Order_refundreturnlist = @"order.refund.returnlist";
/** 退款成功 以及关闭退款 详情页 **/
static NSString *const NNH_API_Order_refundotherinfo = @"order.refund.refundotherinfo";


/* -------------------------------------------------------------------------------- */
#pragma mark - 实体店首页
/** 获取订单列表  **/
static NSString *const NNH_API_Business_Home = @"business.index.home";
/** 获取实体店所有宝贝  **/
static NSString *const NNH_API_Business_GoodsList = @"business.index.goodsList";
/** 筛选实体店所有宝贝  **/
static NSString *const NNH_API_Business_SearchGoods = @"business.index.searchGoods";
/** 获取商铺分类列表  **/
static NSString *const NNH_API_Business_GetBusinessCategory = @"business.Category.getBusinessCategory";

/** 获取专区页面上数据  **/
static NSString *const NNH_API_Business_PrefeatureIndex = @"Saleway.index.index";

/* -------------------------------------------------------------------------------- */
#pragma mark - 购物车模块

/** 获取购物车列表  **/
static NSString *const NNH_API_Shopcart_Goodslist = @"shopingcart.index.goodslist";
/** 添加商品  **/
static NSString *const NNH_API_Shopcart_Addgoods = @"shopingcart.index.addgoods";
/** 修改购物车数量  **/
static NSString *const NNH_API_Shopcart_UpdateCartNum = @"shopingcart.index.updateCartNum";
/** 删除购物车 **/
static NSString *const NNH_API_Shopcart_Delgoods = @"shopingcart.index.delgoods";
/** 获取购物车商品规格 **/
static NSString *const NNH_API_Shopcart_ChoseGoosSpec = @"shopingcart.index.choseGoosSpec";

/* -------------------------------------------------------------------------------- */


#pragma mark ----------评论相关
/** 所有评论列表 (商品) **/
static NSString *const NNH_API_ProductEvaluateList = @"product.index.goodsEvaluate";

#pragma mark - 我的
/** 我的银行卡列表 **/
static NSString *const NNH_API_User_Banklist = @"user.user.banklist";
/** 添加银行卡操作 **/
static NSString *const NNH_API_User_AddBank = @"user.user.addbank";
/** 解绑银行卡操作 **/
static NSString *const NNH_API_User_Unband = @"user.user.unband";
/** 账户现金加油请求 **/
static NSString *const NNH_API_User_Addrecharge = @"user.recharge.addrecharge";
/** 账户加油支付结果 **/
static NSString *const NNH_API_User_Paystatus = @"pay.pay.paystatus";
/** 账户牛豆加油 **/
static NSString *const NNH_API_User_Rechargebull = @"user.recharge.rechargebull";


/* -------------------------------------------------------------------------------- */
#pragma mark - 本地链接
/** 版本历史介绍  **/
static NSString *const NNH_API_MyCreditAgreement = @"Introduction/Index/creditdeal";
/** 注册协议 **/
static NSString *const NNH_API_MemberAgreement = @"Introduction/index/registDeal";
/** 抵扣金获取和使用规则 **/
static NSString *const NNH_API_Bonus_introduction = @"Introduction/Index/bonusUseRule";
/** 企业账户介绍 **/
static NSString *const NNH_API_BusAccountIntro = @"Introduction/index/BusAccountIntro";
/** 商家介绍 **/
static NSString *const NNH_API_NSIntroduction = @"Introduction/index/cattleBusiness";
/** 实体店介绍 **/
static NSString *const NNH_API_NZGIntroduction = @"Introduction/index/cowShopkeepe";
/** 币种介绍 **/
static NSString *const NNH_API_CurrencyIntroduction = @"Introduction/Index/balanceintro";
/** 推广说明 **/
static NSString *const NNH_API_RegisterSpread = @"Introduction/index/registerSpread";
/** 消费者说明 **/
static NSString *const NNH_API_NF_introduction = @"Introduction/Index/niufunintro";
/** 货款介绍 **/
static NSString *const NNH_API_NS_Receivedgoodsintro = @"Introduction/Index/receivedgoodsintro";
/** roleManage **/
static NSString *const NNH_API_NF_RoleManage = @"Customer/Index/becomeTarent";
/** 社群介绍 **/
static NSString *const NNH_API_Community_introduction = @"Introduction/Index/groupNiudaren";
/** NBTPay **/
static NSString *const NNH_API_Block_Pay = @"/Sys/Pay/currencylist";
/** 会员中心NBT **/
static NSString *const NNH_API_Block_User = @"/user/currency/coinlist?";

#endif /* NNHAPIInterfaceNames_h */
