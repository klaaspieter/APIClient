//
// APIClientConfiguration.h
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

#import "APIRouter.h"
#import "APIHTTPClient.h"
#import "APIJSONSerializer.h"
#import "APIResponse.h"
#import "APIMapper.h"

@class APIClientConfiguration;
typedef void(^APIClientConfigurationBlock)(APIClientConfiguration *configuration);

@interface APIClientConfiguration : NSObject

@property (nonatomic, readwrite, strong) NSURL *baseURL;
@property (nonatomic, readwrite, strong) id<APIHTTPClient> httpClient;
@property (nonatomic, readwrite, strong) id<APIRouter> router;
@property (nonatomic, readwrite, strong) id<APIJSONSerializer> serializer;
@property (nonatomic, readwrite, strong) id<APIMapper> mapper;

+ (instancetype)configurationWithBlock:(APIClientConfigurationBlock)block;
+ (instancetype)configurationWithBaseURL:(NSURL *)baseURL;

- (id)initWithBlock:(APIClientConfigurationBlock)block NS_DESIGNATED_INITIALIZER;

@end

