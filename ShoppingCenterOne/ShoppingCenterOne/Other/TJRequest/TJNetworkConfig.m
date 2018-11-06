//
//  TJNetworkConfig.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworkConfig.h"
#import "TJNetworkReachabilityManager.h"

#pragma mark - 自定义错误的通知key
NSString * _Nullable const kNetworkCustomHttpErrorNotificationKey = @"TJNetworkCustomHttpErrorNotificationKey";

#pragma mark - json格式key
NSString * _Nonnull const kNetworkResponseMessageKey    = @"message";
NSString * _Nonnull const kNetworkResponseTimestampKey  = @"timestamp";
NSString * _Nonnull const kNetworkResponseStatusCodeKey = @"code";
NSString * _Nonnull const kNetworkResponseDataKey       = @"body";

#pragma mark - 默认超时时间
static NSTimeInterval const kNetworkDefaultTimeOutInterval = 15;

@implementation TJNetworkConfig

static TJNetworkConfig * _networkConfig = nil;
+ (instancetype)sharedNetworkConfig {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _networkConfig = [[self alloc] init];
        _networkConfig.host = kHostURL;
        _networkConfig.defaultTimeoutInterval = 60;
        [[TJNetworkReachabilityManager manager] setupReachabilityStatusChangeBlock:nil];
        [[TJNetworkReachabilityManager manager] startMonitoring];
    });
    return _networkConfig;
}

- (Class)tj_modelClassWithApiKey:(NSString *)apiKey {
    if (self.modelClass && [self.modelClass objectForKey:apiKey]) {
        return [self.modelClass objectForKey:apiKey];
    }
    return nil;
}

- (NSString *)tj_api:(NSString *)apiKey {
    NSAssert(self.host != nil, @"TJNetworkConfig 'host' must be set");
    NSAssert(apiKey != nil, @"TJNetworkConfig 'api:' apiKey can`t nil");
    
    NSString * url = nil;
    if ([apiKey hasPrefix:@"http"]) {
        url = apiKey;
    } else {
        
        NSString * host = self.host;
        if ([apiKey hasPrefix:@"/"] && [host hasSuffix:@"/"]) {
            apiKey = [apiKey stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        } else if(![apiKey hasPrefix:@"/"] && ![host hasSuffix:@"/"]){
            host = [host stringByAppendingString:@"/"];
        }
        url = [NSString stringWithFormat:@"%@%@", host, apiKey];
    }
    return url;
}

- (NSTimeInterval)tj_timeoutIntervalWithApiKey:(NSString *)apiKey {
    NSNumber * timeOut = nil;
    if (self.timeoutInterval) {
        id tmpTimeOut = [self.timeoutInterval objectForKey:apiKey];
        if ([tmpTimeOut isKindOfClass:[NSString class]]) {
            timeOut = [[NSNumberFormatter alloc] numberFromString:tmpTimeOut];
        } else if([tmpTimeOut isKindOfClass:[NSNumber class]]){
            timeOut = (NSNumber *)tmpTimeOut;
        } else {
            return self.defaultTimeoutInterval;
        }
    }
    if ([timeOut doubleValue] > 0.0) {
        return [timeOut doubleValue];
    }
    return self.defaultTimeoutInterval;
}

#pragma mark - lazy load methods
- (NSDictionary *)modelClass {
    if (!_modelClass) {
        _modelClass = @{};
    }
    return _modelClass;
}

- (NSDictionary *)requestHeader {
    if (_requestHeader == nil) {
        _requestHeader = @{};
    }
    return _requestHeader;
}

- (NSDictionary *)globalParameters {
    if (_globalParameters == nil) {
        _globalParameters = @{};
    }
    return _globalParameters;
}

- (NSDictionary *)customErrorStatusCode {
    if (_customErrorStatusCode == nil) {
        _customErrorStatusCode = @{};
    }
    return _customErrorStatusCode;
}

- (NSNumber *)noNetworkStatusCode {
    if (_noNetworkStatusCode == nil) {
        _noNetworkStatusCode = @9999;
    }
    return _noNetworkStatusCode;
}

- (NSDictionary *)responseFormat {
    if (_responseFormat == nil) {
        _responseFormat = @{
                            kNetworkResponseDataKey       : kNetworkResponseDataKey,
                            kNetworkResponseMessageKey    : kNetworkResponseMessageKey,
                            kNetworkResponseTimestampKey  : kNetworkResponseTimestampKey,
                            kNetworkResponseStatusCodeKey : kNetworkResponseStatusCodeKey
                            };
    }
    return _responseFormat;
}

- (NSTimeInterval)defaultTimeoutInterval {
    if (!_defaultTimeoutInterval) {
        return kNetworkDefaultTimeOutInterval;
    }
    return _defaultTimeoutInterval;
}

@end
