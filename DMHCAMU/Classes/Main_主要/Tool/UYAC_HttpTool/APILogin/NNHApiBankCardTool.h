//
//  NNHApiBankCardTool.h
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/30.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHBaseRequest.h"

@interface NNHApiBankCardTool : NNHBaseRequest

/** 获取用户绑定银行卡列表 */
- (instancetype)initBankCardList;

/** 根据银行卡号码识别对应银行 */
- (instancetype)initGetBankNameWithPreBankCardNum:(NSString *)bankNum;

/**
 (添加银行卡

 @param account_type 账户类型(1为个人 2为公司)
 @param account_name 银行开户名
 @param account_number [银行帐号
 @param bank_type_name 开户银行名称
 @param branch 开户行支行
 @param mobile 手机号码
 @return 请求操作类
 */
- (instancetype)initAddNewBankCardWithAccountType:(NSString *)account_type
                                     account_name:(NSString *)account_name
                                   account_number:(NSString *)account_number bank_type_name:(NSString *)bank_type_name
                                           branch:(NSString *)branch
                                           mobile:(NSString *)mobile;

/** 解绑银行卡操作 */
- (instancetype)initUnBankWithCardID:(NSString *)cardID;


/**
 账户现金加油请求

 @param amount 加油金额
 @return 请求类
 */
- (instancetype)initAccountAddrechargeWithAmount:(NSString *)amount;


/**
 获取加油结果

 @param orderNum 订单编号
 @return 请求类
 */
- (instancetype)initRechageResultDataWithOrderNum:(NSString *)orderNum;


/**
 牛豆加油

 @param code 加油卡号
 @return 请求类
 */
- (instancetype)initAccountAddBullRechargeWithCode:(NSString *)code;

/** 体现申请界面 */
- (instancetype)initWithdrawData;

/** 添加提现申请 */
- (instancetype)initWithAddWithdrawWithBankid:(NSString *)bankid
                                       paypwd:(NSString *)paypwd
                                       amount:(NSString *)amount
                                  accounttype:(NSString *)accountType;

/** 用户提现列表 */
- (instancetype)initWithdrawListDataInDate:(NSString*)date page:(NSInteger)page;

/** 用户提现详情 */
- (instancetype)initWithdrawDetailDataWithID:(NSString *)withdrawID;

@end
