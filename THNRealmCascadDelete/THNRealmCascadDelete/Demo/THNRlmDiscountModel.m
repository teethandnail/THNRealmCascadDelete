//
//  THNRlmDiscountModel.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "THNRlmDiscountModel.h"

@implementation THNRlmDiscountModel

+ (instancetype)createWithName:(NSString *)name {
    THNRlmDiscountModel *model = [[THNRlmDiscountModel alloc] init];
    model.name = name;
    model.price = @"5.5";
    return model;
}

#pragma mark - RlmCaseCadDelete

- (void)caseCadDeleteInRealm:(RLMRealm *)realm {
}

@end
