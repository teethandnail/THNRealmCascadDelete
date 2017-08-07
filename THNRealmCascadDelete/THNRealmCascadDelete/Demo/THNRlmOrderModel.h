//
//  THNRlmOrderModel.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Realm/Realm.h>
#import "THNRlmDiscountModel.h"
#import "THNRlmTicketModel.h"
#import "THNRlmCascadProtocol.h"

@interface THNRlmOrderModel : RLMObject <RlmCaseCadDelete>

@property  NSString *orderNumber;

@property  int consumeType;

@property NSNumber<RLMFloat> *price;

@property NSNumber<RLMInt> *count;

@property THNRlmDiscountModel *discount;

@property RLMArray<THNRlmTicketModel *><THNRlmTicketModel>*ticketArray;

+ (instancetype)createWithNumber:(NSString *)number discountName:(NSString *)discountName ticketNameArray:(NSArray*)ticketNameArray;

@end
