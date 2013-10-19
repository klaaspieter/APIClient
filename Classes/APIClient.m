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

+ (instancetype)clientWithConfigurationBlock:(APIClientConfigurationBlock)block;
{
    return [[self alloc] initWithConfiguration:[APIClientConfiguration configurationWithBlock:block]];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithBaseURL:baseURL];
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    APIClientConfiguration *configuration =
      [APIClientConfiguration configurationWithBlock:^(APIClientConfiguration *configuration) {
        configuration.baseURL = baseURL;
    }];
    return [self initWithConfiguration:configuration];
}

- (id)initWithConfiguration:(APIClientConfiguration *)configuration;
{
    if (self = [super init])
    {
        _configuration = configuration;
    }

    return self;
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient
                  router:(id<APIRouter>)router
              serializer:(id<APIJSONSerializer>)serializer
                  mapper:(id<APIMapper>)mapper;
{
    return [self initWithConfiguration:[[APIClientConfiguration alloc] initWithHTTPClient:httpClient
                                                                                   router:router
                                                                               serializer:serializer
                                                                                   mapper:mapper]];
}

- (APIResponse *)findAll:(Class)resource;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"index" onResource:resource] parameters:nil success:^(id responseObject) {
            id serialized = [self.serializer deserializeJSON:responseObject];
            id mapped = [self.mapper mapValues:serialized toResource:resource];
            resolve(mapped);
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

- (id<APIJSONSerializer>)serializer;
{
    return self.configuration.serializer;
}

- (id<APIMapper>)mapper;
{
    return self.configuration.mapper;
}

@end
