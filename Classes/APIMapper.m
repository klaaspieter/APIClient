//
//  APIMapper.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIMapper.h"

#import "DCKeyValueObjectMapping.h"
#import "DCParserConfiguration.h"
#import "DCObjectMapping.h"

@interface APIMapper ()
@end

@implementation APIMapper

- (id)init;
{
    return [self initWithMappingProvider:nil];
}

- (id)initWithMappingProvider:(id<APIMappingProvider>)mappingProvider;
{
    return [self initWithResourceNamer:nil mappingProvider:mappingProvider];
}

- (id)initWithResourceNamer:(id<APIResourceNamer>)resourceNamer mappingProvider:(id<APIMappingProvider>)mappingProvider;
{
    if (self = [super init]) {
        _resourceNamer = resourceNamer;
        _mappingProvider = mappingProvider;
    }

    return self;
}

- (NSString *)rootForResource:(Class)resource;
{
    return [self.resourceNamer pluralizedNameForResource:resource];
}

- (id)mapValues:(id)values toResource:(Class)resource;
{
    NSDictionary *mappings = [self.mappingProvider mappingsForResource:resource];
    DCKeyValueObjectMapping *parser = [self parserForResource:resource withMappings:mappings];

    NSString *root = [self rootForResource:resource];
    return [parser parseArray:values[root]];
}

- (DCKeyValueObjectMapping *)parserForResource:(Class)resource withMappings:(NSDictionary *)mappings;
{
    DCParserConfiguration *config = [DCParserConfiguration configuration];

    [mappings enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        DCObjectMapping *mapping = [DCObjectMapping mapKeyPath:key toAttribute:obj onClass:resource];
        [config addObjectMapping:mapping];
    }];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:resource andConfiguration:config];

    return parser;
}

- (id<APIResourceNamer>)resourceNamer;
{
    if (!_resourceNamer) {
        _resourceNamer = [[APIResourceNamer alloc] init];
    }

    return _resourceNamer;
}

@end
