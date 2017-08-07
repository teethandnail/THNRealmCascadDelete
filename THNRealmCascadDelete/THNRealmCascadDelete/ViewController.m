//
//  ViewController.m
//  THNRealmCascadDelete
//
//  Created by ZhangHonglin on 2017/3/30.
//  Copyright © 2017年 h.enc. All rights reserved.
//

#import "ViewController.h"
#import "THNRealm.h"
#import "THNRlmOrderModel.h"
#import "THNRlmUtilityByRuntime.h"
#import "RLMRealm+DeleteByProtocol.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createData:(id)sender {
    THNRlmOrderModel *model = [THNRlmOrderModel createWithNumber:@"201758558" discountName:@"整单折扣" ticketNameArray:@[@"买二赠一",@"买三赠一"]];
    
    THNRealm *realm = [THNRealm defaultCashier];
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [realm addObject:model];
    } error:&error];
    
    if (error) {
        NSLog(@"insert error : %@", error);
    }
    
    NSLog(@"当前数据条数:");
    [self printRlmCount];
}

- (IBAction)clearData:(id)sender {
    THNRealm *realm = [THNRealm defaultCashier];
    RLMResults *result = [THNRlmOrderModel allObjectsInRealm:realm];
    
    NSLog(@"删除之前条数:");
    [self printRlmCount];
    
    // 运行时删除
    [self deleteByRunTime:realm rlmResult:result];
    
//    // 协议删除
//    [self deleteByProtocol:realm rlmResult:result];
//    
//    // Realm 默认的删除方法，有BUG
//    [self deleteByDefault:realm rlmResult:result];
    
    NSLog(@"删除之后条数:");
    [self printRlmCount];
}

#pragma mark - Delete Functions

- (void)deleteByRunTime:(THNRealm *)realm rlmResult:(RLMResults *)result {
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [THNRlmUtilityByRuntime deleteRlmObjs:result realm:realm];
    } error:&error];
    
    if (error) {
        NSLog(@"delete error : %@", error);
    }
}

- (void)deleteByProtocol:(THNRealm *)realm rlmResult:(RLMResults *)result {
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [realm deleteRlmObjs:result];
    } error:&error];
    
    if (error) {
        NSLog(@"delete error : %@", error);
    }
}

- (void)deleteByDefault:(THNRealm *)realm rlmResult:(RLMResults *)result {
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [realm deleteObjects:result];
    } error:&error];
    
    if (error) {
        NSLog(@"delete error : %@", error);
    }
}

#pragma mark - Utility

- (void)printRlmCount {
    
    THNRealm *realm = [THNRealm defaultCashier];
    RLMResults *order = [THNRlmOrderModel allObjectsInRealm:realm];
    RLMResults *ticket = [THNRlmTicketModel allObjectsInRealm:realm];
    RLMResults *discount = [THNRlmDiscountModel allObjectsInRealm:realm];
    
    NSLog(@"RLMOrder Row Count : %zi", order.count);
    NSLog(@"RlmTicket Row Count : %zi", ticket.count);
    NSLog(@"RlmDiscount Row Count : %zi\n\n", discount.count);
}

@end
