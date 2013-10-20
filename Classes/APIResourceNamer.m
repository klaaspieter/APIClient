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
    return nil;
}

- (APIInflector *)inflector;
{
    if (!_inflector) {
        _inflector = [[APIInflector alloc] init];
    }

    return _inflector;
}

@end
