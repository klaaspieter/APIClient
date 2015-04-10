//
// APIRouter.m
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
#import "APIRouter.h"

@implementation APIRouter

- (id)init;
{
    return [self initWithResourceNamer:nil];
}

- (id)initWithResourceNamer:(id<APIResourceNamer>)resourceNamer;
{
    if (self = [super init])
    {
        _resourceNamer = resourceNamer;
    }

    return self;
}

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    if ([action isEqualToString:@"show"]) {
        return [self pathForShowActionOnResource:resource withArguments:arguments];
    } else if ([action isEqualToString:@"index"]) {
        return [self pathForIndexActionOnResource:resource withArguments:arguments];
    }

    return nil;
}

- (NSString *)pathForShowActionOnResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    NSString *pluralizedResourceName = [self.resourceNamer pluralizedNameForResource:resource];

    if (![arguments objectForKey:@"id"]) {
        [NSException raise:NSInvalidArgumentException format:
         @"Show actions cannot be routed without an ID. Please pass in an arguments dictionary with an ”id” key."];
    }

    id resourceID = arguments[@"id"];
    if ([resourceID respondsToSelector:@selector(stringValue)]) {
        resourceID = [resourceID stringValue];
    } else if ([resourceID isKindOfClass:[NSString class]]) {
        resourceID = resourceID;
    } else {
        [NSException raise:NSInvalidArgumentException format:@"“id” argument is not a string or cannot be coerced into a string. Please pass an arguments dictionary with an “id” value that is a string or responds to the “stringValue” selector."];
    }

    return [self prefixSlashToString:[pluralizedResourceName stringByAppendingPathComponent:resourceID]];
}

- (NSString *)pathForIndexActionOnResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    return [self prefixSlashToString:[self.resourceNamer pluralizedNameForResource:resource]];
}

- (APIResourceNamer *)resourceNamer;
{
    if (!_resourceNamer) {
        _resourceNamer = [[APIResourceNamer alloc] init];
    }

    return _resourceNamer;
}

- (NSString *)prefixSlashToString:(NSString *)string;
{
    if ([string hasPrefix:@"/"]) {
        return string;
    }
    return [NSString stringWithFormat:@"/%@", string];
}

@end
