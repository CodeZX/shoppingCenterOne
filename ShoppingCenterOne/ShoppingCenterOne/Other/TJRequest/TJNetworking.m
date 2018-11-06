//
//  TJNetworking.m
//  PeanutFinance
//
//  Created by FS on 2017/7/21.
//  Copyright © 2017年 JiFeng. All rights reserved.
//

#import "TJNetworking.h"
#import "AFNetworking.h"
#import "TJNetworkingSendManager.h"
#import "TJNetworkReachabilityManager.h"

typedef void(^TJNetworkingGoOnAction)(BOOL isGoOn);

static NSString * const kNetworkNonWiFiALertTitle           = @"提示";
static NSString * const kNetworkNonWiFiALertDetail          = @"您当前在非WI-FI或未知的网络环境，确定要上传／下载？";
static NSString * const kNetworkNonWiFiCancelActionTitle    = @"取消";
static NSString * const kNetworkNonWiFiDetermineActionTitle = @"确定";

@interface TJNetworking ()

@property (nonatomic, copy  ) NSString * apiKey;

@end

@implementation TJNetworking

+ (instancetype)manager {
    TJNetworking * mgr = [[self alloc] init];
    mgr.delegate = [TJNetworkingSendManager sharedSendManager];
    return mgr;
}

- (void)post:(NSString *)apiKey
  parameters:(NSDictionary * __nullable)parameters
    progress:(TJNetworkingProgress __nullable)progress
     success:(TJNetworkingSuccess __nullable)success
      failed:(TJNetworkingFailure __nullable)failed
    finished:(TJNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
    
    if ([TJNetworkReachabilityManager manager].networkStatusConfirm && ![self networkReachabilityAction]) {
        return;
    }
    
    NSString *url = [config tj_api:apiKey];
    NSDictionary * requestParameters = [self configParametersWithRequestParameters:parameters];
    AFHTTPSessionManager * mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    [mgr POST:url parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        [self progressWithRequestProgress:uploadProgress];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithResponseObject:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
}


- (void)post:(NSString *)apiKey
  parameters:(NSDictionary * __nullable)parameters
    delegate:(id<TJNetworkDelegate>)delegate {
    self.delegate = delegate;
    [self post:apiKey parameters:parameters progress:nil success:nil failed:nil finished:nil];
}

- (void)get:(NSString *)apiKey
 parameters:(NSDictionary * __nullable)parameters
   progress:(TJNetworkingProgress __nullable)progress
    success:(TJNetworkingSuccess)success
     failed:(TJNetworkingFailure)failed
   finished:(TJNetworkingFinished)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    if ([TJNetworkReachabilityManager manager].networkStatusConfirm && ![self networkReachabilityAction]) {
        return;
    }
    
    TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
    NSString * url = [config tj_api:apiKey];
    NSDictionary * requestParameters = [self configParametersWithRequestParameters:parameters];
    
    AFHTTPSessionManager * mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
    TJLog(@"请求链接\n %@\n",url);
    [mgr GET:url parameters:requestParameters progress:^(NSProgress * _Nonnull downloadProgress) {
        [self progressWithRequestProgress:downloadProgress];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self successWithResponseObject:responseObject];
        [self finish];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self failedWithError:error];
        [self finish];
    }];
}

