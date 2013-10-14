//
//  HTTPClient.m
//  Example
//
//  Created by Klaas Pieter Annema on 22-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method path:(NSString *)path parameters:(NSDictionary *)parameters
{
    path = [path stringByAppendingString:@"?key=0cddf7ec249232832da492429491d3f4"];
    return [super requestWithMethod:method path:path parameters:parameters];
}

@end
