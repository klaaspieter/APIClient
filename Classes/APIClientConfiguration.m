//
//  APIClientConfiguration.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClientConfiguration.h"

#import "APIAFNetworkingHTTPClient.h"

@interface APIClientConfiguration ()
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

+ (instancetype)configurationWithBlock:(APIClientConfigurationBlock)block;
{
    NSParameterAssert(block);
    APIClientConfiguration *configuration = [[self alloc] _initWithoutBaseURL];
    block(configuration);
    [configuration verifyExistenceOfHTTPClient];
    return configuration;
}

- (id)_initWithoutBaseURL;
{
    if (self = [super init]) {
    }

    return self;
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    NSParameterAssert(baseURL);
    
    id<APIHTTPClient> httpClient = [[APIAFNetworkingHTTPClient alloc] initWithBaseURL:baseURL];
    return [self initWithHTTPClient:httpClient router:nil serializer:nil mapper:nil];
}

- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient
                  router:(id<APIRouter>)router
              serializer:(id<APIJSONSerializer>)serializer
                  mapper:(id<APIMapper>)mapper;
{
    if (self = [super init]) {
        _httpClient = httpClient;
        _router = router;
        _serializer = serializer;
        _mapper = mapper;
    }

    return self;
}

- (NSURL *)baseURL;
{
    return self.httpClient.baseURL;
}

- (void)setBaseURL:(NSURL *)baseURL;
{
    _httpClient = [[APIAFNetworkingHTTPClient alloc] initWithBaseURL:baseURL];
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

- (id<APIMapper>)mapper;
{
    if (!_mapper) {
        _mapper = [[APIMapper alloc] init];
    }

    return _mapper;
}

- (void)verifyExistenceOfHTTPClient;
{
    if (self.httpClient) {
        return;
    }

    [NSException raise:NSInternalInconsistencyException format:@"A httpClient must exist after creating a configuration. You can specify a http client by creating one yourself or by setting the baseURL."];
}

@end