//
//  APIClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

- (id)init;
{
    return [self initWithBaseURL:nil];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithBaseURL:baseURL];
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    NSParameterAssert(baseURL);
    if (self = [super init])
    {
        _baseURL = baseURL;
    }

    return self;
}

@end
