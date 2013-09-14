//
//  APIClientConfiguration.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIRouter.h"
#import "APIAFNetworkingHTTPClient.h"
#import "APIResponse.h"

@interface APIClientConfiguration : NSObject

@property (nonatomic, readonly, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readonly, strong) id<APIRouter> router;

+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;
- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient router:(id<APIRouter>)router;

@end
