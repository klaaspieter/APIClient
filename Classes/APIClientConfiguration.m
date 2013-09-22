//
//  APIClientConfiguration.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClientConfiguration.h"

@interface APIClientConfiguration ()
@property (nonatomic, readwrite, strong) id<APIRouter> router;
@property (nonatomic, readwrite, strong) id<APIJSONSerializer> serializer;
@end

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
    return [self initWithHTTPClient:httpClient router:nil serializer:nil];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router serializer:(id<APIJSONSerializer>)serializer;
{
    if (self = [super init])
    {
        _httpClient = httpClient;
        _router = router;
        _serializer = serializer;
    }

    return self;
}

- (id<APIRouter>)router;
{
    if (!_router) {
        _router = [[APIRouter alloc] init];
    }

    return _router;
}

- (id<APIJSONSerializer>)serializer;
{
    if (!_serializer) {
        _serializer = [[APIJSONSerializer alloc] init];
    }

    return _serializer;
}

@end