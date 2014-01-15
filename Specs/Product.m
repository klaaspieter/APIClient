//
//  Product.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 10-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "Product.h"

@implementation Product

+ (instancetype)productWithName:(NSString *)name balanceIncrease:(double)balanceIncrease;
{
    return [[self alloc] initWithName:name balanceIncrease:balanceIncrease];
}

- (id)init;
{
    return [self initWithName:nil balanceIncrease:0];
}

- (id)initWithName:(NSString *)name balanceIncrease:(double)balanceIncrease;
{
    self = [super init];
    if (self) {
        _name = name;
        _balanceIncrease = balanceIncrease;
    }

    return self;
}

@end
