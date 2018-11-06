//
//  tjNetworkConfig.h
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TJNetworkResponseMessageKey     [TJNetworkConfig sharedNetworkConfig].responseFormat[kNetworkResponseMessageKey]
#define TJNetworkResponseTimestampKey   [TJNetworkConfig sharedNetworkConfig].responseFormat[kNetworkResponseTimestampKey]
#define TJNetworkResponseStatusCodeKey  [TJNetworkConfig sharedNetworkConfig].responseFormat[kNetworkResponseStatusCodeKey]
#define TJNetworkResponseDataKey        [TJNetworkConfig sharedNetworkConfig].responseFormat[kNetworkResponseDataKey]

extern NSString * _Nullable const kNetworkCustomHttpErrorNotificationKey;

// 消息、描述
extern NSString * _Nonnull const kNetworkResponseMessageKey;
// 时间戳
extern NSString * _Nonnull const kNetworkResponseTimestampKey;
// 状态码
extern NSString * _Nonnull const kNetworkResponseStatusCodeKey;
// 数据
extern NSString * _Nonnull const kNetworkResponseDataKey;

NS_ASSUME_NONNULL_BEGIN
@interface TJNetworkConfig : NSObject

@property (nonatomic, strong) NSString * host;

@property (nonatomic, strong) NSDictionary * modelClass;

/**
 请求头的参数
 比如: http header的UserAgent 中添加参数
 @{
 @"Content-Type":@"application/json"
 }
 */
@property (nonatomic, strong) NSDictionary * requestHeader;

/**
 公共参数
 eg:
 @{
 @"screenWidth"  :@"400",
 @"screenHeight" :@"600",
 @"phone"        :@"iPhone6s",
 @"OS"           :@"iOS10.1.1",
 }
 */
@property (nonatomic, strong) NSDictionary * globalParameters;

/**
 自定义的错误码及其对应的错误提示信息
 比如：
 用户登录token过期，此时调用所有的接口都会返回错误码 100018 ，
 
 设置这个属性为：
 @{
 @100018:@"token过期"，
 }
 
 // TODO 什么代理方法？
 
 这时就可以在代理方法中获取到自定义错误的回调
 */
@property (nonatomic, strong) NSDictionary * customErrorStatusCode;

/**
 没有网络时的自定义状态码
 */
@property (nonatomic, strong) NSNumber * noNetworkStatusCode;

/**
 服务端json返回响应数据格式
 如 ：
 {
 "code": 0,
 "data": {
 "count": 1
 },
 "msg": "SUCCESS",
 "timestamp": 1465805236
 }
 
 eg:
 @{
 TJNetworkingResponseDataKey       :@"data",
 TJNetworkingResponseStatusCodeKey :@"code",
 TJNetworkingResponseMessageKey    :@"message",
 TJNetworkingResponseTimelineKey   :@"timestamp",
 }
 其中
 TJNetworkingResponseDataKey
 TJNetworkingResponseStatusCodeKey
 TJNetworkingResponseMessageKey
 TJNetworkingResponseTimelineKey
 是本类中声明的static字符串，专门用来作为key。
 */
@property (nonatomic, strong) NSDictionary * responseFormat;

/**
 默认超时时间，如果不设置则为15s
 */
@property (nonatomic, assign) NSTimeInterval defaultTimeoutInterval;

/**
 超时时间配置字典
 
 如果不设置，则为默认超时时间
 如果你的某一个接口需要特殊的超时时间，比如：
 @“/feddback/uploadImages” 接口需要100秒的超时时间
 则配置timeoutInterval为：
 
 @{
 @“/feddback/uploadImages”:@100,
 }
 
 或者
 @{
 @“/feddback/uploadImages”:@"100",
 }
 
 */
@property (nonatomic, strong) NSDictionary * timeoutInterval;

/**
 下载或者上传时，非wifi环境的提示标题
 */
@property (nonatomic, copy) NSString * nonWiFiNetowrkAlertTitle;

/**
 下载或者上传时，非wifi环境的提示详情
 */
@property (nonatomic, copy) NSString * nonWiFiNetowrkAlertDetail;

/***************************************************************************************/
/****************************************Methods****************************************/
/***************************************************************************************/

/**
 初始化
 
 @return self的实例
 */
+ (instancetype)sharedNetworkConfig;

/**
 apiKey对应的数据模型类
 
 @param apiKey apiKey
 @return 类
 */
- (nullable Class)tj_modelClassWithApiKey:(NSString *)apiKey;

/**
 根据apiKey拼接完整的请求URL
 
 @param apiKey apiKey
 @return 完整的请求URL
 */
- (NSString *)tj_api:(NSString *)apiKey;

/**
 apiKey对应的超时时间，如果没有设置，则是默认超时时间
 
 @param apiKey apiKey
 @return 超时时间
 */
- (NSTimeInterval)tj_timeoutIntervalWithApiKey:(NSString *)apiKey;

@end
NS_ASSUME_NONNULL_END
