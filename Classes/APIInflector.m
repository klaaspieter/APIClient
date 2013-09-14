//
//  APIInflector.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 14-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIInflector.h"

#import "TTTStringInflector.h"

@implementation APIInflector

- (NSString *)pluralize:(NSString *)string;
{
    return [[TTTStringInflector defaultInflector] pluralize:string];
}

@end
