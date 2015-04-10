//
// APIClient.m
//
// Copyright (c) 2015 Klaas Pieter Annema (http://annema.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "APIClient.h"

@interface APIClient ()
@property (nonatomic, readwrite, copy) NSURL *baseURL;
@property (nonatomic, readwrite, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readwrite, strong) id<APIRouter> router;
@property (nonatomic, readwrite, strong) id<APIJSONSerializer> serializer;
@property (nonatomic, readwrite, strong) id<APIMapper>mapper;
@end

@implementation APIClient

- (id)init;
{
    return [self initWithBaseURL:nil];
}

+ (instancetype)clientWithConfigurationBlock:(APIClientConfigurationBlock)block;
{
    return [[self alloc] initWithConfiguration:[APIClientConfiguration configurationWithBlock:block]];
}

+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
{
    return [[self alloc] initWithBaseURL:baseURL];
}

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    return [self initWithConfiguration:[APIClientConfiguration configurationWithBaseURL:baseURL]];
}

- (id)initWithConfiguration:(APIClientConfiguration *)configuration;
{
    if (self = [super init])
    {
        _httpClient = configuration.httpClient;
        _router = configuration.router;
        _serializer = configuration.serializer;
        _mapper = configuration.mapper;
    }

    return self;
}

- (APIResponse *)findAll:(Class)resource;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"index" onResource:resource withArguments:nil] parameters:nil success:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id serialized = [self.serializer deserializeJSON:responseObject error:&error];
                
                if (!serialized) {
                    reject(error);
                } else {
                    id mapped = [self.mapper mapValues:serialized toResource:resource];
                    resolve(mapped);
                }
            } else {
                id mapped = [self.mapper mapValues:responseObject toResource:resource];
                resolve(mapped);
            }
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

- (APIResponse *)findResource:(Class)resource withID:(id)resourceID;
{
    APIResponse *response = [[APIResponse alloc] initWithResolver:^(APIResponseBlock resolve, APIResponseBlock reject) {
        [self.httpClient getPath:[self.router pathForAction:@"show" onResource:resource withArguments:@{@"id": resourceID}] parameters:nil success:^(id responseObject) {
            if ([responseObject isKindOfClass:[NSData class]]) {
                NSError *error;
                id serialized = [self.serializer deserializeJSON:responseObject error:&error];
                
                if (!serialized) {
                    reject(error);
                } else {
                    NSArray *mapped = [self.mapper mapValues:serialized toResource:resource];
                    resolve(mapped.firstObject);
                }
            } else {
                NSArray *mapped = [self.mapper mapValues:responseObject toResource:resource];
                resolve(mapped.firstObject);
            }
        } failure:^(NSError *error) {
            reject(error);
        }];
    }];
    return response;
}

@end
