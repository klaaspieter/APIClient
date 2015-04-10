//
// APIClientConfiguration.m
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

#import "APIClientConfiguration.h"

@interface APIClientConfiguration ()
@end

@implementation APIClientConfiguration

+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;
{
    return [self configurationWithBlock:^(APIClientConfiguration *configuration) {
        configuration.baseURL = baseURL;
    }];
}

+ (instancetype)configurationWithBlock:(APIClientConfigurationBlock)block;
{
    return [[self alloc] initWithBlock:block];
}

- (id)init;
{
    return [self initWithBlock:nil];
}

- (id)initWithBlock:(APIClientConfigurationBlock)block;
{
    NSParameterAssert(block);
    self = [super init];
    if (self) {
        block(self);
        [self verifyExistenceOfHTTPClient];
    }

    return self;
}

- (NSURL *)baseURL;
{
    return self.httpClient.baseURL;
}

- (void)setBaseURL:(NSURL *)baseURL;
{
    _httpClient = [[APIHTTPClient alloc] initWithBaseURL:baseURL sessionConfiguration:self.sessionConfiguration];
}

- (NSURLSessionConfiguration *)sessionConfiguration;
{
    return self.httpClient.sessionConfiguration;
}

- (void)setSessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;
{
    _httpClient = [[APIHTTPClient alloc] initWithBaseURL:self.baseURL sessionConfiguration:sessionConfiguration];
}

- (id<APIRouter>)router;
{
    if (!_router) {
        _router = [[APIRouter alloc] init];
    }

    return _router;
}

- (id<APIJSONSerializer>)serializer;
{
    if (!_serializer) {
        _serializer = [[APIJSONSerializer alloc] init];
    }

    return _serializer;
}

- (id<APIMapper>)mapper;
{
    if (!_mapper) {
        _mapper = [[APIMapper alloc] init];
    }

    return _mapper;
}

- (void)verifyExistenceOfHTTPClient;
{
    if (self.httpClient) {
        return;
    }

    [NSException raise:NSInternalInconsistencyException format:@"A httpClient must exist after creating a configuration. You can specify a http client by creating one yourself or by setting the baseURL."];
}

@end