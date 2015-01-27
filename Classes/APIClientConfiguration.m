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

+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;
{
    return [self configurationWithBlock:^(APIClientConfiguration *configuration) {
        configuration.baseURL = baseURL;
    }];
}

+ (instancetype)configurationWithBlock:(APIClientConfigurationBlock)block;
{
    return [[self alloc] initWithBlock:block];
}

- (id)init;
{
    return [self initWithBlock:nil];
}

- (id)initWithBlock:(APIClientConfigurationBlock)block;
{
    NSParameterAssert(block);
    self = [super init];
    if (self) {
        block(self);
        [self verifyExistenceOfHTTPClient];
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