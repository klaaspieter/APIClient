//
//  APITestMappingProvider.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 15-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APITestMappingProvider.h"

@implementation APITestMappingProvider

- (NSDictionary *)mappingForResource:(Class)resource;
{
    return @{@"name": @"name", @"price": @"price"};
}

@end
