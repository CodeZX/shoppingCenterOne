//
//  userModel.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/8.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userModel : NSObject
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic,strong) NSString *phone_num;
@property (nonatomic,strong) NSString *pwd;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *profile_pic;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *birthday;

@end



//"user_id": "cus13886981439",   //用户id
//"phone_num": "13886981439",  //手机号
//"pwd": "123456",             //密码
//"profile_pic": "",              //头像
//"name": "用户13886981439",   //用户名
//"sex": "",                     //性别
//"birthday": ""
