//
//  APIMapper.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 13-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIMapper.h"

#import "DCKeyValueObjectMapping.h"

@implementation APIMapper

- (id)mapValues:(id)values toResource:(Class)resource;
{
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:resource];

    if ([values isKindOfClass:[NSArray class]]) {
        return [parser parseArray:values];
    } else {
        return [parser parseDictionary:values];
    }
}

@end
