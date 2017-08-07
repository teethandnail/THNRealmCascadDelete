//
//  THNRlmTicketModel.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//
#import "THNRlmTicketModel.h"

@implementation THNRlmTicketModel

+ (instancetype)createWithName:(NSString *)name {
    THNRlmTicketModel *model = [[THNRlmTicketModel alloc] init];
    model.ticketName = name;
    model.price = @"9.9";
    return model;
}

#pragma mark - RlmCaseCadDelete

- (void)caseCadDeleteInRealm:(RLMRealm *)realm {
}

@end
