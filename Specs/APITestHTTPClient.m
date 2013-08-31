//
//  APITestHTTPClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APITestHTTPClient.h"

@implementation APITestHTTPClient

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    if (self = [super init])
    {
        _baseURL = baseURL;
    }

    return self;
}

@end
