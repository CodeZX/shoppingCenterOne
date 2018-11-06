//
//  userModel.m
//  TJShop
//
//  Created by 周鑫 on 2018/8/8.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import "userModel.h"

@implementation userModel


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.phone_num = [aDecoder decodeObjectForKey:@"phone_num"];
        self.pwd = [aDecoder decodeObjectForKey:@"pwd"];
        self.profile_pic = [aDecoder decodeObjectForKey:@"profile_pic"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.birthday = [aDecoder decodeObjectForKey:@"birthday"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    [aCoder encodeObject:self.phone_num forKey:@"phone_num"];
    [aCoder encodeObject:self.pwd forKey:@"pwd"];
    [aCoder encodeObject:self.profile_pic forKey:@"profile_pic"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];;
    [aCoder encodeObject:self.birthday forKey:@"birthday"];
}
@end


//"user_id": "cus13886981439",   //用户id
//"phone_num": "13886981439",  //手机号
//"pwd": "123456",             //密码
//"profile_pic": "",              //头像
//"name": "用户13886981439",   //用户名
//"sex": "",                     //性别
//"birthday": ""
