//
//  THNRealm
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Realm/Realm.h>

@interface THNRealm : RLMRealm

+ (instancetype)defaultCashier;

+ (void)cashierRealmDBMigration;

THNRealm *defaultCashier();

@end
