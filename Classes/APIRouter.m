//
//  APIRouter.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIRouter.h"

@implementation APIRouter

@synthesize inflector = _inflector;

- (id)init;
{
    return [self initWithInflector:[[APIInflector alloc] init]];
}

- (id)initWithInflector:(id<APIInflector>)inflector;
{
    if (self = [super init])
    {
        _inflector = inflector;
    }

    return self;
}

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
{
    NSString *pluralizedResourceName = [self.inflector pluralize:[self unprefixedNameForResource:resource]];
    return [NSString stringWithFormat:@"/%@", pluralizedResourceName];
}

- (NSString *)unprefixedNameForResource:(Class)resource;
{
    NSString *className = NSStringFromClass(resource);
    NSRegularExpression *prefixRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]+" options:0 error:nil];
    NSRange capitalsRange = [prefixRegularExpression rangeOfFirstMatchInString:className options:0 range:NSMakeRange(0, className.length)];
    NSRange prefixRange = NSMakeRange(0, capitalsRange.length - 1);
    return [[className substringFromIndex:prefixRange.length] lowercaseString];
}

@end
