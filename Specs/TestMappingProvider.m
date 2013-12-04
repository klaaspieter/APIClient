//
//  TestMappingProvider.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 15-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "TestMappingProvider.h"

@implementation TestMappingProvider

- (NSDictionary *)mappingsForResource:(Class)resource;
{
    return @{@"name": @"name", @"price": @"price"};
}

@end
