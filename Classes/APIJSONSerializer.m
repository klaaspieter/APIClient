//
//  APIJSONSerializer.m
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import "APIJSONSerializer.h"

NSString *const APIJSONSerializerErrorDomain = @"APIJSONSerializerErrorDomain";

@implementation APIJSONSerializer

- (id)deserializeJSON:(NSData *)json error:(NSError *__autoreleasing *)error;
{
    NSError *serializationError;
    id object = [NSJSONSerialization JSONObjectWithData:json options:0 error:&serializationError];

    if (!object && error) {
        *error = [NSError errorWithDomain:APIJSONSerializerErrorDomain code:0 userInfo:@{NSUnderlyingErrorKey: serializationError}];
    }

    return object;
}

@end
