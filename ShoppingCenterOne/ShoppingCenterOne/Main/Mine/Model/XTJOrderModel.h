//
//  XTJOrderModel.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/13.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTJOrderModel : NSObject
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *product_pic;
@property (nonatomic,strong) NSString *product_name;
@property (nonatomic,strong) NSString *price;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *address;
@property (nonatomic,strong) NSString *user_name;
@property (nonatomic,strong) NSString *receiver_name;
@property (nonatomic,strong) NSString *receiver_phone;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *status;


@end


//"order_id": "153387273118169833a5c-4",      //订单号
//"user_id": "cus15963215489",
//"product_pic": "https://gd1.alicdn.com/imgextra/i3/1715535627/TB2KJwxdrwrBKNjSZPcXXXpapXa_!!1715535627.jpg_400x400.jpg",                            //商品图
//"product_name": "品品逗嘴麻辣小鸡腿鸡翅根2袋 即食鸡肉类卤味熟食小包装零食小吃",                          //商品名
//"price": 16,                  //单价
//"num": 2,                   //购买数量
//"total": 32,                  //合计
//"address": "南京路",          //收货地址
//"user_name": "Luis",
//"receiver_name": "刘",          //收货人姓名
//"receiver_phone": "1593258954",  //收货人电话
//"date": "2018-08-10 11:45:31",     //创建时间
//"type": 0,                      //订单支付状态
//"status": 0                     //是否被删除
