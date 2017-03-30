//
//  THNRlmUtility.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface THNRlmUtility : NSObject

/*!
 *  @author HonglinZhang, 17-03-28 17:03:51
 *
 *  @brief 清空realm对象的所有存储值
 *
 *  @param obj   需清空对象
 *  @param realm realm实例
 */
+ (void)cleanRlmObj:(id)obj realm:(RLMRealm*)realm;

@end
