//
//  TJNetworkingFailureResponse.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworkingFailureResponse.h"
#import "TJNetworkConfig.h"

@implementation TJNetworkingFailureResponse

+ (instancetype)failureResponseWithError:(NSError *)error {
    TJNetworkingFailureResponse * response = [[self alloc] init];
    response.userInfo = error.userInfo;
    response.code = @(error.code);
    return response;
}

+ (instancetype)failureResponseWithResponseObject:(NSDictionary *)responseObject {
    TJNetworkingFailureResponse *response  = [[self alloc] init];
    response.userInfo = nil;
    NSNumber * code = responseObject[kNetworkResponseStatusCodeKey];
    if (code) {
        response.code = code;
    }
    
    NSString *message = responseObject[kNetworkResponseMessageKey];
    if (message) {
        response.message = message;
    } else {
        response.message = [TJNetworkConfig sharedNetworkConfig].customErrorStatusCode[code];
    }
    
    return response;
}

- (NSString *)message {
    
    if (_userInfo) {
        return _userInfo[NSLocalizedDescriptionKey];
    }
    
    if (_message) {
        return _message;
    }
    return @"unknow error";
}

@end
