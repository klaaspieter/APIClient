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
    return [self.resourceNamer pluralizedNameForResource:resource];
}

- (NSString *)pathForShowActionOnResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    NSString *pluralizedResourceName = [self.resourceNamer pluralizedNameForResource:resource];
    return [pluralizedResourceName stringByAppendingPathComponent:[arguments[@"id"] stringValue]];
}

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource withArguments:(NSDictionary *)arguments;
{
    if ([action isEqualToString:@"show"]) {
        return [self pathForShowActionOnResource:resource withArguments:arguments];
    }

    return nil;
}

- (APIResourceNamer *)resourceNamer;
{
    if (!_resourceNamer) {
        _resourceNamer = [[APIResourceNamer alloc] init];
    }

    return _resourceNamer;
}

@end
