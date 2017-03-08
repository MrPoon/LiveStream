//
//  LSNetworkManager.m
//  LiveStream
//
//  Created by Panyangjun on 2017/3/8.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import "LSNetworkManager.h"


static NSURL *baseurl = nil;
static NSString *acesstoken = nil;

@implementation LSNetworkManager

+(LSNetworkManager *)shareManager {
    static dispatch_once_t once_t;
    static LSNetworkManager *shareManager;
    dispatch_once(&once_t, ^{
        shareManager = [[LSNetworkManager alloc] initWithBaseURL:nil];
        shareManager.networkReachability = [AFNetworkReachabilityManager sharedManager];
    });
    return shareManager;
}
/*
 http请求初始化
 */
-(instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //解析器初始化
        self.responseSerializer = [AFJSONResponseSerializer serializer];//使用json解析器 AFN默认已设置
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html",@"image/png", @"image/jpg", @"video/mpeg4", @"image/gif", @"application/x-zip-compressed", @"application/binary", nil];
        //超时设置
        self.requestSerializer.timeoutInterval = 30.0f;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
        //是否匹配域名
        self.securityPolicy.validatesDomainName = NO;
    }
    return self;
}
-(void)setAuthorization:(NSString *)accessToken {
    acesstoken = accessToken;
    [self.requestSerializer setValue:accessToken forHTTPHeaderField:@"AccessToken"];
}

#pragma mark - GET/POST/PUT/DELETE 基本网络请求
-(NSURLSessionDataTask *)requestWithPath:(NSString *)urlPath requestParams:(id)params requestType:(NetRequestType)requestType requestComplete:(void (^)(id repondObject, NSError *error))complete {
    
    return [self requestWithPath:urlPath requestParams:params requestType:requestType progress:nil requestComplete:complete];
}

-(NSURLSessionDataTask *)requestWithPath:(NSString *)urlPath
                           requestParams:(id)params
                             requestType:(NetRequestType)requestType
                                progress:(void (^)(NSProgress *))progress
                         requestComplete:(void (^)(id repondObject, NSError *error))complete {
    
    if (!urlPath || urlPath.length == 0) {
        return nil;
    }
    urlPath = [urlPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionDataTask *sessionDataTask;
    switch (requestType) {
        case GET: {
            sessionDataTask = [self GET:urlPath parameters:params progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                complete(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                complete(nil, error);
            }];
        }
            break;
        case POST: {
            sessionDataTask = [self POST:urlPath parameters:params progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                complete(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                complete(nil, error);
            }];
        }
            break;
        case PUT: {
            sessionDataTask = [self PUT:urlPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                complete(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                complete(nil, error);
            }];
        }
            break;
        case DELETE: {
            sessionDataTask = [self DELETE:urlPath parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                complete(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                complete(nil, error);
            }];
        }
            break;
            
        default:
            break;
    }
    return sessionDataTask;
}

#pragma mark - upload file
-(NSURLSessionUploadTask *)uploadFileWithPath:(NSString *)URLString
                                   parameters:(id)parameters
                                  requestType:(NetRequestType)requestType
                    constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
                                     progress:(void (^)(NSProgress *progress))upLoadProgress
                                      success:(void (^)(NSURLSessionDataTask *, id))success
                                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    NSString *requestMethod = @"POST";
    if (requestType == PUT) {
        requestMethod = @"PUT";
    }
    NSError *serializationError = nil;
    NSMutableURLRequest *request =
    [self.requestSerializer multipartFormRequestWithMethod:requestMethod
                                                 URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString]
                                                parameters:parameters
                                 constructingBodyWithBlock:block
                                                     error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionUploadTask *task = [self uploadTaskWithStreamedRequest:request progress:upLoadProgress completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(task, error);
            }
        } else {
            if (success) {
                success(task, responseObject);
            }
        }
    }];
    
    //如果progress没有回调、使用以下方法进行progress进度的监听回调、
    //使用ReactiveCocoa框架方法进行监听
    //    if (upLoadProgress) {
    //        NSProgress *progress = [self uploadProgressForTask:task];
    //        @weakify(progress);
    //        [RACObserve(progress, localizedDescription) subscribeNext:^(NSString *x) {
    //            @strongify(progress);
    //            upLoadProgress(progress);
    //        }];
    //    }
    [task resume];
    
    return task;
}
#pragma mark - download file
- (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)urlPath
                                   saveTofilePath:(NSString *)filePath
                                         progress:(void (^)(NSProgress *progress))downloadProgress
                                completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath,
                                                            NSError *error))completionHandler {
    
    NSURL *remoteUrl;
    if ([urlPath isKindOfClass:[NSURL class]]) {
        remoteUrl = (NSURL *)urlPath;
    } else {
        remoteUrl = [NSURL URLWithString:urlPath];
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:remoteUrl];
    NSString *token = [self.requestSerializer valueForHTTPHeaderField:@"AccessToken"];
    [request setValue:token forHTTPHeaderField:@"AccessToken"];
    
    NSURLSessionDownloadTask *task =
    [self downloadTaskWithRequest:request
                         progress:nil
                      destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                          return [NSURL fileURLWithPath:filePath];
                      }
                completionHandler:completionHandler];
    
    //如果progress没有回调、使用以下方法进行progress进度的监听回调、
    //使用ReactiveCocoa框架方法进行监听
    //    if (downloadProgress) {
    //        NSProgress *progress = [self uploadProgressForTask:task];
    //        @weakify(progress);
    //        [RACObserve(progress, localizedDescription) subscribeNext:^(NSString *x) {
    //            @strongify(progress);
    //            downloadProgress(progress);
    //        }];
    //    }
    [task resume];
    
    return task;
}


@end
