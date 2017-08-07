//
//  THNRlmOrderModel.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "THNRlmOrderModel.h"

@implementation THNRlmOrderModel

+ (instancetype)createWithNumber:(NSString *)number discountName:(NSString *)discountName ticketNameArray:(NSArray*)ticketNameArray {
    
    THNRlmOrderModel *order = [[THNRlmOrderModel alloc] init];
    order.orderNumber = number;
    order.consumeType = 1;
    order.price = @(5.5);
    order.count = @(9);
    
    order.discount = [THNRlmDiscountModel createWithName:discountName];
    for (NSString *item in ticketNameArray) {
        [order.ticketArray addObject:[THNRlmTicketModel createWithName:item]];
    }
    
    return order;
}


#pragma mark - RlmCaseCadDelete

- (void)caseCadDeleteInRealm:(RLMRealm *)realm {
    if (self.discount && [self.discount respondsToSelector:@selector(caseCadDeleteInRealm:)]) {
        [self.discount caseCadDeleteInRealm:realm];
        
        [realm deleteObject:self.discount];
    }
    
    if (self.ticketArray.count) {
        for (THNRlmTicketModel *item in self.ticketArray) {
            if ([item respondsToSelector:@selector(caseCadDeleteInRealm:)]) {
                [item caseCadDeleteInRealm:realm];
            }
        }
        
        [realm deleteObjects:self.ticketArray];
    }
}

@end
