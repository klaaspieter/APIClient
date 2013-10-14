//
//  APIJSONSerializer.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIJSONSerializer.h"

@implementation APIJSONSerializer

- (id)deserializeJSON:(NSData *)json;
{
    NSData *jsonData = json;
    NSError *error;
    id object = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];

    if (!object)
        [NSException raise:NSInternalInconsistencyException format:@"JSON could not be deserialized. Please make sure your server is returning valid JSON."];

    return object;
}

@end
