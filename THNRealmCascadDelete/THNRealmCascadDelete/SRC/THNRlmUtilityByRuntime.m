//
//  THNRlmUtilityByRuntime.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "THNRlmUtilityByRuntime.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation THNRlmUtilityByRuntime

+ (void)deleteRlmObj:(id)obj realm:(RLMRealm *)realm {
    [THNRlmUtilityByRuntime deleteInRuntime:obj class:[obj superclass] realm:realm];
    [realm deleteObject:obj];
}

+ (void)deleteRlmObjs:(id)results realm:(RLMRealm *)realm {
    for (id item in results) {
        [[self class] deleteRlmObj:item realm:realm];
    }
}

+ (void)deleteInRuntime:(id)obj class:(Class)class realm:(RLMRealm *)realm {
    if (!obj || !class || !realm) {
        return;
    }
    
    if (![THNRlmUtilityByRuntime classNeedHandle:class]) {
        return;
    }
    
    // 1. 删除当前类的属性表实例
    // 2. 如果是多层继承，删除父类的属性表实例
    
    // 1. 删除当前类的属性表实例
    unsigned int count =0;
    Ivar *vars = class_copyIvarList(class, &count);
    
    for(int i = 0; i < count; i++) {
        Ivar ivar= vars[i];
        const char *propertyTypeChar = ivar_getTypeEncoding(ivar);
        if ([THNRlmUtilityByRuntime properTypeNeedHandleChar:propertyTypeChar]) {
            const char *nameChar = ivar_getName(ivar);
            if (strlen(nameChar) < 2) {
                continue;
            }
            
            NSString *nameStr = [NSString stringWithUTF8String:&nameChar[1]];
            id subObj = [obj valueForKey:nameStr];
            
            if ([subObj isKindOfClass:[RLMArray class]]) {
                RLMArray *subObjArray = subObj;
                for (id item in subObjArray) {
                    [self deleteRlmObj:item  realm:realm];
                }
            } else if (![subObj isKindOfClass:[NSNumber class]]){ // 数值类型此处判断，在properTypeNeedHandleChar解析比较繁琐
                [self deleteRlmObj:subObj realm:realm];
            }
        }
    }
    
    free(vars);
    
    // 2. 删除父类的属性表实例
    [self deleteInRuntime:obj class:class_getSuperclass(class) realm:realm];
}

#pragma mark - Utility

+ (BOOL)classNeedHandle:(Class)cls {    
    if (!cls || cls == [RLMObject class]) {
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

@end
