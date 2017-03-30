//
//  THNRlmUtility.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "THNRlmUtility.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation THNRlmUtility

+ (void)cleanRlmObj:(id)obj realm:(RLMRealm*)realm {
    [THNRlmUtility cleanObj:obj class:[obj superclass] realm:realm isSupperClass:NO];
}

+ (void)cleanObj:(id)obj class:(Class)class realm:(RLMRealm *)realm isSupperClass:(BOOL)isSupperClass {
    if (!obj || !class || !realm) {
        return;
    }
    
    if (![THNRlmUtility classNeedHandle:class]) {
        return;
    }
    
    // 删除property中自定义realm model里的值
    unsigned int count =0;
    Ivar *vars = class_copyIvarList(class, &count);
    
    for(int i = 0; i < count; i++) {
        Ivar ivar= vars[i];
        const char *propertyTypeChar = ivar_getTypeEncoding(ivar);
        if ([THNRlmUtility properTypeNeedHandleChar:propertyTypeChar]) {
            const char *nameChar = ivar_getName(ivar);
            if (strlen(nameChar) < 2) {
                return;
            }
            
            SEL sel = sel_registerName(&nameChar[1]);
            id subObj = objc_msgSend(obj, sel); // 需在设置中“enable strict checking of objc_msgsend calls”选项改成NO，否则会预编译会报错
            
            if ([subObj isKindOfClass:[RLMArray class]]) {
                RLMArray *subObjArray = subObj;
                for (id item in subObjArray) {
                    [self cleanObj:item class:[item class] realm:realm isSupperClass:NO];
                }
            } else if (![subObj isKindOfClass:[NSNumber class]]){ // 数值类型此处判断，properTypeNeedHandleChar解析比较繁琐
                [self cleanObj:subObj class:[subObj class] realm:realm isSupperClass:NO];
            }
        }
    }
    
    free(vars);
    
    // 删除父类的property值    
    [self cleanObj:obj class:class_getSuperclass(class) realm:realm isSupperClass:YES];
    
    if (!isSupperClass) {
        [realm deleteObject:obj];
    }
}

+ (BOOL)classNeedHandle:(Class)cls {
    static Class realmClass = nil;
    if (!realmClass) {
        realmClass = [RLMObject class];
    }
    
    if (!cls || cls == realmClass) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)properTypeNeedHandleChar:(const char *)type {
    static char *stringType = "@\"NSString\"";
    static char *datetType = "@\"NSDate\"";
    static char *dataType = "@\"NSData\"";
    
    unsigned long length = strlen(type);
    if (length == 1) {
        return NO;
    } else if ([self isCharEqual:type length:length target:stringType]
               || [self isCharEqual:type length:length target:datetType]
               || [self isCharEqual:type length:length target:dataType]) {
        return NO;
    }
    
    return YES;
}

+ (BOOL)isCharEqual:(const char *)type length:(unsigned long)length target:(char *)target{
    if (length != strlen(target)) {
        return NO;
    }
    
    for (int idx = 0; idx < length; idx++) {
        if (type[idx] != target[idx]) {
            return NO;
        }
    }
    
    return YES;
}

+ (BOOL)properTypeNeedHandle:(NSString *)type {
    static NSSet *propertyTypeSet = nil;
    if (!propertyTypeSet) {
        propertyTypeSet = [NSSet setWithObjects:@"@\"NSString\"",@"@\"NSDate\"",@"@\"NSData\"", nil];
    }
    
    if (type.length <= 1 //propertyType.length == 1 的为基本类型
        || [propertyTypeSet containsObject:type]) {
        return NO;
    }

    return YES;
}

@end
