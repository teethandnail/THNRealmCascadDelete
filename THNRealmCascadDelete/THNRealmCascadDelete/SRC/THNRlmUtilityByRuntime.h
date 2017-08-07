//
//  THNRlmUtilityByRuntime.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface THNRlmUtilityByRuntime : NSObject

/*!
 *  @author HonglinZhang, 17-03-28 17:03:51
 *
 *  @brief 删除realm对象
 *
 *  @param obj   需清空对象
 *  @param realm realm实例
 */
+ (void)deleteRlmObj:(id)obj realm:(RLMRealm*)realm;

/*!
 *  @author HonglinZhang, 17-08-07 16:03:51
 *
 *  @brief 删除数组里的所有值
 *
 *  @param results 需删除对象数组
 *  @param realm   realm实例
 */
+ (void)deleteRlmObjs:(id)results realm:(RLMRealm *)realm;

@end
