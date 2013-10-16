//
//  APIMapper.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIMapper.h"

#import "KZPropertyMapper.h"

@implementation APIMapper

- (id)init;
{
    return [self initWithMappingProvider:nil];
}

- (id)initWithMappingProvider:(id<APIMappingProvider>)mappingProvider;
{
    if (self = [super init]) {
        _mappingProvider = mappingProvider;
    }

    return self;
}

- (BOOL)mapValuesFrom:(id)values toInstance:(id)instance;
{
    NSAssert(self.mappingProvider, @"Attempt to map a resource without a mapping provider. Please assign a mapping provider to your mapper using apiClient.configuration.mapper.mappingProvider = <YOUR PROVIDER>.");

    NSDictionary *mapping = [self.mappingProvider mappingForResource:[instance class]];
    return [KZPropertyMapper mapValuesFrom:values toInstance:instance usingMapping:mapping];
}

@end
