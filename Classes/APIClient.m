//
//  APIClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClient.h"

@interface APIClient ()
@property (nonatomic, readwrite, copy) NSURL *baseURL;
@property (nonatomic, readwrite, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readwrite, strong) id<APIRouter> router;
@property (nonatomic, readwrite, strong) id<APIJSONSerializer> serializer;
@property (nonatomic, readwrite, strong) id<APIMapper>mapper;
@end

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
    return [self initWithConfiguration:[APIClientConfiguration configurationWithBaseURL:baseURL]];
}

- (id)initWithConfiguration:(APIClientConfiguration *)configuration;
{
    if (self = [super init])
    {
        _httpClient = configuration.httpClient;
        _router = configuration.router;
        _serializer = configuration.serializer;
        _mapper = configuration.mapper;
    }

    return self;
}

- (APIResponse *)findAll:(Class)resource;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"index" onResource:resource] parameters:nil success:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id serialized = [self.serializer deserializeJSON:responseObject error:&error];
                
                if (!serialized) {
                    reject(error);
                } else {
                    id mapped = [self.mapper mapValues:serialized toResource:resource];
                    resolve(mapped);
                }
            } else {
                id mapped = [self.mapper mapValues:responseObject toResource:resource];
                resolve(mapped);
            }
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

- (APIResponse *)findResource:(Class)resource withID:(id)resourceID;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"show" onResource:resource withArguments:@{@"id": resourceID}] parameters:nil success:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id serialized = [self.serializer deserializeJSON:responseObject error:&error];
                
                if (!serialized) {
                    reject(error);
                } else {
                    NSArray *mapped = [self.mapper mapValues:serialized toResource:resource];
                    resolve(mapped.firstObject);
                }
            } else {
                NSArray *mapped = [self.mapper mapValues:responseObject toResource:resource];
                resolve(mapped.firstObject);
            }
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

@end
