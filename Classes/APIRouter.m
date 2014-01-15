//
//  APIRouter.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

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

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
{
    return [self pathForAction:action onResource:resource withArguments:nil];
}

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    if ([action isEqualToString:@"show"]) {
        return [self pathForShowActionOnResource:resource withArguments:arguments];
    } else if ([action isEqualToString:@"index"]) {
        return [self pathForIndexActionOnResource:resource withArguments:arguments];
    } else if ([action isEqualToString:@"create"]) {
        return [self pathForCreateActionOnResource:resource withArguments:arguments];
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

    return [pluralizedResourceName stringByAppendingPathComponent:resourceID];
}

- (NSString *)pathForIndexActionOnResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    return [self.resourceNamer pluralizedNameForResource:resource];
}

- (NSString *)pathForCreateActionOnResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    return [self.resourceNamer pluralizedNameForResource:resource];
}

- (APIResourceNamer *)resourceNamer;
{
    if (!_resourceNamer) {
        _resourceNamer = [[APIResourceNamer alloc] init];
    }

    return _resourceNamer;
}

@end
