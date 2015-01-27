//
// APIClient.h
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

#import <Foundation/Foundation.h>

#import "APIClientConfiguration.h"

#import "APIRouter.h"
#import "APIHTTPClient.h"
#import "APIResponse.h"
#import "APIJSONSerializer.h"

@interface APIClient : NSObject

@property (nonatomic, readonly, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readonly, strong) id<APIRouter> router;
@property (nonatomic, readonly, strong) id<APIJSONSerializer> serializer;
@property (nonatomic, readonly, strong) id<APIMapper>mapper;

+ (instancetype)clientWithConfigurationBlock:(APIClientConfigurationBlock)block;
+ (instancetype)clientWithBaseURL:(NSURL *)baseURL;
- (id)initWithBaseURL:(NSURL *)baseURL;

- (id)initWithConfiguration:(APIClientConfiguration *)configuration;

- (APIResponse *)findAll:(Class)resource;
- (APIResponse *)findResource:(Class)resource withID:(id)resourceID;

@end
