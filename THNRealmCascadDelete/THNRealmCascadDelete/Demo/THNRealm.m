//
//  THNRealm
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "THNRealm.h"

static RLMRealmConfiguration *_THNRealmConfig;

@implementation THNRealm

+ (void)initialize {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path =  [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Demo.realm"];
    
    _THNRealmConfig = [[RLMRealmConfiguration alloc] init];
    _THNRealmConfig.fileURL = [NSURL fileURLWithPath:path isDirectory:YES];

    _THNRealmConfig.objectClasses = @[NSClassFromString(@"THNRlmDiscountModel"),
                                      NSClassFromString(@"THNRlmOrderModel"),
                                      NSClassFromString(@"THNRlmTicketModel")];
}

+ (void)cashierRealmDBMigration {
    _THNRealmConfig.schemaVersion = 1;
    _THNRealmConfig.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
    };
}

+ (instancetype)defaultCashier {
    return [THNRealm realmWithConfiguration:_THNRealmConfig error:nil];
}

THNRealm *defaultCashier() {
    return [THNRealm defaultCashier];
}

@end


