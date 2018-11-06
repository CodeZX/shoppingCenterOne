//
//  TJNetworkingSendManager.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworkingSendManager.h"

@implementation TJNetworkingSendManager

+ (instancetype)sharedSendManager {
    static TJNetworkingSendManager * sendManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sendManager = [[self alloc] init];
    });
    return sendManager;
}

#pragma mark - TJNetworkDelegate
- (void)tj_networkSuccess:(TJNetworkingSuccessResponse *)successResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkSuccess:api:)]) {
        [self.delegate tj_networkSuccess:successResponse api:api];
    }
}

- (void)tj_networkFailure:(TJNetworkingFailureResponse *)failureResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkFailure:api:)]) {
        [self.delegate tj_networkFailure:failureResponse api:api];
    }
}

- (void)tj_networkCustomErrorFailure:(TJNetworkingFailureResponse *)failureResponse api:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkCustomErrorFailure:api:)]) {
        [self.delegate tj_networkCustomErrorFailure:failureResponse api:api];
    }
}

- (void)tj_networkProgress:(NSProgress *)progress {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkProgress:)]) {
        [self.delegate tj_networkProgress:progress];
    }
}

- (void)tj_networkFinished:(NSString *)api {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkFinished:)]) {
        [self.delegate tj_networkFinished:api];
    }
}

@end
