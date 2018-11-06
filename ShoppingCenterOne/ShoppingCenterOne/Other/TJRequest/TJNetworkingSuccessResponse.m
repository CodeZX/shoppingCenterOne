//
//  TJNetworkingSuccessResponse.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworkingSuccessResponse.h"
#import "MJExtension.h"
#import "TJNetworkConfig.h"

@implementation TJNetworkingSuccessResponse

+ (instancetype)successResponseWithResponseObject:(NSDictionary *)responseObject apiKey:(NSString *)apiKey {
    TJNetworkingSuccessResponse * response = [[self alloc] init];
    response.responseObject = responseObject;
    [response modelWithResponseObject:responseObject apiKey:apiKey];
    return response;
}

+ (instancetype)downloadSuccessResponsesWithResponse:(NSURLResponse *)response filePath:(NSURL *)filePath {
    TJNetworkingSuccessResponse * downloadResponse = [[self alloc] init];
    downloadResponse.urlResponse = response;
    downloadResponse.filePath = filePath;
    return downloadResponse;
}

- (TJNetworkingSuccessResponse *)modelWithResponseObject:(NSDictionary *)object apiKey:(NSString *)apiKey {
    
    if (object && [[TJNetworkConfig sharedNetworkConfig] tj_modelClassWithApiKey:apiKey]) {
        Class class = [[TJNetworkConfig sharedNetworkConfig] tj_modelClassWithApiKey:apiKey];
        id json = object[TJNetworkResponseDataKey];
        if (json && class != nil) {
            if ([json isKindOfClass:[NSDictionary class]]) {
                self.data = [class mj_objectWithKeyValues:json];
            } else if ([json isKindOfClass:[NSArray class]]) {
                self.data = [class mj_objectArrayWithKeyValuesArray:json];
            } else {
                self.data = json;
            }
        } else {
            self.data = nil;
        }
        
        [self configPublicReturnParameterWithObject:object];
    } else if (object && apiKey && [[TJNetworkConfig sharedNetworkConfig] tj_modelClassWithApiKey:apiKey] == nil) {
        self.data = nil;
        [self configPublicReturnParameterWithObject:object];
    }
    
    return self;
}

- (void)configPublicReturnParameterWithObject:(NSDictionary *)object {
    if (object[kNetworkResponseMessageKey]) {
        self.message = object[TJNetworkResponseMessageKey];
    } else {
        self.message = @"unknow message";
    }
    
    if (object[kNetworkResponseTimestampKey]) {
        self.timestamp = object[TJNetworkResponseTimestampKey];
    }
    
    if (object[kNetworkResponseStatusCodeKey]) {
        self.code = object[TJNetworkResponseStatusCodeKey];
    }
}

@end
