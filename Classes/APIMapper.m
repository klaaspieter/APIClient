//
// APIMapper.m
//
// Copyright (c) 2015 Klaas Pieter Annema (http://annema.me)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "APIMapper.h"

#import <DCKeyValueObjectMapping/DCKeyValueObjectMapping.h>
#import <DCKeyValueObjectMapping/DCParserConfiguration.h>
#import <DCKeyValueObjectMapping/DCObjectMapping.h>

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
