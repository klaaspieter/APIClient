//
//  APIClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIClientConfiguration.h"

#import "APIRouter.h"
#import "APIAFNetworkingHTTPClient.h"
#import "APIResponse.h"
#import "APIJSONSerializer.h"

@interface APIClient : NSObject

@property (nonatomic, readonly, strong) APIClientConfiguration *configuration;

+ (instancetype)clientWithConfigurationBlock:(APIClientConfigurationBlock)block;
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
- (id)initWithBaseURL:(NSURL *)baseURL;
- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient
                  router:(id<APIRouter>)router
              serializer:(id<APIJSONSerializer>)serializer
                  mapper:(id<APIMapper>)mapper;

- (id)initWithConfiguration:(APIClientConfiguration *)configuration;

- (APIResponse *)findAll:(Class)resource;
- (APIResponse *)findResource:(Class)resource withID:(id)resourceID;

@end
