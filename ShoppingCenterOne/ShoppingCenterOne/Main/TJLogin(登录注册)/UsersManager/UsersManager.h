//
//  UsersManager.h
//  TJShop
//
//  Created by 周鑫 on 2018/8/8.
//  Copyright © 2018年 徐冬苏. All rights reserved.
//

#import <Foundation/Foundation.h>

@class userModel;
@interface UsersManager : NSObject

//@property (nonatomic,strong,readonly) NSArray <userModel *> *users;
@property (nonatomic,strong) userModel *currentUser;

+ (UsersManager *)sharedUsersManager;

- (BOOL)loginWithUser:(userModel *)userModel;
- (BOOL)logOut;
- (void)signUp;
- (BOOL)save;

- (NSString *)provingCode;
@end
