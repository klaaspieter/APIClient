//
//  APIClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIAFNetworkingHTTPClient.h"

@interface APIClient : NSObject

@property (nonatomic, readonly, strong) NSURL *baseURL;
@property (nonatomic, readonly, strong) id<APIHTTPClient> httpClient;

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
- (id)initWithHTTPClient:(id<APIHTTPClient>)httpClient;

@end
