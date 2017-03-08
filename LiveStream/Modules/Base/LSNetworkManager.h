//
//  LSNetworkManager.h
//  LiveStream
//
//  Created by Panyangjun on 2017/3/8.
//  Copyright © 2017年 Panyangjun. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSInteger, NetRequestType)
{
    GET = 0,
    POST,
    PUT,
    DELETE
};

@interface LSNetworkManager : AFHTTPSessionManager
//网络状态管理
@property(nonatomic, strong) AFNetworkReachabilityManager *networkReachability;

+(LSNetworkManager *)shareManager;

//设置accessToken
- (void)setAuthorization:(NSString *)accessToken;

//网络请求
-(NSURLSessionDataTask *)requestWithPath:(NSString *)urlPath
                           requestParams:(id)params
                             requestType:(NetRequestType)requestType
                         requestComplete:(void(^)(id respondObject , NSError *error))complete;
//网络请求 进度条
-(NSURLSessionDataTask *)requestWithPath:(NSString *)urlPath
                           requestParams:(id)params
                             requestType:(NetRequestType)requestType
                                progress:(void(^)(NSProgress *progress))progress
                         requestComplete:(void(^)(id respondObject , NSError *error))complete;

//upload file
- (NSURLSessionUploadTask *)uploadFileWithPath:(NSString *)URLString
                             parameters:(id)parameters
                            requestType:(NetRequestType)requestType
              constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                               progress:(void (^)(NSProgress *progress))upLoadProgress
                                success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;
//download file
- (NSURLSessionDownloadTask *)downloadFileWithUrl:(NSString *)urlPath
                                   saveTofilePath:(NSString *)filePath
                                     progress:(void (^)(NSProgress *progress))block
                            completionHandler:(void (^)(NSURLResponse *response, NSURL *filePath,
                                                        NSError *error))completionHandler;

@end
