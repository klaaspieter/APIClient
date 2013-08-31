//
//  APIHTTPClient.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIHTTPClient <NSObject>

- (id)initWithBaseURL:(NSURL *)baseURL;

- (NSURL *)baseURL;

@end