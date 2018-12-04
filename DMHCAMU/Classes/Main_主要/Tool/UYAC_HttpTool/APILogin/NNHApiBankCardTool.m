//
//  NNHApiBankCardTool.m
//  DMHCAMU
//
//  Created by 来旭磊 on 17/3/30.
//  Copyright © 2017年 牛牛汇. All rights reserved.
//

#import "NNHApiBankCardTool.h"

@implementation NNHApiBankCardTool

/** 获取用户绑定银行卡列表 */
- (instancetype)initBankCardList
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Banklist;
        self.reAPIName = @"获取用户绑定银行卡列表";
    }
    return self;
}

/** 根据银行卡号码识别对应银行 */
- (instancetype)initGetBankNameWithPreBankCardNum:(NSString *)bankNum
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.user.checkBankNumber";
        self.reAPIName = @"根据银行卡号码识别对应银行";
        self.reParams = @{
                          @"account_number"   : bankNum,
                          };
    }
    return self;
}

- (instancetype)initAddNewBankCardWithAccountType:(NSString *)account_type
                                     account_name:(NSString *)account_name
                                   account_number:(NSString *)account_number bank_type_name:(NSString *)bank_type_name
                                           branch:(NSString *)branch
                                           mobile:(NSString *)mobile
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_AddBank;
        self.reAPIName = @"添加银行卡";
        self.reParams = @{
                          @"account_type"   : account_type,
                          @"account_name"   : account_name,
                          @"account_number" : account_number,
                          @"bank_type_name" : bank_type_name,
                          @"branch"         : branch,
                          @"mobile"         : mobile,
                          };
    }
    return self;
}

/** 解绑银行卡操作 */
- (instancetype)initUnBankWithCardID:(NSString *)cardID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Unband;
        self.reAPIName = @"解绑银行卡";
        self.reParams = @{
                          @"bank_id"   : cardID,
                          };
    }
    return self;
}

- (instancetype)initAccountAddrechargeWithAmount:(NSString *)amount
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Addrecharge;
        self.reAPIName = @"提交加油请求";
        self.reParams = @{
                          @"amount"   : amount,
                          };
    }
    return self;
}

- (instancetype)initRechageResultDataWithOrderNum:(NSString *)orderNum
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Paystatus;
        self.reAPIName = @"加油结果页";
        self.reParams = @{
                          @"orderno"   : orderNum,
                          };
    }
    return self;
}

- (instancetype)initAccountAddBullRechargeWithCode:(NSString *)code
{
    self = [super init];
    if (self) {
        self.requestReServiceType = NNH_API_User_Rechargebull;
        self.reAPIName = @"牛豆加油请求";
        NSString *codeString = [NSString stringWithFormat:@"%@%@",code,NNHAPI_PRIVATEKEY_IOS];
        self.reParams = @{
                          @"recharge_code"   : code,
                          @"checkcode"       : [codeString md5String],
                          };
    }
    return self;
}


/** 提现申请界面 */
- (instancetype)initWithdrawData
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.withdrawals.index";
        self.reAPIName = @"提现申请界面";
    }
    return self;
}

/** 添加提现申请 */
- (instancetype)initWithAddWithdrawWithBankid:(NSString *)bankid
                                       paypwd:(NSString *)paypwd
                                       amount:(NSString *)amount
                                  accounttype:(NSString *)accountType
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.withdrawals.add";
        self.reAPIName = @"添加提现申请";
        self.reParams = @{
                          @"bankid" : bankid,
                          @"amount" : amount,
                          @"paypwd" : [paypwd md5String],
                          @"accountType" : accountType,
                          };
    }
    return self;
}

/** 用户提现列表 */
- (instancetype)initWithdrawListDataInDate:(NSString*)date page:(NSInteger)page
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.withdrawals.list";
        self.reAPIName = @"用户提现列表";
        
        if (!date) {
            date = @"";
        }
        
        self.reParams = @{
                          @"begintime" : date,
                          @"page" : [NSString stringWithFormat:@"%zd",page],
                         };
    }
    return self;
}

/** 用户提现详情 */
- (instancetype)initWithdrawDetailDataWithID:(NSString *)withdrawID
{
    self = [super init];
    if (self) {
        self.requestReServiceType = @"user.withdrawals.info";
        self.reAPIName = @"提现申请详情";
        self.reParams = @{
                          @"id" : withdrawID,
                          };
    }
    return self;
}




@end
