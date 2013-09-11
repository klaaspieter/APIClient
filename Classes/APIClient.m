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
    return [self initWithHTTPClient:nil];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithHTTPClient:[[APIAFNetworkingHTTPClient alloc] initWithBaseURL:baseURL]];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient;
{
    NSParameterAssert(httpClient);
    if (self = [super init])
    {
        _httpClient = httpClient;
    }

    return self;
}

- (APIResponse *)findAll:(Class)resource;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:@"/products" parameters:nil success:^(id responseObject) {
            resolve(responseObject);
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

@end
