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

- (id)initWithBaseURL:(NSURL *)baseURL;

@end
