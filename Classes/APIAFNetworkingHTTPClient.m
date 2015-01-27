//
//  APIAFNetworkingHTTPClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

#import "APIAFNetworkingHTTPClient.h"

@interface APIAFNetworkingHTTPClient ()
@property (nonatomic, readwrite, strong) AFHTTPSessionManager *client;
@end

@implementation APIAFNetworkingHTTPClient

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    return [self initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (id)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _sessionConfiguration = sessionConfiguration;
    }

    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
{
    [self.client GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (AFHTTPSessionManager *)client;
{
    if (!_client) {
        _client = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL sessionConfiguration:self.sessionConfiguration];
    }

    return _client;
}

@end
