//
//  APIClientConfiguration.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClientConfiguration.h"

@implementation APIClientConfiguration

- (id)init;
{
    return [self initWithBaseURL:nil];
}

+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithBaseURL:baseURL];
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    NSParameterAssert(baseURL);
    
    id<APIHTTPClient> httpClient = [APIAFNetworkingHTTPClient clientWithBaseURL:baseURL];
    id<APIRouter> router = [[APIRouter alloc] init];
    id<APIJSONSerializer> serializer = [[APIJSONSerializer alloc] init];
    return [self initWithHTTPClient:httpClient router:router serializer:serializer];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router serializer:(id<APIJSONSerializer>)serializer;
{
    NSParameterAssert(httpClient);
    NSParameterAssert(router);
    NSParameterAssert(serializer);
    
    if (self = [super init])
    {
        _httpClient = httpClient;
        _router = router;
        _serializer = serializer;
    }

    return self;
}

@end