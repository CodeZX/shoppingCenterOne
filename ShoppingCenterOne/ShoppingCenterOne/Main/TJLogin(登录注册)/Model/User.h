//
//  User.h
//  HKZJ_IPhone
//
//  Created by mac on 16/5/11.
//  Copyright (c) 2016年 Edgar_guan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface User : NSObject <NSCoding>
@property (nonatomic, strong) NSString *two_dir_id;
@property (nonatomic, strong) NSString *user_type;
@property (nonatomic, strong) NSString *pwd;
@property (nonatomic, strong) NSString *area_name;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *decorative_name;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *num_read;
@property (nonatomic, strong) NSString *real_name;
@property (nonatomic, strong) NSString *nick_name;
@property (nonatomic, strong) NSString *weixin;
@property (nonatomic, strong) NSString *one_dir_id;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *pic_url;
@property (nonatomic, strong) NSString *three_dir_id;
@property (nonatomic, strong) NSString *driver_license;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *decorative_id;
@property (nonatomic, strong) NSString *num_collect;
@property (nonatomic, strong) NSString *manufacturer_type_id;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, strong) NSString *area_id;
@property (nonatomic, strong) NSString *gender;
@property (nonatomic, strong) NSString *qq;
@property (nonatomic, strong) NSString *province_name;
@property (nonatomic, strong) NSString *idcard_back;
@property (nonatomic, strong) NSString *city_name;
@property (nonatomic, strong) NSString *num_good;
@property (nonatomic, strong) NSString *other_flag;
@property (nonatomic, strong) NSString *city_id;
@property (nonatomic, strong) NSString *manufacturer_type_name;
@property (nonatomic, strong) NSString *idcard_front;
@property (nonatomic, strong) NSString *num_comment;
@property (nonatomic, strong) NSString *province_id;

+ (instancetype)sharedUser;

@end