- (void)get:(NSString *)apiKey
 parameters:(NSDictionary * __nullable)parameters
   delegate:(id<TJNetworkDelegate>)delegate {
    self.delegate = delegate;
    [self get:apiKey parameters:parameters progress:nil success:nil failed:nil finished:nil];
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             progress:(TJNetworkingProgress __nullable)progress
                              success:(TJNetworkingSuccess)success
                               failed:(TJNetworkingFailure)failed
                             finished:(TJNetworkingFinished __nullable)finished{
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    [self networkReachablilityAndWifiStatusAction:^(BOOL goon) {
        if (goon) {
            TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
            NSString * url = [config tj_api:apiKey];
            NSDictionary * requestParameters = [self configParametersWithRequestParameters:parameters];
            
            AFHTTPSessionManager * mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
            [mgr POST:url parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self progressWithRequestProgress:uploadProgress];
                });
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithResponseObject:responseObject];
                [self finish];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failedWithError:error];
                [self finish];
            }];
        }
    }];
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                                 data:(NSData *)data
                             fileName:(NSString *)fileName
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             delegate:(id<TJNetworkDelegate>)delegate {
    
    
    self.delegate = delegate;
    [self uploadTaskWithMultiPartApiKey:apiKey
                                   name:name
                                   data:data
                               fileName:fileName
                               mimeType:mimeType
                             parameters:parameters
                               progress:nil
                                success:nil
                                 failed:nil
                               finished:nil];
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                            dataArray:(NSArray<NSData*> *)dataArray
                        fileNameArray:(NSArray<NSString*> *)fileNameArray
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             progress:(TJNetworkingProgress __nullable)progress
                              success:(TJNetworkingSuccess)success
                               failed:(TJNetworkingFailure)failed
                             finished:(TJNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:apiKey];
    
    [self networkReachablilityAndWifiStatusAction:^(BOOL isGoOn) {
        if (isGoOn) {
            TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
            NSString * url = [config tj_api:apiKey];
            NSDictionary * requestParameters = [self configParametersWithRequestParameters:parameters];
            AFHTTPSessionManager * mgr = [self configHttpSessionManagerWithAPIKey:apiKey];
            
            NSAssert(dataArray.count == fileNameArray.count, @"dataArray count must be equl to fileNameArray count");
            [mgr POST:url parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                [dataArray enumerateObjectsUsingBlock:^(NSData * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSData * data = obj;
                    NSString * fileName = fileNameArray[idx];
                    [formData appendPartWithFileData:data name:name fileName:fileName mimeType:mimeType];
                }];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self progressWithRequestProgress:uploadProgress];
                });
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self successWithResponseObject:responseObject];
                [self finish];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self failedWithError:error];
                [self finish];
            }];
        }
    }];
    
}

- (void)uploadTaskWithMultiPartApiKey:(NSString *)apiKey
                                 name:(NSString *)name
                            dataArray:(NSArray<NSData*> *)dataArray
                        fileNameArray:(NSArray<NSString*> *)fileNameArray
                             mimeType:(NSString *)mimeType
                           parameters:(NSDictionary * __nullable)parameters
                             delegate:(id<TJNetworkDelegate>)delegate {
    
    self.delegate = delegate;
    [self uploadTaskWithMultiPartApiKey:apiKey
                                   name:name
                              dataArray:dataArray
                          fileNameArray:fileNameArray
                               mimeType:mimeType
                             parameters:parameters
                               progress:nil
                                success:nil
                                 failed:nil
                               finished:nil];
    
}


- (instancetype)downloadWithUrl:(NSString *)url
                       filePath:(NSURL * __nullable)filePath
                       fileName:(NSString * __nullable)fileName
                       progress:(TJNetworkingProgress __nullable)progress
                        success:(TJNetworkingSuccess)success
                         failed:(TJNetworkingFailure)failed
                       finished:(TJNetworkingFinished __nullable)finished {
    
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:nil];
    
    [self networkReachablilityAndWifiStatusAction:^(BOOL goon) {
        if (goon) {
            AFURLSessionManager * mgr = [self configURLSessionManager];
            NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            
            self.downloadTask = [mgr downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                [self progressWithRequestProgress:downloadProgress];
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return [self configDownloadUrlWith:response filePath:filePath fileName:fileName];
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [self downloadCompletedWith:response filePath:filePath error:error];
                
            }];
            [self.downloadTask resume];
        }
    }];
    return self;
}

- (instancetype)downloadWithResumeData:(NSData *)resumeData
                              filePath:(NSURL * __nullable)filePath
                              fileName:(NSString * __nullable)fileName
                              progress:(TJNetworkingProgress __nullable)progress
                               success:(TJNetworkingSuccess)success
                                failed:(TJNetworkingFailure)failed
                              finished:(TJNetworkingFinished __nullable)finished {
    [self configRequestBlockWithSuccess:success failed:failed progress:progress finished:finished apiKey:nil];
    
    [self networkReachablilityAndWifiStatusAction:^(BOOL goon) {
        if (goon) {
            AFURLSessionManager * mgr = [self configURLSessionManager];
            self.downloadTask = [mgr downloadTaskWithResumeData:resumeData progress:^(NSProgress * _Nonnull downloadProgress) {
                [self progressWithRequestProgress:downloadProgress];
                
            } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
                return [self configDownloadUrlWith:response filePath:filePath fileName:fileName];
                
            } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                [self downloadCompletedWith:response filePath:filePath error:error];
                
            }];
            [self.downloadTask resume];
        }
    }];
    
    return self;
}

