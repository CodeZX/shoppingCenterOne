//
//  TJNetworkReachabilityManager.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworkReachabilityManager.h"
#import "AFNetworkReachabilityManager.h"

@interface TJNetworkReachabilityManager ()

@property (nonatomic, nonnull, strong) AFNetworkReachabilityManager * AFNManager;

@end

@implementation TJNetworkReachabilityManager

static TJNetworkReachabilityManager * _mgr = nil;
+ (instancetype)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _mgr = [[self alloc] init];
        _mgr.AFNManager = [AFNetworkReachabilityManager manager];
    });
    return _mgr;
}

- (void)startMonitoring {
    [_mgr.AFNManager startMonitoring];
}

- (void)stopMonitoring {
    [_mgr.AFNManager stopMonitoring];
}

- (void)setupReachabilityStatusChangeBlock:(void (^)(TJNetworkReachabilityStatus))block {
    [_mgr.AFNManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networkStatusConfirm = YES;
        self.currentStatus = (TJNetworkReachabilityStatus)status;
        if (block) {
            block(self.currentStatus);
        }
    }];
}

@end
