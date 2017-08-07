//
//  THNRlmCascadProtocol.h
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/8/7.
//  Copyright © 2017年 h.enc. All rights reserved.
//

@class RLMRealm;

@protocol RlmCaseCadDelete <NSObject>

@required

- (void)caseCadDeleteInRealm:(RLMRealm *)realm;

@end
