//
//  TJNetworkDelegate.h
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TJNetworkingSuccessResponse;
@class TJNetworkingFailureResponse;

@protocol TJNetworkDelegate <NSObject>

/**
 网络请求成功回调

 @param successResponse 成功的相应数据model
 @param api 请求的api
 */
- (void)tj_networkSuccess:(TJNetworkingSuccessResponse *)successResponse api:(NSString *)api;

/**
 网络请求失败回调（服务端抛出异常的错误并且不包含自定义error code时的错误）

 @param failureResponse 失败的响应数据model
 @param api 请求的api
 */
- (void)tj_networkFailure:(TJNetworkingFailureResponse *)failureResponse api:(NSString *)api;

/**
 自定义错误码失败时的回调 自定义错误码的设置请看TJNetworkConfig 类中的
 @property (nonatomic, strong) NSDictionary *customErrorStatusCode;

 @param failureResponse 失败的响应数据model
 @param api 请求的api
 */
- (void)tj_networkCustomErrorFailure:(TJNetworkingFailureResponse *)failureResponse api:(NSString *)api;

/**
 网络请求进度回调(有进度的请求才会回调)

 @param progress 进度
 */
- (void)tj_networkProgress:(NSProgress *)progress;

/**
 网络请求结束的回调（在成功失败时都会调用）

 @param api 请求的api
 */
- (void)tj_networkFinished:(NSString *)api;

@end
