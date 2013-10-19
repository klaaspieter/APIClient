//
//  Mapper.m
//  Example
//
//  Created by Klaas Pieter Annema on 19-10-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "Mapper.h"

@implementation Mapper

- (id)mapValues:(id)values toResource:(Class)resource;
{
    NSDictionary *valuesDictionary = (NSDictionary *)values;
    values = valuesDictionary[@"data"];
    return [super mapValues:values toResource:resource];
}

@end
