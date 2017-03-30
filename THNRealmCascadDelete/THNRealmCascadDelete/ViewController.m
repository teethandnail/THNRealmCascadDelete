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
#import "THNRlmUtility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)createData:(id)sender {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"沙盒位置: %@", paths[0]);
    
    THNRlmOrderModel *model = [THNRlmOrderModel createWithNumber:@"201758558" discountName:@"整单折扣" ticketNameArray:@[@"买二赠一",@"买三赠一"]];
    
    THNRealm *realm = [THNRealm defaultCashier];
    NSError *error = nil;
    [realm transactionWithBlock:^{
        [realm addObject:model];
    } error:&error];
    
    if (error) {
        NSLog(@"insert error : %@", error);
    }
}

- (IBAction)clearData:(id)sender {
    THNRealm *realm = [THNRealm defaultCashier];
    RLMResults *result = [THNRlmOrderModel allObjectsInRealm:realm];
    
    NSError *error = nil;
    [realm transactionWithBlock:^{
        for (THNRlmOrderModel *item in result) {
            [THNRlmUtility cleanRlmObj:item realm:realm];
        }
    } error:&error];
    
    if (error) {
        NSLog(@"delete error : %@", error);
    } else {
        NSLog(@"delete success");
    }
}

@end
