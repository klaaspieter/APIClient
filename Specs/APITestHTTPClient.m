//
//  APITestHTTPClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APITestHTTPClient.h"

@interface APITestHTTPClient ()
@property (nonatomic, readwrite, copy) NSMutableArray *mutableRequests;
@end

@implementation APITestHTTPClient

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    if (self = [super init])
    {
        _baseURL = baseURL;
    }

    return self;
}


- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
{
     [self.mutableRequests addObject:path];
}

- (NSMutableArray *)mutableRequests;
{
    if (!_mutableRequests)
        _mutableRequests = [NSMutableArray array];

    return _mutableRequests;
}

- (NSArray *)requests;
{
    return [self.mutableRequests copy];
}

@end
