//
//  THNRlmDiscountModel.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import <Realm/Realm.h>

@interface THNRlmDiscountModel : RLMObject

@property NSString *name;

@property NSString *price;

+ (instancetype)createWithName:(NSString *)name; 

@end
