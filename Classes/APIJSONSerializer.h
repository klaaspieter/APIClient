//
//  APIJSONSerializer.h
//  APIClient
//
//  Created by Klaas Pieter Annema on 20-09-13.
//  Copyright (c) 2013 Klaas Pieter Annema. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXTERN NSString *const APIJSONSerializerErrorDomain;

@protocol APIJSONSerializer <NSObject>
- (id)deserializeJSON:(NSData *)json error:(NSError **)error;
@end

@interface APIJSONSerializer : NSObject <APIJSONSerializer>

@end
