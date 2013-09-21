//
//  APIJSONSerializer.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIJSONSerializer.h"

@implementation APIJSONSerializer

- (id)deserializeJSON:(NSString *)json;
{
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
}

@end
