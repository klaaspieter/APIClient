//
//  APIClientConfiguration.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIRouter.h"
#import "APIHTTPClient.h"
#import "APIJSONSerializer.h"
#import "APIResponse.h"
#import "APIMapper.h"

@class APIClientConfiguration;
typedef void(^APIClientConfigurationBlock)(APIClientConfiguration *configuration);

@interface APIClientConfiguration : NSObject

@property (nonatomic, readwrite, strong) NSURL *baseURL;
@property (nonatomic, readwrite, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readwrite, strong) id<APIRouter> router;
@property (nonatomic, readwrite, strong) id<APIJSONSerializer> serializer;
@property (nonatomic, readwrite, strong) id<APIMapper> mapper;

+ (instancetype)configurationWithBlock:(APIClientConfigurationBlock)block;
+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;

- (id)initWithBlock:(APIClientConfigurationBlock)block NS_DESIGNATED_INITIALIZER;

@end

