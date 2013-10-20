//
//  APIResourceNamer.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIResourceNamer.h"

@implementation APIResourceNamer

- (id)init;
{
    return [self initWithInflector:nil];
}

- (id)initWithInflector:(APIInflector *)inflector;
{
    if (self = [super init]) {
        _inflector = inflector;
    }

    return self;
}

- (NSString *)nameForResource:(Class)resource;
{
    return [self.inflector underscore:[self stringByRemovingPrefixFromResource:resource]];
}

- (NSString *)pluralizedNameForResource:(Class)resource;
{
    return [self.inflector pluralize:[self nameForResource:resource]];
}

- (NSString *)stringByRemovingPrefixFromResource:(Class)resource;
{
    NSString *className = NSStringFromClass(resource);
    NSRegularExpression *prefixRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[A-Z]+" options:0 error:nil];
    NSRange capitalsRange = [prefixRegularExpression rangeOfFirstMatchInString:className options:0 range:NSMakeRange(0, className.length)];
    NSRange prefixRange = NSMakeRange(0, capitalsRange.length - 1);
    return [className substringFromIndex:prefixRange.length];
}


- (APIInflector *)inflector;
{
    if (!_inflector) {
        _inflector = [[APIInflector alloc] init];
    }

    return _inflector;
}

@end
