//
//  APITestHTTPClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "APIHTTPClient.h"

@interface APITestHTTPClientRequest : NSObject
@property (nonatomic, readonly, strong) NSString *path;
@property (nonatomic, readonly, strong) NSString *method;
@end

@interface APITestHTTPClient : NSObject <APIHTTPClient>

@property (nonatomic, readonly, strong) NSURL *baseURL;
@property (nonatomic, readonly, strong) NSArray *requests;

- (id)initWithBaseURL:(NSURL *)baseURL;

- (void)succeedRequests;
- (void)succeedRequestsWithJSONObject:(id)object;
- (void)failRequests;

@end
