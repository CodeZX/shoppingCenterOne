//
//  User.m
//  HKZJ_IPhone
//
//  Created by mac on 16/5/11.
//  Copyright (c) 2016年 Edgar_guan. All rights reserved.
//

#import "User.h"
//#import "LSJPublicManager.h"


@implementation User

static id _instace;

+ (instancetype)sharedUser{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if (self == [super init]) {
//        self.password = [aDecoder decodeObjectForKey:@"password"];
//        self.roleOrgJobList = [aDecoder decodeObjectForKey:@"roleOrgJobList"];
//        self.jobId = [aDecoder decodeObjectForKey:@"jobId"];
//        self.staffCode = [aDecoder decodeObjectForKey:@"staffCode"];
//        self.staffId = [aDecoder decodeObjectForKey:@"staffId"];
//        self.staffName = [aDecoder decodeObjectForKey:@"staffName"];
//        self.linkNbr = [aDecoder decodeObjectForKey:@"linkNbr"];
//        self.jobName = [aDecoder decodeObjectForKey:@"jobName"];
//        self.orgId = [aDecoder decodeObjectForKey:@"orgId"];
//        self.orgName = [aDecoder decodeObjectForKey:@"orgName"];
//        self.startDate = [aDecoder decodeObjectForKey:@"startDate"];
//        self.endDate = [aDecoder decodeObjectForKey:@"endDate"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
//    [aCoder encodeObject:self.password forKey:@"password"];
//    [aCoder encodeObject:self.roleOrgJobList forKey:@"roleOrgJobList"];
//    [aCoder encodeObject:self.jobId forKey:@"jobId"];
//    [aCoder encodeObject:self.staffCode forKey:@"staffCode"];
//    [aCoder encodeObject:self.staffId forKey:@"staffId"];
//    [aCoder encodeObject:self.staffName forKey:@"staffName"];
//    [aCoder encodeObject:self.linkNbr forKey:@"linkNbr"];
//    [aCoder encodeObject:self.jobName forKey:@"jobName"];
//    [aCoder encodeObject:self.orgId forKey:@"orgId"];
//    [aCoder encodeObject:self.orgName forKey:@"orgName"];
//    [aCoder encodeObject:self.startDate forKey:@"startDate"];
//    [aCoder encodeObject:self.endDate forKey:@"endDate"];
    
}
@end
