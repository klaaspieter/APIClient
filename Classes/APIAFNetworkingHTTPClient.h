//
//  APIAFNetworkingHTTPClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "APIHTTPClient.h"

@interface APIAFNetworkingHTTPClient : NSObject <APIHTTPClient>

@property (nonatomic, readonly, copy) NSURL *baseURL;
@property (nonatomic, readonly, strong) NSURLSessionConfiguration *sessionConfiguration;

- (id)initWithBaseURL:(NSURL *)baseURL;
- (id)initWithBaseURL:(NSURL *)baseURL
 sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration NS_DESIGNATED_INITIALIZER;

@end
