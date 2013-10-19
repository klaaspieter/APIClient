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
@property (nonatomic, readwrite, strong) id<APIMappingProvider> mappingProvider;
@end

@implementation APIMapper

- (id)init;
{
    return [self initWithMappingProvider:nil];
}

- (id)initWithMappingProvider:(id<APIMappingProvider>)mappingProvider;
{
    return [self initWithInflector:nil mappingProvicer:mappingProvider];
}

- (id)initWithInflector:(id<APIInflector>)inflector mappingProvicer:(id<APIMappingProvider>)mappingProvider;
{
    if (self = [super init]) {
        _inflector = inflector;
        _mappingProvider = mappingProvider;
    }

    return self;
}

- (id)mapValues:(id)values toResource:(Class)resource;
{
    NSDictionary *mappings = [self.mappingProvider mappingsForResource:resource];
    DCKeyValueObjectMapping *parser = [self parserForResource:resource withMappings:mappings];

    NSString *root = [NSStringFromClass(resource) lowercaseString];
    return [parser parseDictionary:values[root]];
}

- (id)mapValues:(id)values toResources:(Class)resource;
{
    NSDictionary *mappings = [self.mappingProvider mappingsForResource:resource];
    DCKeyValueObjectMapping *parser = [self parserForResource:resource withMappings:mappings];

    NSString *root = [self.inflector pluralize:[NSStringFromClass(resource) lowercaseString]];
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

- (id<APIInflector>)inflector;
{
    if (!_inflector) {
        _inflector = [[APIInflector alloc] init];
    }

    return _inflector;
}

@end