#pragma mark - 数据处理，事件响应
// 请求进度
- (void)progressWithRequestProgress:(NSProgress *)requestProgress {
    if (self.progress) {
        self.progress(requestProgress);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkProgress:)]) {
        [self.delegate tj_networkProgress:requestProgress];
    }
}


// http 下载成功后处理，如果有自定义的错误码，会处理为failed
- (void)downloadSuccessWithResponse:(NSURLResponse *)response filePath:(NSString *)filePath {
    TJNetworkingSuccessResponse * successResponse = [TJNetworkingSuccessResponse downloadSuccessResponsesWithResponse:response filePath:[NSURL URLWithString:filePath]];
    if (self.success) {
        self.success(successResponse);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkSuccess:api:)]) {
        [self.delegate tj_networkSuccess:successResponse api:self.apiKey];
    }
}

// http 请求成功后处理，如果有自定义的错误码，会处理为failed
- (void)successWithResponseObject:(NSDictionary *)responseObject {
    
    if ([self httpSuccessButCustomError:responseObject[kNetworkResponseStatusCodeKey]]) {
        TJNetworkingFailureResponse * response = [TJNetworkingFailureResponse failureResponseWithResponseObject:responseObject];
        if (self.failed) {
            self.failed(response);
        }
        
        [self postCustomHttpErrorNotification:response];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkCustomErrorFailure:api:)]) {
            [self.delegate tj_networkCustomErrorFailure:response api:self.apiKey];
        }
        
    } else {
        TJNetworkingSuccessResponse * response = [TJNetworkingSuccessResponse successResponseWithResponseObject:responseObject apiKey:self.apiKey];
        if (self.success) {
            self.success(response);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkSuccess:api:)]) {
            [self.delegate tj_networkSuccess:response api:self.apiKey];
        }
    }
}

// http 请求失败后的处理
- (void)failedWithError:(NSError *)error {
    TJNetworkingFailureResponse * response = [TJNetworkingFailureResponse failureResponseWithError:error];
    
    if (self.failed) {
        self.failed(response);
    }
    
    if ([self httpSuccessButCustomError:@(error.code)]) {
        [self postCustomHttpErrorNotification:response];
        if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkCustomErrorFailure:api:)]) {
            [self.delegate tj_networkCustomErrorFailure:response api:self.apiKey];
        }
        
    } else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkFailure:api:)]) {
            [self.delegate tj_networkFailure:response api:self.apiKey];
        }
    }
}

// http 请求完毕后的处理
- (void)finish{
    if (self.finished) {
        self.finished();
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkFinished:)]) {
        [self.delegate tj_networkFinished:self.apiKey];
    }
}

// download完成后的处理
- (void)downloadCompletedWith:(NSURLResponse *)response filePath:(NSURL *)filePath error:(NSError *)error {
    if (error) {
        [self failedWithError:error];
        [self finish];
    } else {
        TJNetworkingSuccessResponse * successResponse = [TJNetworkingSuccessResponse downloadSuccessResponsesWithResponse:response filePath:filePath];
        if (self.success) {
            self.success(successResponse);
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(tj_networkSuccess:api:)]) {
            [self.delegate tj_networkSuccess:successResponse api:self.apiKey];
        }
        [self finish];
    }
}

#pragma mark - top view controller
- (UIViewController *)topViewController {
    UIViewController * resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

#pragma mark - network reachability
- (BOOL)networkReachabilityAction {
    if ([TJNetworkReachabilityManager manager].currentStatus == TJNetworkReachabilityStatusNotReachable) {
        if (self.failed) {
            TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
            NSError * error = [NSError errorWithDomain:self.apiKey
                                                  code:[config.noNetworkStatusCode integerValue]
                                              userInfo:@{NSLocalizedDescriptionKey:@"no network"}];
            [self failedWithError:error];
            [self finish];
        }
        return NO;
    }
    return YES;
}

- (void)networkReachablilityAndWifiStatusAction:(TJNetworkingGoOnAction)goOnAction {
    
    if (!([TJNetworkReachabilityManager manager].currentStatus == TJNetworkReachabilityStatusReachableViaWiFi)) {
        
        NSString * title = [[TJNetworkConfig sharedNetworkConfig] nonWiFiNetowrkAlertTitle] ? : kNetworkNonWiFiALertTitle;
        NSString * message = [[TJNetworkConfig sharedNetworkConfig] nonWiFiNetowrkAlertDetail] ? : kNetworkNonWiFiALertDetail;
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:kNetworkNonWiFiCancelActionTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
            goOnAction(NO);
        }];
        UIAlertAction * submitAction = [UIAlertAction actionWithTitle:kNetworkNonWiFiDetermineActionTitle
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * _Nonnull action) {
            goOnAction(YES);
        }];
        
        [alert addAction:submitAction];
        [alert addAction:cancelAction];
        [[self topViewController] presentViewController:alert animated:YES completion:nil];
    } else {
        if (goOnAction) {
            goOnAction(YES);
        }
    }
}



