//
//  APITestHTTPClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIHTTPClient.h"

@interface APITestHTTPClient : NSObject <APIHTTPClient>

@property (nonatomic, readonly, strong) NSURL *baseURL;
@property (nonatomic, readonly, strong) NSArray *requests;

- (id)initWithBaseURL:(NSURL *)baseURL;

- (void)succeedRequests;
- (void)failRequests;

@end
