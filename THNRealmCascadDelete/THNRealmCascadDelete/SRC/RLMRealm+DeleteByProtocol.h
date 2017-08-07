//
//  THNRlmUtilityByProtocol.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/8/7.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface RLMRealm (DeleteByProtocol)

/*!
 *  @author HonglinZhang, 17-08-07 17:10:51
 *
 *  @brief 删除realm对象
 *
 *  @param obj   需清空对象
 */
- (void)deleteRlmObj:(id)obj;

/*!
 *  @author HonglinZhang, 17-08-07 17:10:51
 *
 *  @brief 删除realm对象数组
 *
 *  @param results 需删除的对象数组
 */
- (void)deleteRlmObjs:(id)results;

@end