#pragma mark - notification error
// 发送自定义的http请求错误的通知
- (void)postCustomHttpErrorNotification:(TJNetworkingFailureResponse * _Nonnull)response {
    [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkCustomHttpErrorNotificationKey object:response];
}

#pragma mark - config
// 配置下载路径
- (NSURL *)configDownloadUrlWith:(NSURLResponse *)response filePath:(NSURL *)filePath fileName:(NSString *)fileName {
    NSURL * documentsDirectoryURL = nil;
    if (!filePath) {
        documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    } else {
        documentsDirectoryURL = filePath;
    }
    
    NSString * tmpFileName = nil;
    if (!fileName) {
        tmpFileName = [response suggestedFilename];
    } else {
        tmpFileName = fileName;
    }
    
    return [documentsDirectoryURL URLByAppendingPathComponent:tmpFileName];
}

// 配置url 参数拼接
- (NSString *)configUrl:(NSString *)url requestParameters:(NSDictionary *)requestParameters  {
    if (requestParameters.allKeys.count) {
        for (int i=0; i<requestParameters.allKeys.count; i++) {
            id key = requestParameters.allKeys[i];
            id value = requestParameters[key];
            if (i==0) {
                if ([url hasSuffix:@"/"]) {
                    NSMutableString * str = [NSMutableString stringWithString:url];
                    url = [str substringWithRange:NSMakeRange(0, url.length-1)];
                }
                url = [url stringByAppendingFormat:@"?%@=%@",key,value];
            } else {
                url = [url stringByAppendingFormat:@"&%@=%@",key,value];
            }
        }
    }
    return url;
}

#pragma mark - 配置处理
- (void)configRequestBlockWithSuccess:(TJNetworkingSuccess)success failed:(TJNetworkingFailure)failed progress:(TJNetworkingProgress)progress finished:(TJNetworkingFinished)finished apiKey:(NSString *)apiKey{
    self.success = success;
    self.failed = failed;
    self.progress = progress;
    self.finished = finished;
    self.apiKey = apiKey;
}

// 自定义请求错误码判断
- (BOOL)httpSuccessButCustomError:(NSNumber * _Nonnull)statusCode {
    BOOL __block status = NO;
    [[TJNetworkConfig sharedNetworkConfig].customErrorStatusCode enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([statusCode isEqualToNumber:key]) {
            status = YES;
            * stop = YES;
        }
    }];
    return status;
}

// 参数拼接
- (NSDictionary *)configParametersWithRequestParameters:(NSDictionary *)parameters {
    TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
    NSMutableDictionary * requestParameters = [[NSMutableDictionary alloc] initWithDictionary:config.globalParameters];
    if (parameters && parameters.allKeys.count != 0) {
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [requestParameters setObject:obj forKey:key];
        }];
    }
    return requestParameters;
}

// 请求http manager 配置
- (AFHTTPSessionManager *)configHttpSessionManagerWithAPIKey:(NSString *)apiKey {
    TJNetworkConfig * config = [TJNetworkConfig sharedNetworkConfig];
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
//    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",@"text/html",@"text/json",@"text/plain",@"text/javascript",@"text/xml",@"image/*"]];
    // 设置对证书的处理方式
    mgr.securityPolicy.allowInvalidCertificates = YES;
    mgr.securityPolicy.validatesDomainName = NO;
    
    // serializer
    if (config.requestHeader && config.requestHeader.allKeys.count != 0) {
        [config.requestHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mgr.requestSerializer setValue:obj forHTTPHeaderField:key];
        }];
    } else {
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    }
    
    // 超时时间
    mgr.requestSerializer.timeoutInterval = [config tj_timeoutIntervalWithApiKey:apiKey];
    return mgr;
}

// download manager 配置
- (AFURLSessionManager *)configURLSessionManager {
    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * mgr = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    return mgr;
}

@end
