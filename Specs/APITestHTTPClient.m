//
//  APITestHTTPClient.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 30-08-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APITestHTTPClient.h"

typedef void(^RequestResolver)(id object);

@interface Resolver : NSObject
@property (nonatomic, readonly, copy) RequestResolver success;
@property (nonatomic, readonly, copy) RequestResolver failure;

+ (instancetype)resolverWithSuccess:(RequestResolver)success failure:(RequestResolver)failure;
@end

@implementation Resolver
+ (instancetype)resolverWithSuccess:(RequestResolver)success failure:(RequestResolver)failure;
{
    return [[self alloc] initWithSuccess:success failure:failure];
}

- (id)initWithSuccess:(RequestResolver)success failure:(RequestResolver)failure;
{
    if (self = [super init])
    {
        _success = success;
        _failure = failure;
    }

    return self;
}

@end

@interface APITestHTTPClient ()
@property (nonatomic, readwrite, copy) NSMutableDictionary *mutableRequests;
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
    Resolver *resolver = [Resolver resolverWithSuccess:success failure:failure];
    [self.mutableRequests setObject:resolver forKey:path];
}

- (NSMutableDictionary *)mutableRequests;
{
    if (!_mutableRequests)
        _mutableRequests = [NSMutableDictionary dictionary];

    return _mutableRequests;
}

- (NSArray *)requests;
{
    return [self.mutableRequests allKeys];
}

- (void)succeedRequests;
{
    for (NSString *path in self.mutableRequests)
    {
        Resolver *resolver = self.mutableRequests[path];
        resolver.success([@"{}" dataUsingEncoding:NSUTF8StringEncoding]);
    }
}

- (void)failRequests;
{
    for (NSString *path in self.mutableRequests)
    {
        Resolver *resolver = self.mutableRequests[path];
        resolver.failure([@"{}" dataUsingEncoding:NSUTF8StringEncoding]);
    }
}

@end
