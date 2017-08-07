//
//  THNRlmUtilityByProtocol.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/8/7.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "RLMRealm+DeleteByProtocol.h"
#import "THNRlmCascadProtocol.h"

@implementation RLMRealm (DeleteByProtocol)

- (void)deleteRlmObj:(id)obj{
    if (obj && [(id <RlmCaseCadDelete>)obj respondsToSelector:@selector(caseCadDeleteInRealm:)]) {
        [(id <RlmCaseCadDelete>)obj caseCadDeleteInRealm:self];
    }
    
    if (obj) {
        [self deleteObject:obj];
    }
}

- (void)deleteRlmObjs:(id)results {
    for (id item in results) {
        [self deleteRlmObj:item];
    }
}

@end
