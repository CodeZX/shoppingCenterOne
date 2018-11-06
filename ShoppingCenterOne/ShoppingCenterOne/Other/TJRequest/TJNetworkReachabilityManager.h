//
//  TJNetworkReachabilityManager.h
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TJNetworkReachabilityStatus) {
    TJNetworkReachabilityStatusUnknow   = -1,
    TJNetworkReachabilityStatusNotReachable = 0,
    TJNetworkReachabilityStatusReachableViaWWAN = 1,
    TJNetworkReachabilityStatusReachableViaWiFi = 2,
};

NS_ASSUME_NONNULL_BEGIN

@interface TJNetworkReachabilityManager : NSObject

/**
 After the networkStatusConfirm is determined, its value is the current network state，
 If you use it, please make sure networkStatusConfirm is yes
 */
@property (nonatomic, assign) TJNetworkReachabilityStatus currentStatus;

/**
 had confirm status , Before this can not determine the network environment
 */
@property (nonatomic, assign) BOOL networkStatusConfirm;

+ (instancetype)manager;

/**
 Starts monitoring for changes in network reachability status.
 */
- (void)startMonitoring;

/**
 Stops monitoring for changes in network reachability status.
 */
- (void)stopMonitoring;

///---------------------------------------------------
/// @name Setting Network Reachability Change Callback
///---------------------------------------------------

/**
 Sets a callback to be executed when the network availability of the `baseURL` host changes.
 
 @param block A block object to be executed when the network availability of the `baseURL` host changes.. This block has no return value and takes a single argument which represents the various reachability states from the device to the `baseURL`.
 */

- (void)setupReachabilityStatusChangeBlock:(nullable void (^)(TJNetworkReachabilityStatus status))block;

@end
NS_ASSUME_NONNULL_END
