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
    if (self = [super init])
    {
        _inflector = [[APIInflector alloc] init];
    }

    return self;
}

- (NSString *)pathForAction:(NSString *)action onResource:(Class)resource;
{
    return nil;
}

@end
