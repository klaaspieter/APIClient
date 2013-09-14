//
//  APIClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

- (id)init;
{
    return [self initWithBaseURL:nil];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithBaseURL:baseURL];
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    NSParameterAssert(baseURL);
    return [self initWithHTTPClient:[[APIAFNetworkingHTTPClient alloc] initWithBaseURL:baseURL] router:[[APIRouter alloc] init]];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router;
{
    NSParameterAssert(httpClient);
    if (self = [super init])
    {
        _configuration = [[APIClientConfiguration alloc] initWithHTTPClient:httpClient router:router];
    }

    return self;
}

- (APIResponse *)findAll:(Class)resource;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"index" onResource:resource] parameters:nil success:^(id responseObject) {
            resolve(responseObject);
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

- (id<APIRouter>)router;
{
    return self.configuration.router;
}

- (id<APIHTTPClient>)httpClient;
{
    return self.configuration.httpClient;
}

@end
