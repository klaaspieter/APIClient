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

@interface APITestHTTPClientRequest ()
@property (nonatomic, readwrite, strong) Resolver *resolver;
+ (instancetype)requestWithMethod:(NSString *)method path:(NSString *)path resolver:(Resolver *)resolver;
- (id)initWithMethod:(NSString *)method path:(NSString *)path resolver:(Resolver *)resolver;
@end

@implementation APITestHTTPClientRequest
+ (instancetype)requestWithMethod:(NSString *)method path:(NSString *)path resolver:(Resolver *)resolver;
{
    return [[self alloc] initWithMethod:method path:path resolver:resolver];
}

- (id)init;
{
    return [self initWithMethod:nil path:nil resolver:nil];
}

- (id)initWithMethod:(NSString *)method path:(NSString *)path resolver:(Resolver *)resolver;
{
    NSParameterAssert(method);
    NSParameterAssert(path);
    NSParameterAssert(resolver);
    self = [super init];
    if (self) {
        _method = method;
        _path = path;
        _resolver = resolver;
    }

    return self;
}
@end

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
    Resolver *resolver = [Resolver resolverWithSuccess:success failure:failure];
    APITestHTTPClientRequest *request = [APITestHTTPClientRequest requestWithMethod:@"get" path:path resolver:resolver];
    [self.mutableRequests addObject:request];
}

- (void)postPath:(NSString *)path
      parameters:(NSDictionary *)parameters
         success:(void (^)(id))success
         failure:(void (^)(NSError *))failure;
{
    Resolver *resolver = [Resolver resolverWithSuccess:success failure:failure];
    APITestHTTPClientRequest *request = [APITestHTTPClientRequest requestWithMethod:@"post" path:path resolver:resolver];
    [self.mutableRequests addObject:request];
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

- (void)succeedRequests;
{
    [self succeedRequestsWithJSONObject:@{}];
}

- (void)succeedRequestsWithJSONObject:(id)object;
{
    [self.mutableRequests enumerateObjectsUsingBlock:^(APITestHTTPClientRequest *request, NSUInteger idx, BOOL *stop) {
        NSData *json = [NSJSONSerialization dataWithJSONObject:object options:0 error:nil];
        request.resolver.success(json);
    }];
}

- (void)failRequests;
{
    [self.mutableRequests enumerateObjectsUsingBlock:^(APITestHTTPClientRequest *request, NSUInteger idx, BOOL *stop) {
        request.resolver.failure([@"[]" dataUsingEncoding:NSUTF8StringEncoding]);
    }];
}

@end
