//
// APIAFNetworkingHTTPClient.m
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

#import <AFNetworking/AFHTTPSessionManager.h>

#import "APIAFNetworkingHTTPClient.h"

@interface APIAFNetworkingHTTPClient ()
@property (nonatomic, readwrite, strong) AFHTTPSessionManager *client;
@end

@implementation APIAFNetworkingHTTPClient

- (id)initWithBaseURL:(NSURL *)baseURL;
{
    return [self initWithBaseURL:baseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
}

- (id)initWithBaseURL:(NSURL *)baseURL sessionConfiguration:(NSURLSessionConfiguration *)sessionConfiguration;
{
    self = [super init];
    if (self) {
        _baseURL = baseURL;
        _sessionConfiguration = sessionConfiguration;
    }

    return self;
}

- (void)getPath:(NSString *)path
     parameters:(NSDictionary *)parameters
        success:(void (^)(id responseObject))success
        failure:(void (^)(NSError *error))failure;
{
    [self.client GET:path parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        failure(error);
    }];
}

- (AFHTTPSessionManager *)client;
{
    if (!_client) {
        _client = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL sessionConfiguration:self.sessionConfiguration];
    }

    return _client;
}

@end
