# THNRealmCascadDelete

## 背景说明：

Realm数据库有一个缺陷是删除一个表时，不能把该表涉及到的别的表数据删除干净。如下示例：

订单表 RLMOrder：

| 字段名 | 类型 | 
| --- | --- | 
| orderNum | NSUInteger |
| commoditiesArray| RLMArray -RLMCommodity| 
| privilege|RLMPrivilege|


购物商品表 RLMCommodity：

| 字段名 | 类型 | 
| --- | --- | 
| name | NSString |
| ID| NSUInteger| 
| quantity|CGFloat|
| price|CGFloat|

优惠表 RLMPrivilege：

| 字段名 | 类型 | 
| --- | --- | 
| ID | NSUInteger |
| price| CGFloat|

```
RLMOrder *order = [[RLMOrder alloc] init];
order.commoditiesArray = @[RLMCommodityA,RLMCommodityB];
order.privilege = RLMPrivilegeA;
```

当执行 [Realm deleteObject:order] 后，order成功删除，但RLMCommodityA、RLMCommodityB、RLMPrivilegeA还存在商品表和优惠表中，没有删除干净。

## 功能说明
该工程提供Realm级联删除功能，删除order时能把RLMCommodityA、RLMCommodityB、RLMPrivilegeA连带着删除。工程里提供了两种实现：
1. 通过runtime判断order有哪些属性是表对象，是的话递归进去删除属性中的表实例；
2. 增加级联删除协议，所有的表都实现该删除协议，协议里的删除方法删除自身属性中的表






