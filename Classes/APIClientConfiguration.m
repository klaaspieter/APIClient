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
    return [self initWithHTTPClient:httpClient router:router];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router;
{
    NSParameterAssert(httpClient);
    NSParameterAssert(router);
    
    if (self = [super init])
    {
        _httpClient = httpClient;
        _router = router;
    }

    return self;
}

@end